import 'package:contacts_buddy/database/database_service.dart';
import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        final databaseService = DatabaseService();
        //** Get all contacts */
        databaseService.getAllContacts();
        //** Search by first name or last name */
        // final contacts = await databaseService.searchContactByName(searchCriteria: 'First');
        // print(contacts);
        //** Search by phoneNumber */
        // final contacts =
        //     await databaseService.searchContactByPhoneNumber(searchCriteria: '');
        // print(contacts);
        //** Insert */
        // databaseService.insertContact(
        //   Contact(
        //     firstName: 'First 3',
        //     lastName: 'Last 3',
        //     company: 'Company 3',
        //     email: 'test@email.com',
        //     address: 'Address 3',
        //     notes: 'Notes',
        //     lastCalled: '',
        //     isFavorite: 0,
        //     numbers: [
        //       ContactNumber(
        //         numberDefinition: 'Home',
        //         phoneNumber: '+000000000013',
        //       ),
        //     ],
        //   ),
        // );
        //** Get contact */
        // var contact = await databaseService.getContact(1);
        // print(contact);
        //** Update contact */
        // await databaseService.updateContact(
        //   Contact(
        //       id: 1,
        //       firstName: 'First 5',
        //       lastName: 'Last 5',
        //       company: 'Company 5',
        //       email: 'test@email.com',
        //       address: 'Address 5',
        //       notes: 'Notes',
        //       numbers: [
        //         ContactNumber(
        //           numberDefinition: 'Home',
        //           phoneNumber: '+000000000015',
        //         ),
        //         ContactNumber(
        //           numberDefinition: 'Work',
        //           phoneNumber: '+00000000015',
        //         )
        //       ]),
        // );
        //** Delete contact*/
        // await databaseService.deleteContact(3);
      },
      child: const Text('Check Database Query'),
    );
  }
}
