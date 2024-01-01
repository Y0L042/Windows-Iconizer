import 'package:flutter/material.dart';
import 'package:iconizer/Classes/folder_row_class.dart';
import 'package:iconizer/Widgets/icons_viewer_widget.dart';

class SetFolderIconViewer extends StatefulWidget {
  final Function getSelectedFolders;
  final Function getSelectedIcon;

  const SetFolderIconViewer({super.key, required this.getSelectedFolders, required this.getSelectedIcon});


  @override
  State<SetFolderIconViewer> createState() => _SetFolderIconViewerState();
}

class _SetFolderIconViewerState extends State<SetFolderIconViewer> {
  bool? isPortable = false;
  List<FolderRowClass> selectedFolders = [];
  IconClass? selectedIcon;

  void setFolderIcon(FolderRowClass folderRow, IconClass? icon) {
    
  }

  @override
  Widget build(BuildContext context) {
    selectedFolders = widget.getSelectedFolders();
    selectedIcon = widget.getSelectedIcon();

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
                  if (value != null) {
                    setState(() {
                      isPortable = value;
                    });
                  }
                },
              ),
              const Text("Make icon portable"),
            ],
          ),
          FractionallySizedBox(
            widthFactor: 0.3,
            child: ElevatedButton(
              onPressed: () {
                print(selectedFolders);
                print(selectedIcon);
              }, 
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
                onPressed: () {
                  
                },
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