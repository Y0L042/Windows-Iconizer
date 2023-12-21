import 'dart:io';

void setFolderIcon(String folderPath, String iconPath, {bool localIcon = false}) async {
  var desktopINI = File('$folderPath\\desktop.ini');
  var iconDir = '$folderPath\\.icon';
  var iconName = iconPath.split('\\').last; // Extract the icon file name

  if (localIcon) {
    await Directory(iconDir).create();
    var newIconPath = '$iconDir\\$iconName';
    await File(iconPath).copy(newIconPath); // Copy from original path to new path

    iconPath = '.icon\\$iconName'; // Update iconPath to the new relative path
  }

  await desktopINI.writeAsString('''
  [.ShellClassInfo]
  IconResource=$iconPath,0
  ''', mode: FileMode.writeOnly);

  Process.run('attrib', ['+S', folderPath]);
}
