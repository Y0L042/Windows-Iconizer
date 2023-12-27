// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconizer/custom_sortable_list.dart';
import 'package:iconizer/folder_icon_manager.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await WindowManagerService.setupWindow();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IconizerScreen(),
    );
  }
}

class IconizerScreen extends StatefulWidget {
  const IconizerScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _IconizerScreenState createState() => _IconizerScreenState();
}

class _IconizerScreenState extends State<IconizerScreen> {
  String? folderPath;
  String? iconPath;
  bool portableMode = false;

  void pickFolder() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory != null) {
      setState(() {
        folderPath = selectedDirectory;
      });
    }
  }

  void pickIcon() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ["ico"]);
    if (result != null) {
      setState(() {
        iconPath = result.files.single.path;
      });
    }
  }

  void applyIcon() {
    if (folderPath != null && iconPath != null) {
      // Apply icon to folder
      setFolderIcon(folderPath!, iconPath!, localIcon: portableMode);
    } else {
      // Handle case where folderPath or iconPath is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Folder Icon Setter')),
      body: CustomSortableList(),
    );
  }
}