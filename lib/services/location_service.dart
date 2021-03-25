import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:majalatek/services/providers_service.dart';

class LocationService {
  static LocationService instance = LocationService._();
  Map<String, double> realTimeLocation = {"lng": 3.1686738, "lat": 36.7071175};
  GoogleMapController mapController;
  Location location = Location()
    ..changeSettings(accuracy: LocationAccuracy.balanced);
  final int frequency = 20;
  int times = 0;
  LocationService._() {
    location.onLocationChanged.listen((event) async {
      times++;
      if (times == frequency) {
        times = 0;
        ProvidersService.instance
            .updateLocation(event.latitude, event.longitude);
      }
    });
  }

  Future locatePosition() async {
    var data = await location.getLocation();
    realTimeLocation["lng"] = data.longitude;
    realTimeLocation["lat"] = data.latitude;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(data.latitude, data.longitude), zoom: 11),
      ),
    );
  }

  Future checkLocationPermission() async {
    try {
      bool _serviceEnabled;
      PermissionStatus _permissionGranted;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  onMapCreate(GoogleMapController controller) async {
    try {
      mapController = controller;
    } catch (e) {
      debugPrint("error->" + e.toString());
    }
  }
}
