import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wbfactory/constants/colors.dart';
import 'package:wbfactory/resources/shop_methods.dart';

import '../../../../../components/buttons/main_button.dart';
import '../../../../../constants/consts.dart';

class VerifyAddressPage extends StatefulWidget {
  final Map<String, String> addressInput;

  const VerifyAddressPage({super.key, required this.addressInput});

  @override
  State<VerifyAddressPage> createState() => _VerifyAddressPageState();
}

class _VerifyAddressPageState extends State<VerifyAddressPage> {
  bool _isLoading = false;

  // var lat;
  // var lng;

  LatLng _draggedMarkerPosition = const LatLng(40.6327339, -73.8895841);

  late final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _storeLocation = CameraPosition(
    target: LatLng(40.6327339, -73.8895841),
    zoom: 16,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(40.6327339, -73.8895841),
      infoWindow: InfoWindow(title: 'Teriyaki Bowl'),
    ),
  ];

  @override
  void initState() {
    _marker.addAll(_list);
    locateAddress();
    super.initState();
  }

  void _getMarkerPosition() {
    // Access the _markerPosition variable to get the marker's coordinates
    double latitude = _draggedMarkerPosition.latitude;
    double longitude = _draggedMarkerPosition.longitude;

    // You can use the latitude and longitude as needed, e.g., display in a dialog or print to the console
    print('Marker Position: Latitude: $latitude, Longitude: $longitude');
  }

  void _updateMarkerPosition(LatLng newPosition) {
    setState(() {
      _draggedMarkerPosition = newPosition;
    });
  }

  Future<void> locateAddress() async {
    setState(() {
      _isLoading = true;
    });

    List<Location> locations = await locationFromAddress(
        "${widget.addressInput['street']!}, ${widget.addressInput['city']!}, ${widget.addressInput['country']!}- ${widget.addressInput['zip']!}");

    _marker.add(
      Marker(
        markerId: const MarkerId("2"),
        position: LatLng(locations.last.latitude, locations.last.longitude),
        infoWindow: const InfoWindow(title: "Your saved location"),
        draggable: true,
        // Allow the marker to be dragged
        onDragEnd: (LatLng newPosition) {
          _updateMarkerPosition(newPosition);
        },
      ),
    );

    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locations.last.latitude, locations.last.longitude),
      zoom: 16,
    );

    final GoogleMapController controller = await _controller.future;

    setState(() {
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      _draggedMarkerPosition =
          LatLng(locations.last.latitude, locations.last.longitude);
      _isLoading = false;
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      customToast(
          "Error: Please provide location permission. : $error", secondaryColor, context);
    });

    return await Geolocator.getCurrentPosition();
  }

  void addAddressToDatabase() async {
    setState(() {
      _isLoading = true;
    });

    String message = await ShopMethods().addAddress(
      addressInput: widget.addressInput,
      latitude: _draggedMarkerPosition.latitude,
      longitude: _draggedMarkerPosition.longitude,
    );

    if (message == 'success') {
      setState(() {
        _isLoading = false;
      });
      showingSnackbar("Address added successfully");
      Get.close(2);
    } else {
      setState(() {
        _isLoading = false;
      });
      showingSnackbar("Error: $message");
    }
  }

  void showingSnackbar(message) {
    customToast("$message", secondaryColor, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryColor,
        centerTitle: true,
        title: const Text(
          "Add New Address",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: lightColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: lightColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: _storeLocation,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: Set<Marker>.of(_marker),
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          ),
          12.heightBox,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: _isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            )
                : MainButton(
              title: "Save Address",
              onTap: addAddressToDatabase,
            ),
          ),
          12.heightBox,
        ],
      ),
    );
  }
}
