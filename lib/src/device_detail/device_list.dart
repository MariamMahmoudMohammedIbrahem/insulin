import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:functional_data/functional_data.dart';
import 'package:insulin/src/device_detail/device_interaction_tab.dart';
import 'package:provider/provider.dart';

import '../ble/device_connector.dart';
import '../ble/logger.dart';
import '../ble/scanner.dart';
import '../constants.dart';

part 'device_list.g.dart';

//ignore_for_file: annotate_overrides

class ScanningListScreen extends StatelessWidget {
  const ScanningListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Consumer5<BleScanner, ScannerState?,
          BleLogger, DeviceConnector, ConnectionStateUpdate>(
        builder: (_, bleScanner, bleScannerState, bleLogger, deviceConnector,
                connectionStateUpdate, __) =>
            Scanning(
          scannerState: bleScannerState ??
              const ScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScan,
          stopScan: bleScanner.stopScan,
          deviceConnector: deviceConnector,
          connectionStatus: connectionStateUpdate.connectionState,
        ),
      );
}

@immutable
@FunctionalData()
class ScanningList extends $ScanningList {
  const ScanningList({
    required this.deviceId,
    required this.deviceConnector,
    required this.discoverServices,
  });

  final String deviceId;
  final DeviceConnector deviceConnector;
  @CustomEquality(Ignore())
  final Future<List<DiscoveredService>> Function() discoverServices;
}

class Scanning extends StatefulWidget {
  const Scanning({
    super.key,
    required this.scannerState,
    required this.startScan,
    required this.stopScan,
    required this.deviceConnector,
    required this.connectionStatus,
  });

  final ScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;
  final DeviceConnector deviceConnector;
  final DeviceConnectionState connectionStatus;
  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Page'),
      ),
      body: ListView(
        children: [
          ...widget.scannerState.discoveredDevices.map(
            (e) => ListTile(
              title: Text(e.name.isEmpty ? 'UNNAMED' : e.name),
              subtitle: Text(e.id),
              onTap: () {
                // _connect();
                widget.deviceConnector
                    .connect(e.id)
                    .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeviceInteractionTab(
                              device: e,
                            characteristic:
                            QualifiedCharacteristic(
                              characteristicId: Uuid.parse(
                                  "0000ffe1-0000-1000-8000-00805f9b34fb"),
                              serviceId: Uuid.parse(
                                  "0000ffe0-0000-1000-8000-00805f9b34fb"),
                              deviceId: e.id,
                            ),
                              ),
                        )));
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _startScanning();
  }

  void _startScanning() {
    if (!widget.scannerState.scanIsInProgress) {
      widget.startScan([]);
      // Future.delayed(const Duration(seconds: 2), () {
      //   if (scanStopped) {
      //     _connect();
      //   }
      // });
    }
  }

  void _connect() {
    for (var device in widget.scannerState.discoveredDevices) {
      widget.deviceConnector.connect(device.id);
      subscribeStream = connectionStatusController.listen((event) {
        if (event == ConnectionStatus.connected) {
          subscribeStream?.cancel();
        } else if (event == ConnectionStatus.connecting) {
          Fluttertoast.showToast(
            msg: 'connecting',
            toastLength: Toast.LENGTH_LONG,
          );
        }
      });
    }
  }
}
