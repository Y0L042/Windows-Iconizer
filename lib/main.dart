import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconizer/folder_icon_manager.dart';
import 'dart:io';

void main() {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: pickFolder, child: const Text('Pick Folder')),
            ElevatedButton(onPressed: pickIcon, child: const Text('Pick Icon')),
            SwitchListTile(
              title: const Text('Portable Mode'), 
              value: portableMode, 
              onChanged: (bool value) {
                setState(() {
                  portableMode = value;
                });
              },
            ),
            ElevatedButton(onPressed: applyIcon, child: const Text('Apply Icon')),
          ],
        ),
      )
    );
  }
}