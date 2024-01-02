import 'package:contacts_buddy/database/database_service.dart';
import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/models/contact_number.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:contacts_buddy/utils/utils.dart';
import 'package:contacts_buddy/views/add_edit_contact.dart';
import 'package:contacts_buddy/views/home_view.dart';
import 'package:contacts_buddy/widgets/popups/info_popup.dart';
import 'package:contacts_buddy/widgets/popups/phone_numbers_popup.dart';
import 'package:flutter/material.dart';

class AddUpdateContactsViewModel extends ChangeNotifier {
  final databaseService = DatabaseService();
  Contact? contactToEdit;

  int isFavorite = 0;

  TextEditingController firstNameController = TextEditingController(text: '');
  TextEditingController lastNameController = TextEditingController(text: '');
  TextEditingController mobileNumberController = TextEditingController(text: '');
  TextEditingController mobileTwoNumberController = TextEditingController(text: '');
  TextEditingController homeNumberController = TextEditingController(text: '');
  TextEditingController companyController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController addressController = TextEditingController(text: '');
  TextEditingController notesController = TextEditingController(text: '');

  toggleIsFav(BuildContext context) async {
    isFavorite == 0 ? isFavorite = 1 : isFavorite = 0;
    await databaseService.updateContact(contactToEdit!.copyWith(isFavorite: isFavorite, numbers: []));
    if (context.mounted) {
      Utils.showSnackBar(isFavorite == 1 ? AppStrings.addedToFav : AppStrings.removedFromFav, context);
    }
    notifyListeners();
  }

  callContact(int id) async {
    final contact = await databaseService.getContact(id);
    //Update last called time on call trigger

    phoneNumberPopup(contact!.numbers!, (String number) async {
      await databaseService.updateContact(
          contact.copyWith(lastCalled: DateTime.now().millisecondsSinceEpoch.toString(), numbers: []));
      Utils().callNumber(number);
    });
  }

  setContactToEdit(int contactId, BuildContext context) async {
    clear();

    contactToEdit = await databaseService.getContact(contactId);

    if (contactToEdit != null) {
      firstNameController = TextEditingController(text: contactToEdit!.firstName);
      lastNameController = TextEditingController(text: contactToEdit!.lastName);
      mobileNumberController = TextEditingController(text: contactToEdit!.numbers![0].phoneNumber ?? '');
      mobileTwoNumberController = TextEditingController(text: contactToEdit!.numbers![1].phoneNumber ?? '');
      homeNumberController = TextEditingController(text: contactToEdit!.numbers![2].phoneNumber ?? '');
      companyController = TextEditingController(text: contactToEdit!.company);
      emailController = TextEditingController(text: contactToEdit!.email);
      addressController = TextEditingController(text: contactToEdit!.address);
      notesController = TextEditingController(text: contactToEdit!.notes);
      isFavorite = contactToEdit!.isFavorite ?? 0;
    }
    if (context.mounted) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AddEditContact()));
    }
  }

  createContact(BuildContext context) {
    final mobileNumberOne = mobileNumberController.text;
    final mobileNumberTwo = mobileTwoNumberController.text;
    final homeNumber = homeNumberController.text;
    databaseService
        .insertContact(
          Contact(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            company: companyController.text,
            email: emailController.text,
            address: addressController.text,
            notes: notesController.text,
            lastCalled: '',
            isFavorite: 0,
            numbers: [
              ContactNumber(
                numberDefinition: 'Mobile',
                phoneNumber: mobileNumberOne,
              ),
              ContactNumber(
                numberDefinition: 'Mobile two',
                phoneNumber: mobileNumberTwo,
              ),
              ContactNumber(
                numberDefinition: 'Home',
                phoneNumber: homeNumber,
              ),
            ],
          ),
        )
        .then(
            (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeView())));
  }

  updateContact(context) {
    databaseService
        .updateContact(Contact(
          id: contactToEdit!.id,
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          company: companyController.text,
          email: emailController.text,
          address: addressController.text,
          notes: notesController.text,
          lastCalled: contactToEdit!.lastCalled,
          isFavorite: isFavorite,
          numbers: [
            ContactNumber(
              numberDefinition: 'Mobile',
              phoneNumber: mobileNumberController.text,
            ),
            ContactNumber(
              numberDefinition: 'Mobile two',
              phoneNumber: mobileTwoNumberController.text,
            ),
            ContactNumber(
              numberDefinition: 'Home',
              phoneNumber: homeNumberController.text,
            ),
          ],
        ))
        .then(
            (value) => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeView())));
  }

  deleteContact(BuildContext context) {
    infoPopup('${AppStrings.areYouSure} ${contactToEdit!.firstName}?', () {
      databaseService.deleteContact(contactToEdit!.id!);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const HomeView()));
    });
  }

  clear() {
    contactToEdit = null;

    isFavorite = 0;

    firstNameController.clear();
    lastNameController.clear();
    mobileNumberController.clear();
    mobileTwoNumberController.clear();
    homeNumberController.clear();
    companyController.clear();
    emailController.clear();
    addressController.clear();
    notesController.clear();
  }

  updateNumbers() {
    notifyListeners();
  }
}
