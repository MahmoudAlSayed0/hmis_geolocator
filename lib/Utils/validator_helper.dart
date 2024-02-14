import 'package:hmis_geolocator/models/response_object.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

String? basicValidator(ResponseObject? value) {
  if (value == null) return 'Choose a governrate';
  if (value.name == null) return 'Choose a governrate';
  if (value.name!.isEmpty) return 'Choose a governrate';
  return null;
}
