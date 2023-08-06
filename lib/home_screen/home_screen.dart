
import 'package:flutter/material.dart';

import '../bottom_nav_controllers/notification.dart';
import '../bottom_nav_controllers/downloads.dart';
import '../bottom_nav_controllers/home.dart';
import '../bottom_nav_controllers/search.dart';
import '../bottom_nav_controllers/settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final pages = [
    const Home(),
    const Search(),
    const Downloads(),
    const Notifications(),
    const Settings(),
  ];

  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        selectedItemColor: Colors.brown,
        backgroundColor: Colors.brown.shade900,
        unselectedItemColor: Colors.grey,
        currentIndex: currentIndex,
        selectedLabelStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold
        ),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search_sharp),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.download_rounded),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_important_outlined),
              label: ""
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: ""
          ),
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: pages[currentIndex],
    );
  }
}