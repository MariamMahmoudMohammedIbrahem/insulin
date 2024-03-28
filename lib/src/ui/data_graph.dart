import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../constants.dart';

class CurrentData extends StatelessWidget {
  const CurrentData({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: const Icon(
          Icons.person_pin,
        ),
        title: Text(
          'Today $formattedDate',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.menu_open_outlined,
            ),
          ),
        ],
      ),
      body: Center(
        child: SizedBox(
          width: width * 0.8,
          height: height * 0.4,
          child: SfCartesianChart(
            enableMultiSelection: true,
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
                pointColorMapper: (ChartData data, _) =>
                    generateGradientColors(data.y),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40)),
          child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.grey.shade400,
              iconSize: 20.0,
              selectedIconTheme: const IconThemeData(size: 28.0),
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey.shade700,
              selectedFontSize: 16.0,
              unselectedFontSize: 12,
              currentIndex: 0,
              onTap: (int index) {
                  // currentIndex = index;
                  if(index != 0){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>pages[index]));
                  }
              },
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.auto_graph),
                  label: "Data",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard_outlined),
                  label: "DashBoard",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history_toggle_off),
                  label: "History",
                ),
              ]),
        ),
      ),
    );
  }
}
