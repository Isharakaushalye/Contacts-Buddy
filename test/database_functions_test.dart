import 'package:contacts_buddy/database/database_service.dart';
import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/models/contact_number.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('DatabaseService', () {
    late DatabaseService databaseService;

    setUp(() {
      sqfliteFfiInit();

      databaseFactory = databaseFactoryFfi;
      databaseService = DatabaseService();
    });

    test('Insert Contact', () async {
      final contact = Contact(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        lastCalled: '',
        isFavorite: 0,
        numbers: [
          ContactNumber(id: 1, contactId: 1, numberDefinition: 'mobile', phoneNumber: '123-456-7890'),
          ContactNumber(id: 2, contactId: 1, numberDefinition: 'home', phoneNumber: '987-654-3210'),
        ],
      );

      await databaseService.insertContact(contact);

      final retrievedContact = await databaseService.getContact(contact.id!);

      expect(retrievedContact, isNotNull);
      expect(retrievedContact!.firstName, contact.firstName);
      expect(retrievedContact.lastName, contact.lastName);
      expect(retrievedContact.numbers!.length, contact.numbers!.length);

      for (var i = 0; i < retrievedContact.numbers!.length; i++) {
        expect(retrievedContact.numbers![i].numberDefinition, contact.numbers![i].numberDefinition);
        expect(retrievedContact.numbers![i].phoneNumber, contact.numbers![i].phoneNumber);
      }
    });

    test('Get All Contacts', () async {
      final allContacts = await databaseService.getAllContacts();

      expect(allContacts, isNotNull);
    });

    test('Search Contact By Name', () async {
      final contact = Contact(
        firstName: 'John',
        lastName: 'Doe',
        numbers: [
          ContactNumber(numberDefinition: 'mobile', phoneNumber: '123-456-7890'),
        ],
      );
      await databaseService.insertContact(contact);

      final searchResults = await databaseService.searchContactByName(searchCriteria: 'John');

      expect(searchResults, isNotNull);
      expect(searchResults!.length, greaterThanOrEqualTo(1));
    });

    test('Search Contact By Phone Number', () async {

      final contact = Contact(
        firstName: 'John',
        lastName: 'Doe',
        numbers: [
          ContactNumber(numberDefinition: 'mobile', phoneNumber: '123-456-7890'),
        ],
      );
      await databaseService.insertContact(contact);

      final searchResults = await databaseService.searchContactByPhoneNumber(searchCriteria: '123-456-7890');

      expect(searchResults, isNotNull);
      expect(searchResults!.length, greaterThanOrEqualTo(1));
    });

    test('Update Contact', () async {

      final contact = Contact(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        numbers: [
          ContactNumber(id: 1, contactId: 1, numberDefinition: 'mobile', phoneNumber: '123-456-7890'),
        ],
      );
      await databaseService.insertContact(contact);

      final retrievedContact = await databaseService.getContact(contact.id!);

      retrievedContact!.firstName = 'UpdatedJohn';
      retrievedContact.numbers!.first.phoneNumber = '987-654-3210';

      await databaseService.updateContact(retrievedContact);

      final updatedContact = await databaseService.getContact(retrievedContact.id!);

      expect(updatedContact!.firstName, 'UpdatedJohn');
      expect(updatedContact.numbers!.first.phoneNumber, '987-654-3210');
    });

    test('Delete Contact', () async {
      final contact = Contact(
        id: 1,
        firstName: 'John',
        lastName: 'Doe',
        numbers: [
          ContactNumber(id: 1, contactId: 1, numberDefinition: 'mobile', phoneNumber: '123-456-7890'),
        ],
      );
      await databaseService.insertContact(contact);

      final retrievedContact = await databaseService.getContact(contact.id!);

      await databaseService.deleteContact(retrievedContact!.id!);

      final deletedContact = await databaseService.getContact(retrievedContact.id!);

      expect(deletedContact, isNull);
    });
  });
}
