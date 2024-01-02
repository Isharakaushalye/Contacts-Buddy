import 'dart:developer' as developer;

import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/models/contact_number.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static const String tableContact = 'contact';
  static const String tableContactNumber = 'contact_number';
  static const String tableContactView = 'contact_view';

  static const String contactColumnId = 'id';
  static const String tableContactNumberForeignKey = 'contactId';

  static DatabaseService? _instance;
  Database? _database;

  DatabaseService._();

  factory DatabaseService() {
    _instance ??= DatabaseService._();
    return _instance!;
  }

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = '${await getDatabasesPath()}contacts.db';
    developer.log('(_initializeDatabase) Database path: $databasePath');

    // Clear only if necessary
    // await deleteDatabase(databasePath);

    return await openDatabase(
      databasePath,
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE contact (id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, company VARCHAR(20), email VARCHAR(20), address TEXT, notes TEXT, isFavorite INTEGER, lastCalled VARCHAR(20))');
        await db.execute(
            'CREATE TABLE contact_number (id INTEGER PRIMARY KEY, contactId INTEGER, numberDefinition VARCHAR(10), phoneNumber VARCHAR(15), FOREIGN KEY(contactId) REFERENCES contact(id))');
        await db.execute(
            'CREATE VIEW contact_view AS SELECT c.id AS contact_id, c.firstName, c.lastName, c.company, c.email, c.address, c.notes, cn.id AS number_id, cn.numberDefinition, cn.phoneNumber FROM contact c JOIN contact_number cn ON c.id = cn.contactId');
      },
    );
  }

  Future<List<Contact>?> getAllContacts({bool onlyFavorite = false, bool onlyRecent = false}) async {
    List<Contact>? contactList = [];
    final db = await database;
    List<Map<String, Object?>> contacts;
    try {
      if (onlyFavorite) {
        contacts = await db.query(
          tableContact,
          where: 'isFavorite = ?',
          whereArgs: [1],
          orderBy: 'firstName',
        );
      } else if (onlyRecent) {
        contacts = await db.query(
          tableContact,
          where: 'lastCalled != ?',
          whereArgs: [''],
          orderBy: 'lastCalled DESC',
        );
      } else {
        contacts = await db.query(tableContact, orderBy: 'firstName');
      }

      for (var contact in contacts) {
        contactList.add(Contact.fromMap(contact));
      }
      developer.log('(getAllContacts) contactList: $contactList');
      return contactList;
    } catch (e) {
      developer.log('(getAllContacts) Error: $e');
      return null;
    }
  }

  Future<List<Contact>?> searchContactByName({required String searchCriteria}) async {
    List<Contact>? contactList = [];
    final db = await database;
    final String wildcard = '%$searchCriteria%';
    try {
      final contacts = await db
          .query(tableContact, where: 'firstName LIKE ? OR lastName LIKE ?', whereArgs: [wildcard, wildcard]);
      for (var contact in contacts) {
        contactList.add(Contact.fromMap(contact));
      }
      return contactList;
    } catch (e) {
      developer.log('(searchContactByName) Error: $e');
      return null;
    }
  }

  Future<List<Contact>?> searchContactByPhoneNumber({required String searchCriteria}) async {
    List<Contact>? contactList = [];
    final db = await database;
    final String wildcard = '%$searchCriteria%';
    try {
      final contacts = await db.query(tableContactView, where: 'phoneNumber LIKE ?', whereArgs: [wildcard]);
      for (var contact in contacts) {
        contactList.add(Contact.fromMap(contact).copyWith(id: contact['contact_id'] as int));
      }
      return contactList;
    } catch (e) {
      developer.log('(searchContactByPhoneNumber) Error: $e');
      return null;
    }
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        // Insert contact information
        contact.id = await txn.insert(tableContact, contact.toMap());
        for (var number in contact.numbers!) {
          await txn.insert(
            tableContactNumber,
            ContactNumber(
              contactId: contact.id,
              numberDefinition: number.numberDefinition,
              phoneNumber: number.phoneNumber,
            ).toMap(),
          );
        }
        developer.log('(insertContact) Contact added with ID: ${contact.id}');
      });
    } catch (e) {
      developer.log('(insertContact) Error: $e');
    }
  }

  Future<Contact?> getContact(int contactId) async {
    final db = await database;
    //Get contact information
    List<Map> maps = await db.query(tableContact, where: '$contactColumnId = ?', whereArgs: [contactId]);

    //Get phone numbers
    if (maps.isNotEmpty) {
      var contact = Contact.fromMap(maps.first).copyWith(numbers: []);

      List<Map> numbers = await db
          .query(tableContactNumber, where: '$tableContactNumberForeignKey = ?', whereArgs: [contactId]);
      if (numbers.isNotEmpty) {
        contact.numbers!.addAll(numbers.map((number) {
          return ContactNumber.fromMap(number);
        }).toList());
      }
      return contact;
    }
    return null;
  }

  Future<void> updateContact(Contact updatedContact) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        //Update contact
        await txn.update(tableContact, updatedContact.toMap(),
            where: '$contactColumnId = ?', whereArgs: [updatedContact.id]);
        //Update phone numbers
        if (updatedContact.numbers != null && updatedContact.numbers!.isNotEmpty) {
          await txn.delete(tableContactNumber,
              where: '$tableContactNumberForeignKey = ?', whereArgs: [updatedContact.id]);
          for (var number in updatedContact.numbers!) {
            await txn.insert(
              tableContactNumber,
              ContactNumber(
                contactId: updatedContact.id,
                numberDefinition: number.numberDefinition,
                phoneNumber: number.phoneNumber,
              ).toMap(),
            );
          }
        }
        developer.log('(updateContact) Contact updated with ID: ${updatedContact.id}');
      });
    } catch (e) {
      developer.log('(updateContact) Error: $e');
    }
  }

  Future<void> deleteContact(int id) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        //Remove contact numbers from the contact_number table first to prevent foreign key violations
        await txn.delete(tableContactNumber, where: '$tableContactNumberForeignKey = ?', whereArgs: [id]);
        //Remove actual contact
        await txn.delete(tableContact, where: '$contactColumnId = ?', whereArgs: [id]);
      });
      developer.log('(deleteContact) Contact deleted with ID: $id');
    } catch (e) {
      developer.log('(deleteContact) Error: $e');
    }
  }
}
