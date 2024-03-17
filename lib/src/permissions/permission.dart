
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';

class PermissionProvider extends ChangeNotifier {
  // Define the permissions you want to manage
  PermissionStatus _locationStatus = statusLocation;
  PermissionStatus _bluetoothStatus = statusBluetoothConnect;

  // Getters for permission statuses
  PermissionStatus get locationStatus => _locationStatus;
  PermissionStatus get bluetoothStatus => _bluetoothStatus;

  // Function to request location permission
  Future<void> requestLocationPermission() async {
    final status = await Permission.location.status;
    _locationStatus = status;
    notifyListeners();
  }

  // Function to request camera permission
  Future<void> requestBluetoothPermission() async {
    final status = await Permission.bluetoothConnect.status;
    _bluetoothStatus = status;
    notifyListeners();
  }
}