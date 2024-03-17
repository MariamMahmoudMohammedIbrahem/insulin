import 'package:flutter/cupertino.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:functional_data/functional_data.dart';
import 'package:provider/provider.dart';

import '../ble/device_connector.dart';
import '../ble/scanner.dart';

part 'device_list.g.dart';

//ignore_for_file: annotate_overrides

class ScanningListScreen extends StatelessWidget {
  const ScanningListScreen({Key? key, required this.userName})
      : super(key: key);
  final String userName;
  @override
  Widget build(BuildContext context) => Consumer5<BleScanner, ScannerState?,
          Logger, DeviceConnector, ConnectionStateUpdate>(
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
          userName: userName,
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
  const Scanning(
      {super.key,
      required ScannerState scannerState,
      required void Function(List<Uuid> serviceIds) startScan,
      required Future<void> Function() stopScan,
      required DeviceConnector deviceConnector,
      required String userName,
      required DeviceConnectionState connectionStatus});

  @override
  State<Scanning> createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
