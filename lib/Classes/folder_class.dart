import 'package:flutter/material.dart';
import 'package:iconizer/Classes/widgetfunctions_class.dart';
import 'package:iconizer/ui_config.dart';

class FolderClass
{
  String folderName;
  String folderPath;
  String? folderIconPath;

  DataRow dataRow = const DataRow(cells: <DataCell>[]);

  FolderClass({required this.folderName, required this.folderPath, this.folderIconPath}) {
    dataRow = createDataRow();
  }

  DataRow createDataRow() {
    return DataRow (
      onSelectChanged: (value) {
        true;
      },
      cells: <DataCell>[
        const DataCell(
          Icon(Icons.folder)
        ), // Example icon cell
        DataCell(
          WidgetFunctions.customCell(
            folderName, 
            UIConfig.minDataColumnWidth
          )
        ),
        DataCell(
          WidgetFunctions.customCell(
            folderPath,
             UIConfig.minDataColumnWidth
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
  }
}
