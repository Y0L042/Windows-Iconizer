import 'package:iconizer/Classes/app_config_class.dart';

class GlobalConfig {
  static final AppConfig appConfigDEV = AppConfig.fixed(); // DEV
  static final AppConfig appConfigPROD = AppConfig.portable(); // PROD
  static final AppConfig appConfig = appConfigDEV;
}