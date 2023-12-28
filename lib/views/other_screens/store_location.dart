import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../components/buttons/back_button.dart';
import '../../constants/colors.dart';

class StoreLocation extends StatefulWidget {
  const StoreLocation({super.key});

  @override
  State<StoreLocation> createState() => _StoreLocationState();
}

class _StoreLocationState extends State<StoreLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _storeLocation = CameraPosition(
    target: LatLng(40.776790, -73.817270),
    zoom: 16,
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(40.776790, -73.817270),
        infoWindow: InfoWindow(title: 'Whitestone Bagel Factory')),
  ];

  @override
  void initState() {
    _marker.addAll(_list);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightColor,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: const Text("Location", style: TextStyle(fontWeight: FontWeight.w500),),
        centerTitle: true,
        leading: backButton(
          onTap: () {
            Get.back();
          },
        ),
        leadingWidth: 90,
      ),
      body: GoogleMap(
        initialCameraPosition: _storeLocation,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: Set<Marker>.of(_marker),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
