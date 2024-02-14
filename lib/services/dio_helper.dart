import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

Future<dynamic> get(String Url) async {
  var response = await Dio().get(Url,
      options: Options(receiveTimeout: null, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL2FjY2Vzc2NvbnRyb2xzZXJ2aWNlLzIwMTAvMDcvY2xhaW1zL2lkZW50aXR5cHJvdmlkZXIiOiIxIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvbmFtZSI6Ik1vaGFtZWQgRmF0aHkiLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiIxMCIsIlJvbGVJRCI6IjEwIiwiR292ZXJJRCI6IiIsIkRpc3RyaWN0SUQiOiIiLCJleHAiOjE3MDc5MTMxMzYsImlzcyI6ImFjcy1lZ3lwdC5jb20iLCJhdWQiOiJhY3MtZWd5cHQuY29tIn0.bp6L35WTx9sDjy2EeaLBWwOGj6Dt_O2yLa546r7SvIY'
      }));
  log('response' + response.toString());
  if (response.statusCode == 200) {
    return response.data;
  } else {
    throw Exception('Error ${response.statusCode} ${response.statusMessage}');
  }
}

Future<dynamic> post(
    {required Url, dynamic body, dynamic token, String? contentType}) async {
  Map<String, dynamic> headers = {};
  if (token != null) {
    headers.addAll({
      HttpHeaders.authorizationHeader: token,
    });
  }
  if (contentType != null) {
    headers.addAll({
      HttpHeaders.contentTypeHeader: contentType,
    });
  }
  var response = await Dio().post(
    Url,
    options: Options(headers: headers),
    data: body,
  );
  if (response.statusCode! < 299) {
    return response;
  } else {
    throw Exception('Error ${response.statusCode} ${response.statusMessage}');
  }
}
