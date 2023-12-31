import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconizer/Classes/app_config_class.dart';
import 'package:iconizer/Config/global_config.dart';
import 'package:iconizer/Widgets/drag_and_drop_target_widget.dart';
import 'package:mime/mime.dart';
import 'package:cross_file/cross_file.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:path/path.dart' as path;


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
        const Padding(
          padding: EdgeInsets.only(left: 80, right: 40),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: IconColletionsBar()
              ),
              IconsGridPanel(),
              IconDisplayPanel(),
            ],
          ),
        ),
        DropTarget(
          onDragDone: (details) {
            
          },
          child: const DragAndDropTarget(),
        ),
      ], 
    );
  }
}



// ignore: must_be_immutable
class IconColletionsBar extends StatefulWidget {
  const IconColletionsBar({super.key});

  @override
  State<IconColletionsBar> createState() => _IconColletionsBarState();
}


class _IconColletionsBarState extends State<IconColletionsBar> {
  List<IconCollectionClass> iconCollectionList = [];

  @override void initState() {
    // TODO: implement initState
    super.initState();
    loadCollectionNames();
  }


  Future<void> loadCollectionNames() async {
    List<String> collectionNames = await getCollectionNames(GlobalConfig.appConfig.collectionsBasePath);
    setState(() {
      iconCollectionList = collectionNames.map((name) => IconCollectionClass(collectionName: name)).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    Future<List<String>> collectionNames = getCollectionNames(GlobalConfig.appConfig.collectionsBasePath); // reads collection folders

    return ListView.builder(
      itemCount: iconCollectionList.length,
      itemBuilder: (BuildContext context, int index) {
        return IconCollectionWidget(
          iconCollection: iconCollectionList[index]
        );
      },
    );
  }
}






// ignore: must_be_immutable
class IconCollectionWidget extends StatefulWidget {
  IconCollectionClass iconCollection;

  IconCollectionWidget({super.key, required this.iconCollection});

  @override
  State<IconCollectionWidget> createState() => _IconCollectionWidgetState();
}

class _IconCollectionWidgetState extends State<IconCollectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.iconCollection.collectionName);
  }
}




class IconsGridPanel extends StatefulWidget {
  const IconsGridPanel({super.key});

  @override
  State<IconsGridPanel> createState() => _IconsGridPanelState();
}

class _IconsGridPanelState extends State<IconsGridPanel> {
  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
      
    // );
    return const Placeholder();
  }
}




class IconDisplayPanel extends StatefulWidget {
  const IconDisplayPanel({super.key});

  @override
  State<IconDisplayPanel> createState() => _IconDisplayPanelState();
}

class _IconDisplayPanelState extends State<IconDisplayPanel> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}




Future<List<String>> getCollectionNames(String basePath) async {
  final baseDir = Directory(basePath);
  List<String> collectionNames = [];

  if (await baseDir.exists()) {
    await for (final entity in baseDir.list()) {
      if (entity is Directory) {
        String folderName = path.basename(entity.path);
        collectionNames.add(folderName);
        print(folderName);
      }
    }
  }

  return collectionNames;
}





class IconCollectionClass {
  String collectionName;
  
  IconCollectionClass({required this.collectionName});
}