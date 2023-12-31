import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconizer/Config/global_config.dart';
import 'package:iconizer/Widgets/drag_and_drop_target_widget.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:path/path.dart' as path;


class IconViewer extends StatefulWidget {
  const IconViewer({super.key});

  @override
  State<IconViewer> createState() => _IconViewerState();
}

class _IconViewerState extends State<IconViewer> {
  IconCollectionClass? selectedCollection;
  IconClass? selectedIcon;

  void onCollectionSelected(IconCollectionClass collection) {
    setState(() {
      selectedCollection = collection;
    });
  }

  void onIconSelected(IconClass icon) {
    setState(() {
      selectedIcon = icon;
    });
  }

@override
Widget build(BuildContext context) {
  return Flex(
    direction: Axis.vertical,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 80, right: 40),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Add a title for your IconColletionsBar here
                Text(
                  'Icon Collections', // Change this text to your desired title
                  style: TextStyle(
                    fontSize: 20, // Customize the font size as needed
                    fontWeight: FontWeight.bold, // Customize the font weight as needed
                  ),
                ),
                SizedBox(
                  width: 150,
                  height: 150,
                  child: IconColletionsBar(),
                ),
              ],
            ),
            SizedBox(
              width: 150,
              height: 150,
              child: IconsGridPanel(selectedCollection: selectedCollection)
            ),
            IconDisplayPanel(selectedIcon: selectedIcon),
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
    List<IconCollectionClass> iconColTempList = await getCollectionNames(GlobalConfig.appConfig.collectionsBasePath);
    setState(() {
      iconCollectionList = iconColTempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Future<List<String>> collectionNames = getCollectionNames(GlobalConfig.appConfig.collectionsBasePath); // reads collection folders
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
    return ListTile(
      title: Text(widget.iconCollection.collectionName),
      onTap: () {
        context.findAncestorStateOfType<_IconViewerState>()?.onCollectionSelected(widget.iconCollection);
      },
    );
  }
}



class IconsGridPanel extends StatefulWidget {
  final IconCollectionClass? selectedCollection;

  const IconsGridPanel({super.key, this.selectedCollection});

  @override
  State<IconsGridPanel> createState() => _IconsGridPanelState();
}

class _IconsGridPanelState extends State<IconsGridPanel> {
  List<File> iconList = [];

  @override
  void didUpdateWidget(IconsGridPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedCollection != oldWidget.selectedCollection) {
      loadIcons();
    }
  }

  Future<void> loadIcons() async {
    if (widget.selectedCollection != null) {
      iconList = await widget.selectedCollection!.getIcons();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemCount: iconList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // create IconObject and set as selected, then build app to display in IconDisplayPanel
            File selectedIcon = iconList[index];
            IconClass iconObject = IconClass(
              iconName: path.basename(selectedIcon.path),
              iconPath: selectedIcon.path,
              iconImage: Image.file(iconList[index])
            );
            context.findAncestorStateOfType<_IconViewerState>()?.onIconSelected(iconObject);
          },
          child: Image.file(iconList[index]),
        );
      },
    );
    // return const Placeholder();
  }
}




class IconDisplayPanel extends StatefulWidget {
  const IconDisplayPanel({super.key, this.selectedIcon});
  final IconClass? selectedIcon;

  @override
  State<IconDisplayPanel> createState() => _IconDisplayPanelState();
}

class _IconDisplayPanelState extends State<IconDisplayPanel> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedIcon == null) {
      return Container();
    }
    return Image.file(
      File(widget.selectedIcon!.iconPath)
    );

  }
}




Future<List<IconCollectionClass>> getCollectionNames(String basePath) async {
  final baseDir = Directory(basePath);
  List<IconCollectionClass> iconCollectionList = [];

  if (await baseDir.exists()) {
    await for (final entity in baseDir.list()) {
      if (entity is Directory) {
        String folderName = path.basename(entity.path);
        String folderPath = entity.path;
        iconCollectionList.add(IconCollectionClass(collectionName: folderName, collectionPath: folderPath));
      }
    }
  }

  return iconCollectionList;
}





class IconCollectionClass {
  String collectionName;
  String collectionPath;
  
  IconCollectionClass({required this.collectionName, required this.collectionPath});

  Future<List<File>> getIcons() async {
    final collectionDir = Directory(collectionPath);
    List<File> icons = [];

    if (await collectionDir.exists()) {
      await for (final entity in collectionDir.list()) {
        if (entity is File && isIconFile(entity.path)) {
          icons.add(entity);
        }
      }
    }

    return icons;
  }

  bool isIconFile(String filePath) {
    return filePath.endsWith(".ico");
  }

}

class IconClass {
  String iconName;
  String iconPath;
  Image iconImage;

  IconClass({required this.iconName, required this.iconPath, required this.iconImage});
  
}