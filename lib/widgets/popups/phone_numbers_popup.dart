import 'package:contacts_buddy/models/contact_number.dart';
import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/navigation_service.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<void> phoneNumberPopup(List<ContactNumber> numbers, final Function(String num) onNumberSelected) {
  return showDialog<void>(
    context: NavigationService.navigatorKey.currentContext!,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        alignment: Alignment.center,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                // padding: const EdgeInsets.all(10),
                child: const Text(
                  'Select number to call',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              Visibility(
                visible: numbers[0].phoneNumber != '',
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    tileColor: Colors.black87,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                      onNumberSelected(numbers[0].phoneNumber!);
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(1.toString()),
                        const Gap(5.0),
                        const Icon(Icons.phone_enabled),
                      ],
                    ),
                    title: Text(numbers[0].phoneNumber!),
                  ),
                ),
              ),
              Visibility(
                visible: numbers[1].phoneNumber != '',
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    tileColor: Colors.black87,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                      onNumberSelected(numbers[1].phoneNumber!);
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(2.toString()),
                        const Gap(5.0),
                        const Icon(Icons.phone_enabled),
                      ],
                    ),
                    title: Text(numbers[1].phoneNumber!),
                  ),
                ),
              ),
              Visibility(
                visible: numbers[2].phoneNumber != '',
                child: Card(
                  elevation: 1,
                  child: ListTile(
                    tileColor: Colors.black87,
                    iconColor: Colors.white,
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.pop(context);
                      onNumberSelected(numbers[2].phoneNumber!);
                    },
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(3.toString()),
                        const Gap(5.0),
                        const Icon(Icons.phone_enabled),
                      ],
                    ),
                    title: Text(numbers[2].phoneNumber!),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      AppStrings.cancel,
                      style: TextStyle(color: blueLvl2, fontSize: 16),
                    ),
                  )
                ],
              )
            ]),
      );
    },
  );
}
