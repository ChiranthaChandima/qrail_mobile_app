import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qrail_fp/data/fare_data.dart';
import 'package:qrail_fp/project/screens/train_schedule/ticket_summary.dart';


class TrainSchedule extends StatefulWidget {
  const TrainSchedule({super.key});

  @override
  State<TrainSchedule> createState() => _TrainScheduleState();
}

class _TrainScheduleState extends State<TrainSchedule> {

  final _formKey = GlobalKey<FormState>();

  String? _startStation;
  String? _endStation;
  DateTime? _selectedDate;
  int _passengerCount = 1;
  bool _payButtonEnabled = false;
  double _farePerPassenger = 0.0; // Initialize fare to 0

  List<String> stationList = [
    'Colombo', 'Kelaniya', 'Gampaha', 'Ragama', 'Kandy', 
    'Hunupitiya', 'Galle', 'Polgahawela', 'Weyangoda'
  ];

   void _updateFare() {
    setState(() {
      if (_startStation != null && _endStation != null && _startStation != _endStation) {

        _farePerPassenger = fareData[_startStation]![_endStation] ?? 0.0; // Fetch fare from data
      _payButtonEnabled = true;

      } else {

        _farePerPassenger = 0.0;
        _payButtonEnabled = false;

      }
    });
  }

  void _incrementPassenger() {
    setState(() {
      _passengerCount++;
      _updateFare();
    });
  }

   void _decrementPassenger() {
    if (_passengerCount > 1) {
      setState(() {
        _passengerCount--;
        _updateFare();
      });
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      appBar: AppBar(title: const Text('Buy Tickets'), centerTitle: true, backgroundColor: Colors.blueGrey),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>
            [
              _buildContainer(),
              const SizedBox(height: 20.0),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _buildContainer() {
    return Container(
      color: Colors.blueGrey.shade100,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Buy Tickets',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          _buildStationDropdown(
            label: 'From',
            value: _startStation,
            onChanged: (value) {
              setState(() {
                _startStation = value;
                _updateFare();
              });
            },
          ),
          const SizedBox(height: 10.0),
          _buildStationDropdown(
            label: 'To',
            value: _endStation,
            onChanged: (value) {
              setState(() {
                _endStation = value;
                _updateFare();
              });
            },
          ),
          const SizedBox(height: 10.0),
          _buildDatePicker(),
          const SizedBox(height: 20.0),
          _buildPassengerCounter(),
        ],
      ),
    );
  }

   Widget _buildStationDropdown({
    required String label,
    String? value,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: stationList.map((station) {
        return DropdownMenuItem<String>(
          value: station,
          child: Text(station),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: label,
        hintText: 'Select Station',
        border: const OutlineInputBorder(),
      ),
      onChanged: onChanged,
      validator: (value) =>
          value == null ? 'Please select a $label station' : null,
      isExpanded: true,
      icon: const Icon(Icons.train_outlined),
      iconEnabledColor: Colors.blueGrey,
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today, color: Colors.blueGrey),
                  const SizedBox(width: 10.0),
                  Text(
                    _selectedDate != null
                        ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                        : 'Select Travel Date',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

Widget _buildPassengerCounter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Passengers',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            IconButton(
              onPressed: _decrementPassenger,
              icon: const Icon(Icons.remove_circle_outline),
              color: Colors.blueGrey,
            ),
            Text(
              '$_passengerCount',
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: _incrementPassenger,
              icon: const Icon(Icons.add_circle_outline),
              color: Colors.blueGrey,
            ),
            const SizedBox(width: 10.0),
            const Icon(Icons.person, color: Colors.blueGrey),
            const SizedBox(width: 5.0),
            const Text('Passenger'),
          ],
        ),
      ],
    );
  }

  Widget _buildPayButton() {
    return Center(
      child: SizedBox(
        width: 300, // Set your desired fixed width here
        child: ElevatedButton(
          onPressed: _payButtonEnabled
              ? () {
                  double totalFare = _farePerPassenger * _passengerCount;
                // Navigate to the TicketSummaryPage with relevant details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TicketSummaryPage(
                      fromStation: _startStation ?? '', // Pass the selected start station
                      toStation: _endStation ?? '', // Pass the selected end station
                      travelDate: _selectedDate != null
                          ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                          : '', // Pass the selected travel date
                      passengerCount: _passengerCount, // Pass the number of passengers
                      totalCost: totalFare, // Pass the total fare
                    ),
                  ),
                );
              }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueGrey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15.0), // Height of the button
          ),
          child: Text(
            'Pay | Rs. ${_farePerPassenger * _passengerCount}',
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }


}
