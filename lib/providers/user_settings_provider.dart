import 'package:ecommerceApp/Models/settings.dart';
import 'package:ecommerceApp/Services/settings_services.dart';
import 'package:flutter/cupertino.dart';

import '../locator.dart';

class UserSettingsProvier extends ChangeNotifier{

  SettingsServices settingsServices = locator<SettingsServices>();
  UserSettings _userSettings ;


}