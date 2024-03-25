
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class FlChart extends StatefulWidget {
  const FlChart({super.key});

  @override
  State<FlChart> createState() => _FlChartState();
}

class _FlChartState extends State<FlChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GRAPH'),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 2.0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal:20,
            ),
            child: LineChart(
              mainData(),
              // swapAnimationDuration: Duration(milliseconds: 250),
              // interactive: true,
            ),
          ),
        ),
      ),
    );
  }
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('1', style: style);
      break;
    case 1:
      text = const Text('2', style: style);
      break;
    case 2:
      text = const Text('3', style: style);
      break;
    case 3:
      text = const Text('4', style: style);
      break;
    case 4:
      text = const Text('5', style: style);
      break;
    case 5:
      text = const Text('6', style: style);
      break;
    case 6:
      text = const Text('7', style: style);
      break;
    case 7:
      text = const Text('8', style: style);
      break;
    case 8:
      text = const Text('9', style: style);
      break;
    case 9:
      text = const Text('10', style: style);
      break;
    case 10:
      text = const Text('11', style: style);
      break;
    case 11:
      text = const Text('12', style: style);
      break;
    case 12:
      text = const Text('13', style: style);
      break;
    case 13:
      text = const Text('14', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}

Widget leftTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  String text;
  switch (value.toInt()) {
    // case 70:
    //   text = '70';
    //   break;
    case 80:
      text = '80';
      break;
    // case 90:
    //   text = '90';
    //   break;
    case 100:
      text = '100';
      break;
    // case 110:
    //   text = '110';
    //   break;
    case 120:
      text = '120';
      break;
    // case 130:
    //   text = '130';
    //   break;
    case 140:
      text = '140';
      break;
    // case 150:
    //   text = '150';
    //   break;
    case 160:
      text = '160';
      break;
    // case 170:
    //   text = '170';
    //   break;
    case 180:
      text = '180';
      break;
    // case 190:
    //   text = '190';
    //   break;
    case 200:
      text = '200';
      break;
    // case 210:
    //   text = '210';
    //   break;
    case 220:
      text = '220';
      break;
    // case 230:
    //   text = '230';
    //   break;
    default:
      return Container();
  }

  return Text(
    text,
    style: style,
    textAlign: TextAlign.center,
  );
}

LineChartData mainData() {
  return LineChartData(
    // backgroundColor: Colors.grey.shade200,
    gridData: const FlGridData(
      show: true,
      drawVerticalLine: true,
      // space between lines
      horizontalInterval: 20,
      verticalInterval: 1,
      // size of lines
      // getDrawingHorizontalLine: (value) {
      //   return FlLine(
      //     color: Colors.blueGrey,
      //     strokeWidth: 1,
      //   );
      // },
      // getDrawingVerticalLine: (value) {
      //   return FlLine(
      //     color: Colors.grey,
      //     strokeWidth: 1,
      //   );
      // },
    ),
    titlesData: const FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 14,
    minY: 70,
    maxY: 230,
    lineBarsData: [
      LineChartBarData(
        // spots: [ // data of the curver
        //   FlSpot(0, 20),
        //   FlSpot(2, 37.5),
        //   FlSpot(4, 37.8),
        //   FlSpot(6, 38.01),
        //   FlSpot(8, 38.01),
        //   FlSpot(9, 38),
        //   FlSpot(11, 38.01),
        //   FlSpot(12, 38.01),
        // ],
        spots: bloodGlucose
            .map((e) => FlSpot(bloodGlucose.indexOf(e).toDouble(), e))
            .toList(),
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
        ),
        // width of curve
        barWidth: 5,
        isStrokeCapRound: false,
        dotData: const FlDotData(
          show: true,
        ),
        // belowBarData: BarAreaData(
        //   show: false,
        //   gradient: LinearGradient(
        //     colors:
        //         gradientColors.map((color) => color.withOpacity(0.3)).toList(),
        //   ),
        // ),
      ),
    ],
  );
}

LineChartData avgData() {
  return LineChartData(
    lineTouchData: const LineTouchData(enabled: false),
    gridData: FlGridData(
      show: true,
      drawHorizontalLine: true,
      verticalInterval: 1,
      horizontalInterval: 1,
      getDrawingVerticalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          color: Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    titlesData: const FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTitlesWidget: bottomTitleWidgets,
          interval: 1,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
          interval: 1,
        ),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
    ),
    borderData: FlBorderData(
      show: true,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 11,
    minY: 0,
    maxY: 6,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3.44),
          FlSpot(2.6, 3.44),
          FlSpot(4.9, 3.44),
          FlSpot(6.8, 3.44),
          FlSpot(8, 3.44),
          FlSpot(9.5, 3.44),
          FlSpot(11, 3.44),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)!,
          ],
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!
                  .withOpacity(0.1),
            ],
          ),
        ),
      ),
    ],
  );
}
