import 'dart:io';

class DesktopIniHandler {
  final String filePath;

  DesktopIniHandler(this.filePath);

  Future<void> setIconResource(String iconPath) async {
    final file = File(filePath);
    bool fileExists = await file.exists();

    if (fileExists) {
      await _updateIconResource(file, iconPath);
    } else {
      await _createFileWithIconResource(file, iconPath);
    }
  }

  Future<void> _updateIconResource(File file, String iconPath) async {
    List<String> lines = await file.readAsLines();
    bool iconResourceFound = false;

    for (int i = 0; i < lines.length; i++) {
      if (lines[i].startsWith('IconResource=')) {
        lines[i] = 'IconResource=$iconPath,0';
        iconResourceFound = true;
        break;
      }
    }

    if (!iconResourceFound) {
      lines.add('IconResource=$iconPath,0');
    }

    await file.writeAsString(lines.join('\n'));
  }

  Future<void> _createFileWithIconResource(File file, String iconPath) async {
    await file.writeAsString('IconResource=$iconPath,0');
  }
}

/*
void main() async {
  var desktopIniHandler = DesktopIniHandler('path/to/your/desktop.ini');
  await desktopIniHandler.setIconResource('path/to/your/icon.ico');
}
*/