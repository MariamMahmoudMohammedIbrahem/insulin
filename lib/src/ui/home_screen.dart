import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insulin/src/ui/dashboard.dart';
import 'package:insulin/src/ui/flchart.dart';
import 'package:insulin/src/ui/syncfusion.dart';

import '../constants.dart';
import '../device_detail/device_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width*.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey.shade300,),
                  onPressed: () {},
                  child: const Text(
                    'SKIP',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                width: width * .8,
                height: height * .4,
                child: PageView(
                  controller: _pageController,
                  children: [
                    Image.asset('images/bluetooth.png', fit: BoxFit.cover),
                    Image.asset('images/location.png', fit: BoxFit.cover),
                    Image.asset('images/off.jpg', fit: BoxFit.cover),
                  ],
                ),
              ),
              Positioned(
                bottom: 20.0,
                left: 0,
                right: 0,
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 3, // Number of pages
                  effect: const WormEffect(
                    activeDotColor: Color(0xff3498db),
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.thinUnderground,
                  ),
                ),
              ),
              SizedBox(
                width: width*.8,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff3498db),),
                  onPressed: () {},
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
}
