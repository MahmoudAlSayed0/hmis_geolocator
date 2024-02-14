import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmis_geolocator/logic/app/app_cubit.dart';

import 'package:hmis_geolocator/screens/home.dart';
import 'package:hmis_geolocator/screens/login.dart';
import 'package:hmis_geolocator/screens/map.dart';
import 'package:hmis_geolocator/services/locator_service.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
        home: HomeScreen(),
      ),
    );
  }
}
