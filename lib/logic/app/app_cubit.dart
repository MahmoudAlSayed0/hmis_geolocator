import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmis_geolocator/Utils/my_navigator.dart';
import 'package:hmis_geolocator/models/response_object.dart';
import 'package:hmis_geolocator/screens/map.dart';
import 'package:hmis_geolocator/services/api_service.dart';
import 'package:hmis_geolocator/services/locator_service.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  String? email;

  String? password;

  late ApiService apiService;

  ResponseObject? selectedGovernrate;
  ResponseObject? selectedDistrict;
  ResponseObject? selectedClinic;
  LatLng? location;

  AppCubit() : super(AppInitial()) {
    apiService = ApiService();
  }
  static AppCubit get(context) => BlocProvider.of(context);

//auth functions

  login(GlobalKey<FormState> formKey) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      emit(LoginLoading());
      formKey.currentState!.save();
      log('Email: $email');
      log('Password: $password');
      try {
        bool response =
            await apiService.login(email: email!, password: password!);
        log(response.toString());

        response ? emit(LoginSuccess()) : emit(LocationFailure());
        log('login success');
      } on DioException catch (e) {
        emit(LoginFailure());
        rethrow;
      }
    }
  }

  //form functions
  Future<void> locate(BuildContext context) async {
    LocationData? data =
        await LocationServiceHelper.getPermissionsAndLocation();
    log(data.toString());
    if (data != null) {
      emit(GotLocation(data: data));
    } else {
      log('didn\'t get location');
    }
  }

  Future<List<ResponseObject>> getGovernsListItems(String? filter) async {
    return await apiService.getGovers();
  }

  Future<List<ResponseObject>> getDistrictsListItems(String? filter) async {
    return await apiService.getDistrictsByID(selectedGovernrate!.id);
  }

  Future<List<ResponseObject>> getClinicsListItems(String? filter) async {
    return await apiService.getClinics();
  }

  void setSelectedGovern(ResponseObject? value) {
    selectedGovernrate = value;
    log(selectedGovernrate.toString());
    emit(SetGovernrate());
  }

  void setSelectedDistrict(ResponseObject? value) {
    selectedDistrict = value;
    log(selectedDistrict.toString());
    emit(SetGovernrate());
  }

  void setSelectedClinic(ResponseObject? value) {
    selectedClinic = value;
    log(selectedClinic.toString());
    emit(SetGovernrate());
  }

  void setLocation(LatLng loc) {
    location = loc;

    log('cubit' + location.toString());
    emit(ConfirmedLocation());
  }
}
