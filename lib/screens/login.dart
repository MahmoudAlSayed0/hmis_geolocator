import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmis_geolocator/Utils/dialog_helper.dart';
import 'package:hmis_geolocator/Utils/my_navigator.dart';
import 'package:hmis_geolocator/Utils/validator_helper.dart';
import 'package:hmis_geolocator/logic/app/app_cubit.dart';

import 'package:hmis_geolocator/screens/home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          DialogHelper.showProgressIndicator(context);
        }
        if (state is LoginSuccess) {
          Navigator.pop(context);
          DialogHelper.showMessage(
              context, 'Success!', 'Login success', 'Aight', () {
            Navigator.pop(context);
            NavigatorHelper.pushReplacement(context, const HomeScreen());
          });
        }
        if (state is LoginFailure) {
          Navigator.pop(context);
          DialogHelper.showMessage(context, 'Username or Password is wrong!',
              'Username or Password is wrong!', 'Aight', () {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Username(Email)'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || !value.isValidEmail()) {
                            return 'Please enter a valid email address.';
                          }
                          return null;
                        }
                        return 'Please enter a valid email address.';
                      },
                      onSaved: (value) => cubit.email = value,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value != null) {
                          if (value.isEmpty || value.length < 7) {
                            return 'Password must be at least 7 characters long.';
                          }
                          return null;
                        }

                        return 'Password must be at least 7 characters long.';
                      },
                      onSaved: (value) => cubit.password = value,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => cubit.login(formKey),
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 20),
                  ],
                )),
          ),
        );
      },
    );
  }
}
