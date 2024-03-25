import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';

class SyncFusion extends StatefulWidget {
  const SyncFusion({super.key});

  @override
  State<SyncFusion> createState() => _SyncFusionState();
}

class _SyncFusionState extends State<SyncFusion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SyncFusion Graph'),centerTitle: true,),
      body: SfCartesianChart(
        primaryXAxis: const NumericAxis(),
        primaryYAxis: const NumericAxis(),
        zoomPanBehavior: ZoomPanBehavior(
          enablePinching: true,
          enablePanning: true,
        ),
        series: <CartesianSeries>[
          LineSeries<ChartData, double>(
            // Data source
            dataSource: chartData,
            // X value mapper
            xValueMapper: (ChartData data, _) => data.x,
            // Y value mapper
            yValueMapper: (ChartData data, _) => data.y,
          ),
        ],

      ),
    );
  }
}
