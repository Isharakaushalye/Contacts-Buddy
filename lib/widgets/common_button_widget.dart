import 'package:contacts_buddy/style.dart';
import 'package:flutter/material.dart';

class CommonButtonWidget extends StatelessWidget {
  final String text;
  final double size;
  final Function()? onTap;
  const CommonButtonWidget({super.key, required this.text, required this.size, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: size,
        height: 40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: blueLvl1,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w200),
        ),
      ),
    );
  }
}
