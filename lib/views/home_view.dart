import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:contacts_buddy/viewmodels/add_update_contacts_viewmodel.dart';
import 'package:contacts_buddy/viewmodels/contacts_viewmodel.dart';
import 'package:contacts_buddy/views/add_edit_contact.dart';
import 'package:contacts_buddy/widgets/contact_item.dart';
import 'package:contacts_buddy/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    Provider.of<ContactsViewModel>(context, listen: false).getAllContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Consumer<ContactsViewModel>(builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(model.selectedTab == 1 ? 70.0 : 10),
            child: CustomAppBar(
              showSearch: model.selectedTab == 1,
            ),
          ),
          floatingActionButton: model.selectedTab == 1
              ? FloatingActionButton(
                  onPressed: () {
                    Provider.of<AddUpdateContactsViewModel>(context, listen: false).clear();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => const AddEditContact()));
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox.shrink(),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.recent_actors),
                label: AppStrings.recent,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.contact_phone),
                label: AppStrings.contacts,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star),
                label: AppStrings.favourits,
              ),
            ],
            currentIndex: model.selectedTab,
            selectedItemColor: blueLvl3,
            onTap: (index) {
              model.switchTabs(index);
              model.getAllContacts();
            },
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            color: offBlack,
            padding: const EdgeInsets.only(top: 50),
            child: model.contactList.isNotEmpty
                ? ListView.builder(
                    itemCount: model.contactList.length,
                    itemBuilder: (context, index) {
                      return ContactItem(
                        contact: model.contactList[index],
                        isRecent: model.selectedTab == 0,
                        isEditable: model.selectedTab != 0,
                        onTap: () {
                          Provider.of<AddUpdateContactsViewModel>(context, listen: false)
                              .setContactToEdit(model.contactList[index].id!, context);
                        },
                        onCall: () {
                          Provider.of<AddUpdateContactsViewModel>(context, listen: false)
                              .callContact(model.contactList[index].id!);
                        },
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [Icon(Icons.no_accounts), Text(AppStrings.noContactsFound)],
                    ),
                  ),
          ),
        );
      }),
    );
  }
}
