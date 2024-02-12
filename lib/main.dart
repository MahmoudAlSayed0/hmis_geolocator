import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hmis_geolocator/services/locator_service.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
              onPressed: () async {
                LocationData? data =
                    await LocationServiceHelper.getPermissionsAndLocation();
                log(data.toString());
              },
              child: Text('Locate!')),
        ),
      ),
    );
  }
}
