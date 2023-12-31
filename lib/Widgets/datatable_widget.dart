// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:iconizer/Classes/folder_class.dart';
import 'package:iconizer/Classes/widgetfunctions_class.dart';
import 'package:iconizer/Widgets/folders_datatable_widget.dart';
import 'package:iconizer/Widgets/iconsviewer_widget.dart';
import 'package:mime/mime.dart';

class FoldersTableMain extends StatefulWidget {
  const FoldersTableMain({super.key});
  @override
  State<FoldersTableMain> createState() => _FoldersTableMainState();
}

class _FoldersTableMainState extends State<FoldersTableMain> {
  List<DataRow> datatableFolderRows = [];
  List<FolderClass> folderObjectList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 250,
              child: FoldersDataTable(dataRows: folderObjectList.map((folderObject) => folderObject.dataRow).toList())
            )
          ),
          Row(
            children: [
              ButtonBar(
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.add_outlined)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.remove_outlined)),
                ],
              ),
            ],
          ),
          DropTarget(
            onDragDone: (detail) {
              setState(() {
                List<XFile> filteredFolders = filterForFolders(droppedFoldersDetails: detail);
                List<FolderClass> folderObjects = filteredFolders.map((xFile) => createFolderObjectFromXFile(xFile)).toList();
                folderObjectList.addAll(folderObjects);
              });
            },
            child: DragAndDropTarget()
          )
        ],
      ),      
    );
  }

  List<XFile> filterForFolders({required DropDoneDetails droppedFoldersDetails})
  {
    List<XFile> list= [];
    for (var file in droppedFoldersDetails.files) {
      String? mimeType = lookupMimeType(file.path);
      if (mimeType == null){
        list.add(file);
      }
    }

    return list;
  }

  FolderClass createFolderObjectFromXFile(XFile xfile) {
    FolderClass newFolder = FolderClass(
      folderName: xfile.name,
      folderPath: xfile.path
    );

    return newFolder;
  }

  List<DataRow> convertXFileListToDataRowList(List<XFile> droppedFolders) {
    return droppedFolders.map((xFile) {
    return DataRow(
      onSelectChanged: (value) {
        true;
      },
      cells: <DataCell>[
        DataCell(
          Icon(Icons.folder)
        ), // Example icon cell
        DataCell(
          WidgetFunctions.customCell(
            xFile.path,
             150
          )
        ), // Use the path property of XFile
        DataCell(
          Checkbox(
            value: false,
            onChanged: (value) {
              
            },
          )
        ), // Replace with actual data
      ],
    );
  }).toList();
  }

}


















