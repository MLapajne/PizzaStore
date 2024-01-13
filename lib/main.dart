import 'package:flutter/material.dart';
import 'package:kcr_project_flutter/screens/containers.dart';
import 'package:kcr_project_flutter/screens/home.dart';
import 'package:kcr_project_flutter/screens/selectable.dart';
import 'package:yaru/yaru.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return YaruTheme(builder: (context, yaru, child) {
      return MaterialApp(
        theme: yaru.theme,
        darkTheme: yaru.darkTheme,
        home: const SelectableContainerPage(),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
