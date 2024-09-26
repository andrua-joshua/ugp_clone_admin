
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsScreen extends StatefulWidget{
  final Marker stationMarker;
  const GoogleMapsScreen({super.key, required this.stationMarker});


  @override
  GoogleMapsScreenState createState() => GoogleMapsScreenState();

}

class GoogleMapsScreenState extends State<GoogleMapsScreen>{
  
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late final CameraPosition _kGooglePlex;

  late final CameraPosition _kLake;

  
  @override
  void initState() {
    super.initState();

    _kGooglePlex = CameraPosition(
      target: widget.stationMarker.position,
      zoom: 14.4746,
    );

    _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: widget.stationMarker.position,
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  }
      

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: {
          widget.stationMarker
        },
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

}