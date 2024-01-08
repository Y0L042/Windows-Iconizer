class AppConfig {
  static const String collectionsFolderName = "Iconizer_IconCollections";
  final String collectionsBasePath;
  final bool isPortable;

  AppConfig({required this.collectionsBasePath, required this.isPortable});

  factory AppConfig.portable() {
    // Determine the portable path, typically relative to the executable
    String portablePath = ".\\$collectionsFolderName";
    return AppConfig(collectionsBasePath: portablePath, isPortable: true);
  }

  factory AppConfig.fixed() {
    // Use a fixed path for testing
    String fixedPath = "E:\\vlamf\\Downloads\\Icon Test Folders\\$collectionsFolderName";
    return AppConfig(collectionsBasePath: fixedPath, isPortable: false);
  }
}  