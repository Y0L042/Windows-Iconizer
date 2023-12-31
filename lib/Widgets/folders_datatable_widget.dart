import 'package:flutter/material.dart';
import 'package:iconizer/Classes/widgetfunctions_class.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        WidgetFunctions.buildTableHeader(),
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
}