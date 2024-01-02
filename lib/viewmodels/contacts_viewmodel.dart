import 'package:contacts_buddy/database/database_service.dart';
import 'package:contacts_buddy/models/contact.dart';
import 'package:flutter/material.dart';

class ContactsViewModel extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  final databaseService = DatabaseService();
  int selectedTab = 1;

  List<Contact> contactList = [];

  getAllContacts() async {
    if (selectedTab == 0) {
      contactList = await databaseService.getAllContacts(onlyRecent: true) ?? [];
    } else if (selectedTab == 1) {
      contactList = await databaseService.getAllContacts() ?? [];
    } else if (selectedTab == 2) {
      contactList = await databaseService.getAllContacts(onlyFavorite: true) ?? [];
    }
    notifyListeners();
  }

  searchContact() async {
    RegExp regex = RegExp(r'^[0-9]+$');
    if (regex.hasMatch(searchController.text)) {
      contactList =
          await databaseService.searchContactByPhoneNumber(searchCriteria: searchController.text) ?? [];
    } else {
      contactList = await databaseService.searchContactByName(searchCriteria: searchController.text) ?? [];
    }

    notifyListeners();
  }

  switchTabs(int index) {
    selectedTab = index;
    notifyListeners();
  }
}
