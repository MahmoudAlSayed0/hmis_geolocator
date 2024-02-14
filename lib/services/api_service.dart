import 'dart:io';

import 'package:hmis_geolocator/app_config.dart';
import 'package:hmis_geolocator/models/response_object.dart';
import 'package:hmis_geolocator/models/token.dart';
import 'package:hmis_geolocator/services/dio_helper.dart';

class ApiService {
  Future<bool> login({required String email, required String password}) async {
    try {
      var response = await post(
        Url: AppConfig.loginUrl,
        body: {'email': email, 'password': password},
        contentType: 'application/json',
      );
      TokenData tokenData = TokenData.fromMap(response.data);
      AppConfig.setToken = tokenData;
      return true;
    } on Exception catch (e) {
      return false;
    }
  }

  Future<List<ResponseObject>> getGovers() async {
    List<dynamic> data = await get(
      'http://live.egysurvey.com/KDAPI/api/BasicData/Govers',
    );

    List<ResponseObject> itemList =
        data.map((e) => ResponseObject.fromMap(e)).toList();
    return itemList;
  }

  Future<List<ResponseObject>> getDistrictsByID(int id) async {
    List<dynamic> data = await get(
      'http://live.egysurvey.com/KDAPI/api/BasicData/Districts/$id',
    );
    List<ResponseObject> itemList =
        data.map((e) => ResponseObject.fromMap(e)).toList();
    return itemList;
  }

  Future<List<ResponseObject>> getClinics() async {
    List<dynamic> data = await get(
      'http://live.egysurvey.com/KDAPI/api/BasicData/Clinics',
    );

    List<ResponseObject> itemList =
        data.map((e) => ResponseObject.fromMap(e)).toList();
    return itemList;
  }
}
