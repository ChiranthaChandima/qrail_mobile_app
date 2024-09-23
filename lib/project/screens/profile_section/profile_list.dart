// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qrail_fp/project/screens/Booking/booking_history_list.dart';
import 'package:qrail_fp/project/screens/profile_section/profile_section.dart';
import 'package:qrail_fp/project/screens/widgets/profile_menu_widget.dart';

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                //Image
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/logo1.jpg'),
                    radius: 40.0,
                  ),
                ),
                SizedBox(height: 10),
                Text('Yudeesha', style: Theme.of(context).textTheme.headlineMedium),
                Text('yudeesha@gmail.com',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 20),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => const Profile()),
                      );
                    },
                    //onPressed: () => Get.to(() => const UpdateProfileScreen()),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('View Profile',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),

                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),

                //Menu items
                ProfileMenuWidget(
                    title: "Travel History",
                    icon: Icons.train_outlined,
                    onPress: () {}),
                ProfileMenuWidget(
                    title: "Booking History",
                    icon: Icons.book_online_outlined,
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const BookingHistory()),
                      );
                    }),

                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Logout",
                    icon: Icons.logout_outlined,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      // Get.defaultDialog(
                      //   title: "LOGOUT",
                      //   titleStyle: const TextStyle(fontSize: 20),
                      //   // content: const Padding(
                      //   //   padding: EdgeInsets.symmetric(vertical: 15.0),
                      //   //   child: Text("Are you sure, you want to Logout?"),
                      //   // ),
                      //   confirm: Expanded(
                      //     child: ElevatedButton(
                      //       onPressed: (){},
                      //       style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent, side: BorderSide.none),
                      //       child: const Text("Yes"),
                      //     ),
                      //   ),

                      //   // ...

                      //   cancel: OutlinedButton(onPressed: () => Get.back(), child: const Text("No")),
                      // );
                    }),
              ],
            ),
          ),
        ));
  }
}
