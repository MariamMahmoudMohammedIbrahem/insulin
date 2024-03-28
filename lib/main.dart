import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:insulin/src/ble/device_connector.dart';
import 'package:insulin/src/ble/device_interactor.dart';
import 'package:insulin/src/ble/logger.dart';
import 'package:insulin/src/ble/scanner.dart';
import 'package:insulin/src/ble/status_monitor.dart';
import 'package:insulin/src/constants.dart';
import 'package:insulin/src/permissions/permission.dart';
import 'package:insulin/src/ui/dashboard.dart';
import 'package:insulin/src/ui/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  //get the status of location and bluetooth
  WidgetsFlutterBinding.ensureInitialized();
  statusLocation = await Permission.location.status;
  statusBluetoothConnect = await Permission.bluetoothConnect.status;
  statusNotification = await Permission.notification.status;
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
          debugShowCheckedModeBanner: false,
          title: 'Insulin',
          color: Colors.blue.shade200,
          theme: ThemeData.dark().copyWith(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
            ),
          ),
          home: const SplashScreen(),
        ),
  ));
  FlutterReactiveBle();
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  void _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    setState(() {
      _isFirstTime = isFirstTime;
    });
  }


  @override
  Widget build(BuildContext context) {
    if (_isFirstTime) {
      return const HomeScreen();
    } else {
      // Show your main app content
      // return const ScanningListScreen();
      return const DashBoard();
    }
  }
}