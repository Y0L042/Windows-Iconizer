import 'dart:io';
import 'package:path/path.dart' as path;

class DesktopIniHandler {
  final String folderPath;

  DesktopIniHandler(this.folderPath);

  String get _desktopIniPath => path.join(folderPath, 'desktop.ini');
  String get _iconizerIconsPath => path.join(folderPath, '.iconizer_icons');

  Future<void> makeIconPortable(String iconPath) async {
    final iconizerIconsDir = Directory(_iconizerIconsPath);

    if (!await iconizerIconsDir.exists()) {
      await iconizerIconsDir.create();
    }
    final iconName = path.basename(iconPath);
    final newIconPath = path.join(_iconizerIconsPath, iconName);

    await File(iconPath).copy(newIconPath);
    await setIconResource(path.join('.iconizer_icons', iconName));
  }

  Future<void> setIconResource(String relativeIconPath) async {
    final file = File(_desktopIniPath);
    await _updateOrCreateIconResource(file, 'IconResource=$relativeIconPath,0');
  }

  Future<String?> getIconResource() async {
    final file = File(_desktopIniPath);
    if (await file.exists()) {
      List<String> lines = await file.readAsLines();
      for (var line in lines) {
        if (line.startsWith('IconResource=')) {
          return line.split('=')[1].split(',')[0];
        }
      }
    }
    return null;
  }

  Future<void> removeIcon() async {
    final iconizerIconsDir = Directory(_iconizerIconsPath);
    if (await iconizerIconsDir.exists()) {
      await iconizerIconsDir.delete(recursive: true);
    }

    final file = File(_desktopIniPath);
    if (await file.exists()) {
      List<String> lines = await file.readAsLines();
      lines.removeWhere((line) => line.startsWith('IconResource='));
      await file.writeAsString(lines.join('\n'));
    }
  }

Future<void> _updateOrCreateIconResource(File file, String iconResourceLine) async {
  List<String> lines = await file.exists() ? await file.readAsLines() : [];
  bool iconResourceFound = false;
  bool shellClassInfoFound = false;

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('IconResource=')) {
      lines[i] = iconResourceLine;
      iconResourceFound = true;
    } else if (lines[i] == '[.ShellClassInfo]') {
      shellClassInfoFound = true;
    }
  }

  if (!iconResourceFound) {
    lines.add(iconResourceLine);
  }

  if (!shellClassInfoFound) {
    lines.insert(0, '[.ShellClassInfo]');
  }

  await file.writeAsString(lines.join('\n'));
}

}


/*
void main() async {
  var desktopIniHandler = DesktopIniHandler('path/to/your/desktop.ini');
  await desktopIniHandler.setIconResource('path/to/your/icon.ico');
}
*/