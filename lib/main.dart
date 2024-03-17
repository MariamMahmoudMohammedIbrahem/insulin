import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:insulin/src/ble/device_connector.dart';
import 'package:insulin/src/ble/device_interactor.dart';
import 'package:insulin/src/ble/logger.dart';
import 'package:insulin/src/ble/scanner.dart';
import 'package:insulin/src/ble/status_monitor.dart';
import 'package:insulin/src/constants.dart';
import 'package:insulin/src/permissions/bluetooth_permission.dart';
import 'package:insulin/src/permissions/location_permission.dart';
import 'package:insulin/src/permissions/permission.dart';
import 'package:insulin/src/ui/home_screen.dart';
import 'package:insulin/src/ui/status_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  //get the status of location and bluetooth
  statusLocation = await Permission.location.status;
  statusBluetoothConnect = await Permission.bluetoothConnect.status;
  final ble = FlutterReactiveBle();
  final bleLogger = BleLogger(ble: ble);
  final scanner = BleScanner(ble: ble, logMessage: bleLogger.addToLog);
  final monitor = StatusMonitor(ble);
  final connector = DeviceConnector(
    ble: ble,
    logMessage: bleLogger.addToLog,
  );
  final serviceDiscoverer = DeviceInteractor(
    bleDiscoverServices: (deviceId) async {
      await ble.discoverAllServices(deviceId);
      return ble.getDiscoveredServices(deviceId);
    },
    readCharacteristic: ble.readCharacteristic,
    writeWithResponse: ble.writeCharacteristicWithResponse,
    writeWithOutResponse: ble.writeCharacteristicWithoutResponse,
    subscribeToCharacteristic: ble.subscribeToCharacteristic,
    logMessage: bleLogger.addToLog,
  );
  runApp(
      MultiProvider(
        providers: [
          Provider.value(value: scanner),
          Provider.value(value: monitor),
          Provider.value(value: connector),
          Provider.value(value: serviceDiscoverer),
          Provider.value(value: bleLogger),
          StreamProvider<ScannerState?>(
            create: (_) => scanner.state,
            initialData: const ScannerState(
              discoveredDevices: [],
              scanIsInProgress: false,
            ),
          ),
          StreamProvider<BleStatus?>(
            create: (_) => monitor.state,
            initialData: BleStatus.unknown,
          ),
          ChangeNotifierProvider(
            create: (context) => PermissionProvider(),
          ),
          StreamProvider<ConnectionStateUpdate>(
            create: (_) => connector.state,
            initialData: const ConnectionStateUpdate(
              deviceId: 'Unknown device',
              connectionState: DeviceConnectionState.disconnected,
              failure: null,
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Insulin',
          color: Colors.grey.shade700,
          theme: ThemeData.dark(),
          home: const MyApp(),
        ),
  ));
  FlutterReactiveBle();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => Consumer2<BleStatus?, PermissionProvider>(
    builder: (_, status, permission, __) {
      if (status == BleStatus.ready && permission.bluetoothStatus.isGranted && permission.locationStatus.isGranted) {
        return const HomeScreen();
      }
      else if(permission.locationStatus.isDenied){
        permission.requestLocationPermission();
        return const LocationPermission();
      }
      else if(permission.bluetoothStatus.isDenied){
        permission.requestBluetoothPermission();
        return const BluetoothPermission();
      }
      else {
        return StatusScreen(status: status ?? BleStatus.unknown);
      }
    },
  );
}