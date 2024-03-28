import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:insulin/src/permissions/location_permission.dart';
import 'package:insulin/src/ui/status_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../device_detail/device_list.dart';
import '../permissions/bluetooth_permission.dart';
import '../permissions/permission.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  int _currentPageIndex = 0;
  final List<Widget> _pages = [
    const PageContent(
      image: AssetImage('images/bluetooth.png'),
      content: 'This is the first page',
    ),
    const PageContent(
      image: AssetImage('images/location.png'),
      content: 'This is the second page',
    ),
    const PageContent(
      image: AssetImage('images/off.jpg'),
      content: 'This is the third page',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * .1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const ScanningListScreen(),),);
                  },
                  child: const Text(
                    'SKIP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: width * .8,
                height: height * .5,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _pages[index % _pages.length];
                  },
                  onPageChanged: (index) {
                    setState(() {
                      _currentPageIndex = index;
                    });
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: _pageController,
                count: 3, // Number of pages
                effect: const WormEffect(
                  activeDotColor: Color(0xff3498db),
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.thinUnderground,
                ),
              ),
              SizedBox(
                width: width * .8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff3498db),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyApp(),),);
                  },
                  child: const Text(
                    'NEXT',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPageIndex < _pages.length - 1) {
        _currentPageIndex++;
      } else {
        _currentPageIndex = 0;
      }
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

}

class PageContent extends StatelessWidget {
  final ImageProvider image;
  final String content;

  const PageContent({
    Key? key,
    required this.image,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(image: Image(image: image).image),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Consumer2<BleStatus?, PermissionProvider>(
    builder: (_, status, permission, __) {
      if (status == BleStatus.ready && permission.bluetoothStatus.isGranted && permission.locationStatus.isGranted && permission.notificationStatus.isGranted) {
        return const ScanningListScreen();
      }
      else if(permission.locationStatus.isDenied){
        permission.requestLocationPermission();
        return const LocationPermission();
      }
      else if(permission.bluetoothStatus.isDenied){
        permission.requestBluetoothPermission();
        return const BluetoothPermission();
      }
      else if(permission.notificationStatus.isDenied){
        permission.requestNotificationPermission();
        return const BluetoothPermission();
      }
      else {
        return StatusScreen(status: status ?? BleStatus.unknown);
      }
    },
  );
}