import 'package:flutter/material.dart';
import 'package:qrail_fp/project/screens/Booking/add_train_booking.dart';
import 'package:qrail_fp/project/screens/home_pages/home_page.dart';
import 'package:qrail_fp/project/screens/profile_section/profile_list.dart';
import 'package:qrail_fp/project/screens/train_schedule/train_schedule.dart';
//import 'package:google_fonts/google_fonts.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});
  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int currentPageIndex = 0;
  final pages = [
    const FeaturedScreen(),
    const TrainSchedule(),
    const AddTrainScreen(),
    const ProfileSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.blueGrey,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        destinations: const <Widget>[
          NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home'),
          NavigationDestination(
              selectedIcon: Icon(Icons.train),
              icon: Icon(Icons.train_outlined),
              label: 'Trains'),
        
          NavigationDestination(
              selectedIcon: Icon(Icons.book_online),
              icon: Icon(Icons.book_online_outlined),
              label: 'Booking'),
          NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_2_outlined),
              label: 'Profile'),
        ],
      ),
    );
  }
}
