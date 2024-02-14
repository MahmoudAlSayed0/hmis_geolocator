// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GettingLocation extends AppState {}

class LocationSuccess extends AppState {}

class LocationFailure extends AppState {}

class LoginLoading extends AppState {}

class LoginSuccess extends AppState {}

class LoginFailure extends AppState {}

class SetGovernrate extends AppState {}

class GotLocation extends AppState {
  LocationData data;
  GotLocation({
    required this.data,
  });
}

class ConfirmedLocation extends AppState {}
