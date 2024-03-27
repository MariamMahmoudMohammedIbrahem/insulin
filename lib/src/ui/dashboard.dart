import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:insulin/src/constants.dart';
import 'package:insulin/src/ui/flchart.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: width * .8,
                  // height: height*.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Glycemia: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formattedTime,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      '${bloodGlucose.last}',
                                      style: const TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      ' mg/dL',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Last Scan: ',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${bloodGlucose[3]}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const Text(
                                      ' mg/dL',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Growth: ',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  bloodGlucose.last > bloodGlucose[3]
                                      ? 'Hyperglycemia'
                                      : bloodGlucose.last == bloodGlucose[3]
                                          ? 'Normoglycemia'
                                          : 'Hypoglycemia',
                                  style: const TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  width: width * 0.8,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(
                      width: 2,
                      color: Colors.grey,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Monitoring: ',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              bloodGlucose.last > bloodGlucose[3]
                                  ? 'Hyperglycemia'
                                  : bloodGlucose.last == bloodGlucose[3]
                                      ? 'Normoglycemia'
                                      : 'Hypoglycemia',
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height *
                              0.2, // Set a specific height for LineChart
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 30.0),
                            child: LineChart(
                              mainData(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
              currentIndex: 1,
              onTap: (int index) {
                setState(() {
                  // currentIndex = index;
                  if(index != 1){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>pages[index]));
                  }
                });
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
