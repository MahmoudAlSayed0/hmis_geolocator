import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmis_geolocator/Utils/drop_down_search_widget.dart';
import 'package:hmis_geolocator/Utils/my_navigator.dart';
import 'package:hmis_geolocator/logic/app/app_cubit.dart';
import 'package:hmis_geolocator/models/response_object.dart';
import 'package:hmis_geolocator/screens/map.dart';
import 'package:hmis_geolocator/services/locator_service.dart';
import 'package:location/location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is GotLocation) {
          AppCubit.get(context).location =
              NavigatorHelper.push(context, MapScreen(data: state.data));
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  DropDownSearchWidget(
                    label: 'Governrate',
                    onChanged: cubit.setSelectedGovern,
                    selectedItem: cubit.selectedGovernrate,
                    asyncItemsFunction: cubit.getGovernsListItems,
                    enabled: true,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DropDownSearchWidget(
                    label: 'District',
                    onChanged: cubit.setSelectedDistrict,
                    selectedItem: cubit.selectedGovernrate,
                    asyncItemsFunction: cubit.getDistrictsListItems,
                    enabled: cubit.selectedGovernrate != null,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DropDownSearchWidget(
                    label: 'Clinic',
                    onChanged: cubit.setSelectedClinic,
                    selectedItem: cubit.selectedClinic,
                    asyncItemsFunction: cubit.getClinicsListItems,
                    enabled: cubit.selectedDistrict != null,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: /* cubit.selectedClinic == null
                          ? null
                          :  */
                          () async {
                        await cubit.locate(context);
                      },
                      child: const Text('Locate!'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
