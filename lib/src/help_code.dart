///*device list*///
// void _connect() {
//   for (var device in widget.scannerState.discoveredDevices) {
//     widget.deviceConnector.connect(device.id);
//     subscribeStream = connectionStatusController.listen((event) {
//       if (event == ConnectionStatus.connected) {
//         subscribeStream?.cancel();
//       } else if (event == ConnectionStatus.connecting) {
//         Fluttertoast.showToast(
//           msg: 'connecting',
//           toastLength: Toast.LENGTH_LONG,
//         );
//       }
//     });
//   }
// }