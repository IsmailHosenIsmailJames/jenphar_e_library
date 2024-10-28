import 'package:flutter/material.dart';
import 'package:jenphar_e_library/src/screens/home/home_screen.dart';

class ELibraryPage extends StatefulWidget {
  const ELibraryPage({super.key});

  @override
  State<ELibraryPage> createState() => _ELibraryPageState();
}

class _ELibraryPageState extends State<ELibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context, "E-Library"),
      body: Center(
        child: Text("Under Development"),
      ),
    );
  }
}
