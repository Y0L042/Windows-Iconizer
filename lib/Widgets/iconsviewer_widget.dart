import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';

class IconViewer extends StatefulWidget {
  const IconViewer({super.key});

  @override
  State<IconViewer> createState() => _IconViewerState();
  
}

class _IconViewerState extends State<IconViewer> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class DragAndDropTarget extends StatelessWidget {
  const DragAndDropTarget({super.key});


  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          alignment: Alignment.center,
          child: const SizedBox(
            width: 50,
            height: 50,
            child: ColoredBox(
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
      ]
    );
  }
}