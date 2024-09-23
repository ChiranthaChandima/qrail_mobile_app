// ignore_for_file: prefer_const_constructors

import 'package:qrail_fp/project/screens/widgets/text.dart';

import 'package:flutter/material.dart';

import '../../../data/schedule_data.dart';

class ScheduleCard extends StatelessWidget {
  ScheduleItem data;
  int index;

  ScheduleCard({super.key, required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Theme.of(context).canvasColor))),
      child: Column(
        children: [
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtil(
                    text: data.trainName,
                    color: Theme.of(context).indicatorColor,
                    size: 28,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil(
                    text: data.sourceName,
                    color: Colors.white,
                    size: 12,
                    weight: true,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextUtil(
                    text: data.destination,
                    color: Theme.of(context).indicatorColor,
                    size: 28,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil(
                    text: data.destinationName,
                    color: Colors.white,
                    size: 12,
                    weight: true,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextUtil(
                    text: "DATE",
                    color: Theme.of(context).canvasColor,
                    size: 12,
                    weight: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil(
                    text: "${data.date} ${data.startTime}",
                    color: Colors.white,
                    size: 13,
                    weight: true,
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextUtil(
                    text: "Train Name",
                    color: Theme.of(context).canvasColor,
                    size: 12,
                    weight: true,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextUtil(
                    text: data.trainName,
                    color: Colors.white,
                    size: 13,
                    weight: true,
                  )
                ],
              )
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
