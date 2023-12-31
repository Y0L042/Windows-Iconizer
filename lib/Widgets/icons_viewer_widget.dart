import 'package:flutter/material.dart';
import 'package:iconizer/Widgets/drag_and_drop_target_widget.dart';
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
    return Flex(
      direction: Axis.vertical,
      children: [
        Flex(
          direction: Axis.horizontal,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: IconColletionsBar()
            )
            // IconDisplayPanel(),
          ],
        ),
        const DragAndDropTarget(),
      ], 
    );
  }
}



// ignore: must_be_immutable
class IconColletionsBar extends StatefulWidget {
  IconColletionsBar({super.key});
  List<IconCollection> iconCollectionList = [];

  @override
  State<IconColletionsBar> createState() => _IconColletionsBarState();
}


class _IconColletionsBarState extends State<IconColletionsBar> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5, //widget.iconCollectionList.length,
      itemBuilder: (BuildContext context, int index) {
        return const IconCollectionWidget();
      },
    );
  }
}




class IconCollectionWidget extends StatelessWidget {
  const IconCollectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Testing...");
  }
}





class IconCollection {
  IconCollection();
}