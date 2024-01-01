// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:iconizer/Classes/folder_row_class.dart';
import 'package:iconizer/Classes/widgetfunctions_class.dart';
import 'package:iconizer/Config/ui_config.dart';
import 'package:iconizer/Widgets/drag_and_drop_target_widget.dart';
import 'package:iconizer/Widgets/folders_datatable_widget.dart';
import 'package:mime/mime.dart';

class FolderTableViewer extends StatefulWidget {
  final Function onFolderSelected;

  const FolderTableViewer({super.key, required this.onFolderSelected});
  @override
  State<FolderTableViewer> createState() => _FolderTableViewerState();
}

class _FolderTableViewerState extends State<FolderTableViewer> {
  List<DataRow> datatableFolderRows = [];
  List<FolderRowClass> folderObjectList = [];
  List<FolderRowClass> selectedFolderRows = [];


  void toggleFolderSelection(FolderRowClass folderRow) {
    setState(() {
      folderRow.isSelected = !folderRow.isSelected;
    });
  }

  DataRow createDataRow(FolderRowClass folderRow) {
    return DataRow(
      selected: folderRow.isSelected,
      onSelectChanged: (isSelected) {
        setState(() {
          if (isSelected != null) {
            folderRow.isSelected = isSelected;
            // print("${folderRow.folderName}:   ${folderRow.isSelected}");

            if (isSelected) {
              selectedFolderRows.add(folderRow);
            } else {
              selectedFolderRows.remove(folderRow);
            }
            widget.onFolderSelected(selectedFolderRows);
          }
        });
      },
      cells: <DataCell>[
        const DataCell(Icon(Icons.folder)),
        DataCell(WidgetFunctions.customCell(folderRow.folderName, UIConfig.minDataColumnWidth * UIConfig.foldernameScale)),
        DataCell(WidgetFunctions.customCell(folderRow.folderPath, UIConfig.minDataColumnWidth * UIConfig.folderpathScale)),
        DataCell(Checkbox(
          value: false,
          onChanged: (bool? value) {
          },
        )),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SingleChildScrollView(
          child: SizedBox(
            height: 250,
            child: FoldersDataTable(dataRows: folderObjectList.map((folderRow) => createDataRow(folderRow)).toList())
          )
        ),
        ButtonBar(
          alignment: MainAxisAlignment.start,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.add_outlined)),
            IconButton(onPressed: (){}, icon: Icon(Icons.remove_outlined)),
          ],
        ),
        DropTarget(
          onDragDone: (detail) {
            setState(() {
              List<XFile> filteredFolders = filterForFolders(droppedFoldersDetails: detail);
              List<FolderRowClass> folderObjects = filteredFolders.map((xFile) {
                FolderRowClass folderRow = createFolderObjectFromXFile(xFile);
                if (!folderAlreadyExists(folderObjectList, folderRow.folderPath)) {
                  return folderRow;
                }
                return null;
              }).where((element) => element != null).cast<FolderRowClass>().toList();
              // create datarows for folder objects
              for (var folderRow in folderObjects) {
                folderRow.dataRow = createDataRow(folderRow);
              }

              folderObjectList.addAll(folderObjects);
            });
          },
          child: DragAndDropTarget()
        )
      ],
    );  
  }

  bool folderAlreadyExists(List<FolderRowClass> folderList, String folderPath) {
    return folderList.any((folderRow) => folderRow.folderPath == folderPath);
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

  FolderRowClass createFolderObjectFromXFile(XFile xfile) {
    FolderRowClass newFolder = FolderRowClass(
      folderName: xfile.name,
      folderPath: xfile.path
    );
    return newFolder;
  }

}


















