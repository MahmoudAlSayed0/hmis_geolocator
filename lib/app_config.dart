import 'dart:developer';

import 'package:hmis_geolocator/models/token.dart';

class AppConfig {
  static String loginUrl = 'http://live.egysurvey.com/KDAPI/api/Authorize';
  static TokenData? _token;
  static TokenData? get getToken => _token;
  static set setToken(TokenData tokenData) {
    _token = tokenData;
    log('saved token');
  }
}
