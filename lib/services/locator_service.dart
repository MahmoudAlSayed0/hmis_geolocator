import 'package:location/location.dart';

class LocationServiceHelper {
  ///It requests access to location permission and enabling location service

  LocationServiceHelper._();
  static Future<LocationData?> getPermissionsAndLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }
}
