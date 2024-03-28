import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:insulin/src/ui/dashboard.dart';
import 'package:insulin/src/ui/data_graph.dart';
import 'package:insulin/src/ui/history_graph.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

PermissionStatus statusLocation = PermissionStatus.denied;
PermissionStatus statusBluetoothConnect = PermissionStatus.denied;
PermissionStatus statusNotification = PermissionStatus.denied;
/// device list page *
final Stream<ConnectionStatus> connectionStatusController = Stream<ConnectionStatus>.value(ConnectionStatus.connected);
StreamSubscription<ConnectionStatus>? subscribeStream;
bool scanStopped = false;

/// flchart page *
List<Color> gradientColors = [
  generateGradientColors(88),
  generateGradientColors(83),
  generateGradientColors(150),
  generateGradientColors(165),
  generateGradientColors(180),
    // Colors.grey,
    // Colors.grey.shade700,
  ];
// Function to generate custom gradient colors based on y-value
Color generateGradientColors(double yValue) {
  // Define your custom logic to generate gradient colors based on y-value
  // Example: Change gradient color based on y-value ranges
  if (yValue >= 70 && yValue < 90) {
    return Colors.yellow;
  } else if (yValue >= 90 && yValue < 140) {
    return Colors.green;
  } else {
    return Colors.red;
  }
}
List<int> bloodGlucose = [
  // 85 ,
  // 95 ,
  // 105 ,
  // 120 ,
  // 135 ,
  // 145 ,
  // 130 ,
  // 110 ,
  // 100 ,
  88 ,
  83 ,
  150 ,
  165 ,
  180
];
bool showAvg = false;

/// syncfusion page *
final List<ChartData> chartData = [
  ChartData(1, 100),
  ChartData(2, 150),
  ChartData(3, 120),
  ChartData(4, 200),
  ChartData(5, 180),
  ChartData(6, 220),
  ChartData(7, 250),
  ChartData(8, 200),
  ChartData(9, 120),
  ChartData(10, 150),
  ChartData(11, 130),
  ChartData(12, 135),
  ChartData(13, 160),
  ChartData(14, 159),
];
final List<CartesianSeries<ChartData, double>> chartDataSeries = [
  LineSeries<ChartData, double>(
    // Data source
    dataSource: chartData,
    // X value mapper
    xValueMapper: (ChartData data, _) => data.x,
    // Y value mapper
    yValueMapper: (ChartData data, _) => data.y,
    color:Colors.blue,
  ),
];

class ChartData {
    final double x; // X value
    final double y; // Y value

    ChartData(this.x, this.y);
  }
/// dashboard page *
DateTime now = DateTime.now();
String formattedDate = DateFormat('dd, MMMM').format(now);
String formattedTime = DateFormat('hh:mm a').format(now);
final List<Widget> pages = [const CurrentData(), const DashBoard(), const HistoryData()];