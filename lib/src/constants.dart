import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:permission_handler/permission_handler.dart';

PermissionStatus statusLocation = PermissionStatus.denied;
PermissionStatus statusBluetoothConnect = PermissionStatus.denied;
/// device list page *
final Stream<ConnectionStatus> connectionStatusController = Stream<ConnectionStatus>.value(ConnectionStatus.connected);
StreamSubscription<ConnectionStatus>? subscribeStream;
bool scanStopped = false;