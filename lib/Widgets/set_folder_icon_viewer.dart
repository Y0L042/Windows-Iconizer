import 'package:flutter/material.dart';
import 'package:iconizer/Classes/folder_row_class.dart';
import 'package:iconizer/Widgets/icons_viewer_widget.dart';
import 'package:flutter/material.dart';
import 'package:iconizer/Classes/folder_row_class.dart';
import 'package:iconizer/Classes/desktop_ini_handler_class.dart';
import 'package:path/path.dart' as path;

class SetFolderIconViewer extends StatefulWidget {
  final Function getSelectedFolders;
  final Function getSelectedIcon;

  const SetFolderIconViewer({super.key, required this.getSelectedFolders, required this.getSelectedIcon});

  @override
  State<SetFolderIconViewer> createState() => _SetFolderIconViewerState();
}

class _SetFolderIconViewerState extends State<SetFolderIconViewer> {
  bool isPortable = false;
  List<FolderRowClass> selectedFolders = [];
  IconClass? selectedIcon;

  void setFolderIcon() async {
    selectedFolders = widget.getSelectedFolders();
    selectedIcon = widget.getSelectedIcon();

    if (selectedIcon != null) {
      for (var folderRow in selectedFolders) {
        var desktopIniHandler = DesktopIniHandler(folderRow.folderPath);
        if (isPortable) {
          await desktopIniHandler.makeIconPortable(selectedIcon!.iconPath);
        } else {
          await desktopIniHandler.setIconResource(path.absolute(selectedIcon!.iconPath));
        }
      }
    }
  }

  void clearFolderIcon() async {
    selectedFolders = widget.getSelectedFolders();
    for (var folderRow in selectedFolders) {
      var desktopIniHandler = DesktopIniHandler(folderRow.folderPath);
      await desktopIniHandler.removeIcon();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Flex(
        direction: Axis.vertical,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: isPortable, 
                onChanged: (value) {
                  setState(() {
                    isPortable = value ?? false;
                  });
                },
              ),
              const Text("Make icon portable"),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.3,
            child: ElevatedButton(
              onPressed: setFolderIcon, 
              child: const Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_outlined),
                  Text("Set folder icon"),
                ],
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.25,
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: ElevatedButton(
                onPressed: clearFolderIcon,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove_outlined),
                    Text("Remove folder icon"),
                  ],
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}
