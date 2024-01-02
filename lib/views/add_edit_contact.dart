import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:contacts_buddy/viewmodels/add_update_contacts_viewmodel.dart';
import 'package:contacts_buddy/views/home_view.dart';
import 'package:contacts_buddy/widgets/custom_app_bar.dart';
import 'package:contacts_buddy/widgets/rounded_textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddEditContact extends StatefulWidget {
  const AddEditContact({super.key});

  @override
  State<AddEditContact> createState() => _AddEditContactState();
}

class _AddEditContactState extends State<AddEditContact> {
  @override
  void dispose() {
    Provider.of<AddUpdateContactsViewModel>(context, listen: false).clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddUpdateContactsViewModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70.0),
          child: CustomAppBar(
            title: model.contactToEdit != null ? AppStrings.updateContact : AppStrings.createContact,
            backButton: true,
            onBackPressed: () =>
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView())),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.contactToEdit == null ? model.createContact(context) : model.updateContact(context);
          },
          child: const Icon(Icons.check),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          color: offBlack,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Visibility(
                  visible: model.contactToEdit != null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: model.isFavorite == 0
                            ? const Icon(Icons.star_outline)
                            : const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                        onPressed: () async {
                          await model.toggleIsFav(context);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          model.deleteContact(context);
                        },
                      ),
                    ],
                  ),
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.firstNameController,
                  labelText: AppStrings.firstName,
                  prefixIcon: const Icon(Icons.person),
                  onChanged: (value) {},
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.lastNameController,
                  labelText: AppStrings.lastName,
                  prefixIcon: const Icon(Icons.person),
                  onChanged: (value) {},
                ),
                const Gap(20),
                //Main Mobile Number
                RoundedTextboxWidget(
                  controller: model.mobileNumberController,
                  labelText: AppStrings.mobileNumber,
                  prefixIcon: const Icon(Icons.phone_enabled),
                  onChanged: (value) {
                    model.updateNumbers();
                  },
                ),
                const Gap(20),
                //Alternative mobile number
                RoundedTextboxWidget(
                  controller: model.mobileTwoNumberController,
                  labelText: AppStrings.altMobileNumber,
                  prefixIcon: const Icon(Icons.phone_enabled),
                  onChanged: (value) {
                    model.updateNumbers();
                  },
                ),
                const Gap(20),
                //Home mobile number
                RoundedTextboxWidget(
                  controller: model.homeNumberController,
                  labelText: AppStrings.homeNumber,
                  prefixIcon: const Icon(Icons.phone_enabled),
                  onChanged: (value) {},
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.companyController,
                  labelText: AppStrings.company,
                  prefixIcon: const Icon(Icons.business),
                  onChanged: (value) {},
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.emailController,
                  labelText: AppStrings.email,
                  prefixIcon: const Icon(Icons.email),
                  onChanged: (value) {},
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.addressController,
                  labelText: AppStrings.address,
                  prefixIcon: const Icon(Icons.house),
                  onChanged: (value) {},
                ),
                const Gap(20),
                RoundedTextboxWidget(
                  controller: model.notesController,
                  labelText: AppStrings.notes,
                  prefixIcon: const Icon(Icons.note),
                  minLine: 4,
                  maxLine: 5,
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
