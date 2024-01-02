import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/navigation_service.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:flutter/material.dart';

Future<void> infoPopup(String text, void Function()? sure) {
  return showDialog<void>(
    context: NavigationService.navigatorKey.currentContext!,
    barrierDismissible: false,
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
                padding: const EdgeInsets.all(10),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
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
                  ),
                  TextButton(
                    onPressed: sure,
                    child: const Text(
                      AppStrings.sure,
                      style: TextStyle(color: blueLvl1, fontSize: 16),
                    ),
                  ),
                ],
              )
            ]),
      );
    },
  );
}
