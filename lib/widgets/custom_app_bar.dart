import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:contacts_buddy/viewmodels/contacts_viewmodel.dart';
import 'package:contacts_buddy/widgets/rounded_textbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.showSearch = false,
    this.backButton = false,
    this.onBackPressed,
  });

  final String title;
  final bool backButton;
  final bool showSearch;
  final Function()? onBackPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Consumer<ContactsViewModel>(
        builder: (context, model, child) {
          return Container(
            child: title != ''
                ? (!backButton
                    ? Text(title)
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: onBackPressed ?? () {},
                          ),
                          const Gap(20.0),
                          Text(title)
                        ],
                      ))
                : (showSearch
                    ? RoundedTextboxWidget(
                        controller: model.searchController,
                        labelText: AppStrings.searchContacts,
                        onChanged: (value) {
                          model.searchContact();
                        },
                      )
                    : Container()),
          );
        },
      ),
      automaticallyImplyLeading: false,
    );
  }
}
