// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';
import 'package:mime/mime.dart';

class CustomSortableList extends StatefulWidget {
  const CustomSortableList({super.key});

  @override
  State<CustomSortableList> createState() => _CustomSortableListState();
}


class _CustomSortableListState extends State<CustomSortableList> {

  List<DataRow> folderPaths = [];

  List<XFile> droppedFolders = [];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: FoldersDataTable(folderPaths: folderPaths,)
            )
          ),
          DropTarget(
            onDragDone: (detail) {
              setState(() {
                // BUG detail (and detail.files) has all the correct names, but droppedFolders for some reason discards all file names
                addDroppedFolderToFolderList(droppedFoldersDetails: detail);
                // droppedFolders.addAll(detail.files);
                // String firstFolderPath = droppedFolders[0].path;
                // XFile droppedFile = droppedFolders[0];
                // String firstFolderFullPath = firstFolderPath + droppedFolders[0].name;
                // String? mimeType = lookupMimeType(firstFolderFullPath);
                // setState(() {
                //   folderPaths = convertXFileListToDataRowList(droppedFolders);
                // });
                // print('-------My dropped folders: $firstFolderFullPath, droppedFolder:  $droppedFile, mimeType: $mimeType');
              });
            },
            child: DragAndDropTarget()
          )
        ],
      ),      
    );
  }

  void addDroppedFolderToFolderList({required DropDoneDetails droppedFoldersDetails})
  {
    // TODO Filter for only folders (filter out other file types)
    // TODO Get folder icon and check portability (if it has)
    setState(() {
      // TODO set folder DataRow list
    });
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
          _customCell(
            xFile.path,
             550
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


class DragAndDropTarget extends StatelessWidget {
  const DragAndDropTarget({super.key});


  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        alignment: Alignment.center,
        child: FractionallySizedBox(
          widthFactor: .75,
          heightFactor: .15,
          child: const ColoredBox(
            color: Colors.lightBlue,
            child: Center(
              child: Text(
                "Drop folders here.",
                textAlign: TextAlign.center,
                
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class FoldersDataTable extends StatefulWidget {
  const FoldersDataTable({super.key, required this.folderPaths});

  final List<DataRow> folderPaths;

  @override
  State<FoldersDataTable> createState() {
    return _FoldersDataTableState();
  }
}

class _FoldersDataTableState extends State<FoldersDataTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildTableHeader(),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              showBottomBorder: true,
              showCheckboxColumn: true,
              columns: <DataColumn>[
                DataColumn(label: Container()), // Empty because header is separate
                DataColumn(label: Container()),
                DataColumn(label: Container()),
              ],
              rows: widget.folderPaths,
              
            ),
          ),
        ),
      ],
    );
  }
}


Widget _buildTableHeader() {
  return DataTable(
    showCheckboxColumn: true,
    columns: <DataColumn>[
      DataColumn(label: Padding(
        padding: const EdgeInsets.only(left: 140.0),
        child: Text("Icon"),
      )),
      DataColumn(label: _customHeader("Folder Path", 550)),
      DataColumn(label: Text("Portable")),
    ],
    rows: <DataRow>[],
  );
}



Widget _customHeader(String title, double width) {
  return SizedBox(
    width: width,
    child: Text(title, textAlign: TextAlign.center),
  );
}

Widget _customCell(String text, double width) {
  return SizedBox(
    width: width,
    child: Text(text, textAlign: TextAlign.center),
  );
}
