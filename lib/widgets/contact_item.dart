import 'package:contacts_buddy/models/contact.dart';
import 'package:contacts_buddy/style.dart';
import 'package:contacts_buddy/utils/static/app_strings.dart';
import 'package:contacts_buddy/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;
  final bool isRecent;
  final bool isEditable;
  final Function()? onTap;
  final Function()? onCall;
  const ContactItem({
    super.key,
    required this.contact,
    required this.onCall,
    this.isRecent = false,
    this.isEditable = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEditable ? onTap : () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.2,
              child: CircleAvatar(
                backgroundColor: Utils().getColorBasedOnName(contact.firstName ?? AppStrings.notDefined),
                child: Text(
                  Utils().getFirstLetter(contact.firstName ?? AppStrings.notDefined),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    contact.firstName ?? AppStrings.notDefined,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Visibility(
                    visible: isRecent,
                    child: Text(
                      '${AppStrings.lastCalled} ${_convertTimestampToTime(contact.lastCalled ?? '')}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.1,
              child: IconButton(
                icon: const Icon(Icons.call),
                color: blueLvl5,
                onPressed: onCall,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _convertTimestampToTime(String timestamp) {
    if (timestamp == '') {
      return '';
    }
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    return DateFormat('hh:mm:ss a yyyy/MM/dd').format(dateTime);
  }
}
