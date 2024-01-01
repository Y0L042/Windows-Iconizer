// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:iconizer/Classes/app_config_class.dart';
import 'package:iconizer/Classes/folder_row_class.dart';
import 'package:iconizer/Widgets/folder_table_viewer.dart';
import 'package:iconizer/Widgets/set_folder_icon_viewer.dart';
import 'package:iconizer/folder_icon_manager.dart';
import 'package:iconizer/Widgets/icons_viewer_widget.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Iconizer',
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
  List<FolderRowClass> selectedFolders = [];
  IconClass? selectedIcon;

  void onFolderSelected(List<FolderRowClass> folders) {
    setState(() {
      selectedFolders = folders;
    });
  }

  void onIconSelected(IconClass icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

  List<FolderRowClass> getSelectedFolders() {
    return selectedFolders;
  }

  IconClass? getSelectedIcon() {
    return selectedIcon;
  }








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
      appBar: AppBar(title: const Text('Iconizer')),
      body: Flex(
        crossAxisAlignment: CrossAxisAlignment.center,
        direction: Axis.vertical,
        children: [
          FolderTableViewer(onFolderSelected: onFolderSelected),
          IconViewer(onIconSelected: onIconSelected),
          SetFolderIconViewer(getSelectedFolders: getSelectedFolders, getSelectedIcon: getSelectedIcon),
        ],
      ),
    );
  }
}