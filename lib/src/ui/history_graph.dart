import 'package:flutter/material.dart';

import '../constants.dart';

class HistoryData extends StatelessWidget {
  const HistoryData({super.key});

  @override
  Widget build(BuildContext context) {
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
              currentIndex: 2,
              onTap: (int index) {
                // currentIndex = index;
                if(index != 2){
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