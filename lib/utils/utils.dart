import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  Color getColorBasedOnName(String name) {
    List<Color> colors = [
      Colors.green,
      Colors.purpleAccent,
      Colors.teal,
      Colors.indigoAccent,
      Colors.pinkAccent,
      Colors.brown,
      Colors.deepOrange,
      Colors.deepPurple,
    ];

    List<Color> selectedColors;
    if (name.length.isEven) {
      selectedColors = colors.sublist(0, 4);
    } else {
      selectedColors = colors.sublist(4, 8);
    }

    bool isFirstHalfOfAlphabet = name.toLowerCase().codeUnitAt(0) <= 'm'.codeUnitAt(0);

    Color color;
    if (isFirstHalfOfAlphabet) {
      color = selectedColors[name.length % 2];
    } else {
      color = selectedColors[2 + (name.length % 2)];
    }

    bool endsWithVowel = 'aeiou'.contains(name.toLowerCase().substring(name.length - 1));
    return endsWithVowel ? color : selectedColors[selectedColors.indexOf(color) + 1];
  }

  callNumber(String number) async {
    final Uri uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  String getFirstLetter(String name) {
    return name.substring(0, 1).toUpperCase();
  }
}
