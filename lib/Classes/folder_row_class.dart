import 'package:flutter/material.dart';

class FolderRowClass
{
  String folderName;
  String folderPath;
  String? folderIconPath;
  bool isSelected;


  DataRow dataRow = const DataRow(cells: <DataCell>[]);

  FolderRowClass({required this.folderName, required this.folderPath, this.folderIconPath, this.isSelected = false});
}
