import 'package:flutter/material.dart';
import 'package:iconizer/ui_config.dart';

class WidgetFunctions {

  static Widget customCell(String text, double width) {
    return SizedBox(
      width: width,
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  static Widget customHeader(String title, double width) {
    return SizedBox(
      width: width,
      child: Text(title, textAlign: TextAlign.center),
    );
  }

  static Widget buildTableHeader() {
    return DataTable(
      showCheckboxColumn: true,
      columns: <DataColumn>[
        const DataColumn(label: Padding(
          padding: EdgeInsets.only(left: UIConfig.minDataColumnWidth*0.35),
          child: Text("Icon"),
        )),
        DataColumn(label: WidgetFunctions.customHeader("Folder Name", UIConfig.minDataColumnWidth)),
        DataColumn(label: WidgetFunctions.customHeader("Folder Path", UIConfig.minDataColumnWidth)),
        const DataColumn(label: Text("Portable")),
      ],
      rows: const <DataRow>[],
    );
  }

}