import 'package:flutter/material.dart';
import 'package:iconizer/Classes/widgetfunctions_class.dart';
import 'package:iconizer/Config/ui_config.dart';

class FoldersDataTable extends StatefulWidget {
  const FoldersDataTable({super.key, required this.dataRows});

  final List<DataRow> dataRows;

  @override
  State<FoldersDataTable> createState() {
    return _FoldersDataTableState();
  }
}

class _FoldersDataTableState extends State<FoldersDataTable> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.vertical,
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
                DataColumn(label: Container()),
              ],
              rows: widget.dataRows,
            ),
          ),
        ),
      ],
    );
  }

  static Widget _buildTableHeader() {
    return DataTable(
      showCheckboxColumn: true,
      
      columns: <DataColumn>[
        DataColumn(label: Container()),
        const DataColumn(label: Text("Icon")),
        DataColumn(label: WidgetFunctions.customHeader("Folder Name", UIConfig.minDataColumnWidth * UIConfig.foldernameScale)),
        DataColumn(label: WidgetFunctions.customHeader("Folder Path", UIConfig.minDataColumnWidth * UIConfig.folderpathScale)),
        const DataColumn(label: Text("Portable")),
      ],
      rows: const <DataRow>[],
    );
  }

}