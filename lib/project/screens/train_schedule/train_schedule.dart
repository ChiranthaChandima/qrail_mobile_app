import 'package:flutter/material.dart';
import 'package:qrail_fp/models/station.dart';
import 'package:qrail_fp/project/screens/train_schedule/train_detail.dart';
import 'package:qrail_fp/services/station_service.dart';

class TrainSchedule extends StatefulWidget {
  const TrainSchedule({super.key});

  @override
  State<TrainSchedule> createState() => _TrainScheduleState();
}

class _TrainScheduleState extends State<TrainSchedule> {
  final _formKey = GlobalKey<FormState>();
  String? _startStation;
  String? _endStation;
  String? _startStationName;
  String? _endStationName;
  List<StationRequest> stationList = [];

  @override
  void initState() {
    super.initState();
    _fetchStations();
  }

  Future<void> _fetchStations() async {
    try {
      List<StationRequest> stations = await StationService().fetchStations();
      setState(() {
        stationList = stations;
      });
    } catch (e) {
      print("Failed to fetch stations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Train Schedule'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[_inputField(context)],
          ),
        ),
      ),
    ));
  }

  Widget _inputField(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _startStation,
            items: stationList.map((station) {
              return DropdownMenuItem<String>(
                value: station.id,
                child: Text(station.stationName),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: "From",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.alphaBlend(Colors.black, Colors.white),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _startStation = value;
                _startStationName = stationList
                    .firstWhere((station) => station.id == value)
                    .stationName;
              });
            },
            validator: (value) =>
                value == null ? 'Please select a start station' : null,
            isExpanded: true,
            icon: const Icon(Icons.train_outlined),
            iconEnabledColor: Colors.blueGrey,
          ),
          const SizedBox(
            height: 10.0,
          ),
          DropdownButtonFormField<String>(
            value: _endStation,
            items: stationList.map((station) {
              return DropdownMenuItem<String>(
                value: station.id,
                child: Text(station.stationName),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: "To",
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Color.alphaBlend(Colors.black, Colors.white),
                ),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _endStation = value;
                _endStationName = stationList
                    .firstWhere((station) => station.id == value)
                    .stationName;
              });
            },
            validator: (value) =>
                value == null ? 'Please select an end station' : null,
            isExpanded: true,
            icon: const Icon(Icons.train_outlined),
            iconEnabledColor: Colors.blueGrey,
          ),
          const SizedBox(
            height: 10.0,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrainDetailsScreen(
                      startStation: _startStation,
                      endStation: _endStation,
                      //startStationName: _startStationName,
                      //endStationName: _endStationName,
                    ),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.0)),
              padding: const EdgeInsets.all(10.0),
            ),
            child: const Text('Search Train',
                style: TextStyle(fontSize: 17, color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
