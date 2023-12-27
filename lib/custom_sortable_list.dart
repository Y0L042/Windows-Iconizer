// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:cross_file/cross_file.dart';

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
          FoldersDataTable(folderPaths: folderPaths,),
          DropTarget(
            onDragDone: (detail) {
              setState(() {
                droppedFolders.addAll(detail.files);
                String firstFolderPath = droppedFolders[0].path;
                setState(() {
                  folderPaths = convertXFileListToDataRowList(droppedFolders);
                });
                print('-------My dropped folders: $firstFolderPath');
              });
            },
            child: DragAndDropTarget()
          )
        ],
      ),      
    );
  }


  List<DataRow> convertXFileListToDataRowList(List<XFile> droppedFolders) {
    return droppedFolders.map((xFile) {
    return DataRow(
      cells: <DataCell>[
        DataCell(Icon(Icons.folder)), // Example icon cell
        DataCell(Text(xFile.path)), // Use the path property of XFile
        DataCell(Text('Some other data')), // Replace with actual data
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
    return DataTable(
      columns: <DataColumn>[
        DataColumn(label: Text("Icon")),
        DataColumn(label: Text("Folder Path")),
        DataColumn(label: Text("Portable")),
      ],
      rows: <DataRow>[
  
      ],
    );
  }
}









/*

import 'package:flutter/material.dart';

/// Flutter code sample for [DataTable].

void main() => runApp(const DataTableExampleApp());

class DataTableExampleApp extends StatelessWidget {
  const DataTableExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('DataTable Sample')),
        body: const DataTableExample(),
      ),
    );
  }
}

class DataTableExample extends StatelessWidget {
  const DataTableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'Name',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Age',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Role',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
      ],
      rows: const <DataRow>[
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Sarah')),
            DataCell(Text('19')),
            DataCell(Text('Student')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('Janine')),
            DataCell(Text('43')),
            DataCell(Text('Professor')),
          ],
        ),
        DataRow(
          cells: <DataCell>[
            DataCell(Text('William')),
            DataCell(Text('27')),
            DataCell(Text('Associate Professor')),
          ],
        ),
      ],
    );
  }
}

*/