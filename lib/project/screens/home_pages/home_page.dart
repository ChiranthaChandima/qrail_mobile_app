// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qrail_fp/data/schedule_data.dart';
import 'package:qrail_fp/project/screens/ticket_view/ticket_detail.dart';
import 'package:qrail_fp/project/screens/widgets/schedule_card.dart';
import 'package:qrail_fp/project/screens/widgets/show_up_animation.dart';
import 'package:qrail_fp/project/screens/widgets/text.dart';

class FeaturedScreen extends StatefulWidget {
  const FeaturedScreen({super.key});

  @override
  State<FeaturedScreen> createState() => _FeaturedScreenState();
}

class _FeaturedScreenState extends State<FeaturedScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Container(
          child: Column(
            children: const [
              AppBar(),
              Expanded(
                child: HomeBody(),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      height: 100,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          gradient: LinearGradient(
            colors: [Colors.blueGrey, Color.fromARGB(255, 86, 117, 133)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello,',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          height: 60,
          alignment: Alignment.centerLeft,
          child: TextUtil(
            text: "My Bookings",
            color: Colors.blueGrey,
            weight: true,
            size: 28,
          ),
        ),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(30))),
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ListView.builder(
                itemCount: scheduleList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ShowUpAnimation(
                      delay: 150 * index,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                      data: scheduleList[index],
                                      index: index,
                                    )));
                          },
                          child: ScheduleCard(
                            data: scheduleList[index],
                            index: index,
                          )));
                }),
          ),
        ))
      ],

      //
    );
  }
}
