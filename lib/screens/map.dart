import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hmis_geolocator/logic/app/app_cubit.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.data});
  final LocationData data;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController mapController = MapController();
  late LatLng loc;
  late double accuracy;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loc = LatLng(widget.data.latitude!, widget.data.longitude!);
    accuracy = widget.data.accuracy == null && widget.data.accuracy == 0
        ? 30
        : widget.data.accuracy!;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) => context.read<AppCubit>().setLocation(loc),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Is this your location?'),
          actions: [
            OutlinedButton(
                onPressed: () {
                  context.read<AppCubit>().setLocation(loc);
                  Navigator.pop(context);
                },
                child: const Text('Confirm'))
          ],
        ),
        body: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              // [log] LocationData<lat: 30.056095, long: 31.1946043>
              options: MapOptions(
                initialCenter: loc,
                initialZoom: 18,
                minZoom: 12,
                maxZoom: 18,
                interactionOptions: const InteractionOptions(
                    flags: InteractiveFlag.all & ~InteractiveFlag.rotate),
                onTap: (tapPosition, point) {
                  log(point.toString());
                  loc = point;
                  mapController.move(loc, 20);

                  setState(() {});
                },
              ),

              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                CircleLayer(
                  circles: [
                    CircleMarker(
                        point: loc,
                        radius: accuracy,
                        useRadiusInMeter: true,
                        color: Colors.blue.withOpacity(.4))
                  ],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: loc,
                      width: 20,
                      height: 20,
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                      rotate: true,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
