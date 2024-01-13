import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:yaru_icons/yaru_icons.dart';

Future<Map<String, dynamic>> dialogBuilder(
    BuildContext context, String imagePath) {
  Map<String, bool> text = {
    "Corn": false,
    "Egg": false,
    "Artichokes": false,
    "Courgettes": false,
    "Sour cream": false,
    "Onion": false,
    "Ham": false,
    "Peppers": false,
  };

  final card = ClipRRect(
    borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
    child: Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: Image.asset(
        //'assets/pica_0.jpg', // Replace with your actual image path
        imagePath,
        fit: BoxFit.fill, // Adjust the BoxFit as needed
      ),
    ),
  );

  final title = Container(
    margin: const EdgeInsets.all(10.0), // Adjust the margin as needed
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        imagePath.replaceFirst('assets/', '').replaceAll('.jpg', ''),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ),
  );

  final button = Container(
      margin: const EdgeInsets.all(10.0),
      child: Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, {'imagePath': imagePath, 'text': text});
            },
            child: const Text('Elevated'),
          )));

  return showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          // Assign the setState callback to a variable

          final children = [
            card,
            title,
            ...text.entries.map((entry) => CheckboxListTile(
                  title: Text(entry.key),
                  value: entry.value,
                  onChanged: (val) {
                    setState(() {
                      text[entry.key] = val!;
                    });
                    // Use the callback to update the state
                  },
                )),
            button
          ];

          return Center(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.5, // 50% of screen width

                  child: SimpleDialog(
                    shadowColor: Colors.black,
                    contentPadding: const EdgeInsets.all(20),
                    children: children,
                  )));
        });
      }).then((value) => value ?? {'imagePath': '', 'text': {}});
}
