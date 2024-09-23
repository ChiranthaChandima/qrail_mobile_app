import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[_profileState(context)],
          ),
        ),
      ),
    );
  }

  _profileState(context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo1.jpg'),
            radius: 40.0,
          ),
        ),
        Divider(
          height: 60.0,
        ),
        Text(
          "Name",
          style: TextStyle(letterSpacing: 2.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          'Yudeesha',
          style: TextStyle(
              fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10.0,
        ),
        Text(
          "Phone",
          style: TextStyle(letterSpacing: 2.0),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '0777940210',
          style: TextStyle(
              fontSize: 20.0, color: Colors.blue, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
