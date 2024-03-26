import 'package:flutter/material.dart';
import 'package:insulin/src/ui/dashboard.dart';
import 'package:insulin/src/ui/flchart.dart';
import 'package:insulin/src/ui/syncfusion.dart';

import '../device_detail/device_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScanningListScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              child: const Text('BLE', style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              child: const Text('NFC', style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const FlChart()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              child: const Text('FL-CHART', style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const SyncFusion()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              child: const Text('SYNCFUSION', style: TextStyle(color: Colors.black),),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> const DashBoard()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade200,
              ),
              child: const Text('dashboard', style: TextStyle(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
