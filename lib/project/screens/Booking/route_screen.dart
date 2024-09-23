import 'package:flutter/material.dart';
import 'package:qrail_fp/models/station.dart';
import 'package:qrail_fp/services/station_service.dart';
import 'package:intl/intl.dart';
import 'package:qrail_fp/project/screens/widgets/field.dart';

class RouteScreen extends StatefulWidget {
  final Function onNavigateToTrain;

  const RouteScreen({Key? key, required this.onNavigateToTrain})
      : super(key: key);

  @override
  State<RouteScreen> createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  String? _fromStation;
  String? _toStation;
  String? _class;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _travelerController = TextEditingController();
  List<StationRequest> _stationList = [];

  // Track if the form is fully filled
  bool _isFormFilled = false;

  @override
  void initState() {
    super.initState();
    // Fetch stations from the API
    _fetchStations();
    // Add listeners to track changes
    _addListeners();
  }

  Future<void> _fetchStations() async {
    try {
      List<StationRequest> stations = await StationService().fetchStations();
      setState(() {
        _stationList = stations;
      });
    } catch (e) {
      print("Failed to fetch stations: $e");
    }
  }

  void _addListeners() {
    List<void Function()> listeners = [
      () {
        setState(() {
          _isFormFilled = _fromStation != null &&
              _toStation != null &&
              _class != null &&
              _dateController.text.isNotEmpty &&
              _travelerController.text.isNotEmpty;
        });
      },
    ];

    _dateController.addListener(listeners[0]);
    _travelerController.addListener(listeners[0]);
  }

  // Method to show date picker
  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Initial date set to today
      firstDate: DateTime(2021), // Earliest selectable date
      lastDate: DateTime(2027), // Latest selectable date
    );
    setState(() {
      // Format the selected date and update the controller
      _dateController.text = DateFormat('yyyy-MM-dd').format(picked!);
    });
    }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _travelerController.dispose();
  }

  InputDecoration _buildInputDecoration(BuildContext context, String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(
        color: Theme.of(context).canvasColor,
        fontWeight: FontWeight.bold,
        fontSize: 15,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).canvasColor,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).canvasColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).canvasColor,
        ),
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Container(
          height: 20,
          width: 30,
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Theme.of(context).canvasColor,
                width: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField<String>(
              value: _fromStation,
              hint: Text("FROM", style: TextStyle(color: Theme.of(context).canvasColor)),
              icon: Icon(Icons.train, color: Theme.of(context).indicatorColor),
              onChanged: (String? newValue) {
                setState(() {
                  _fromStation = newValue;
                });
                _addListeners();
              },
              items: _stationList.map((station) {
                return DropdownMenuItem<String>(
                  value: station.id,
                  child: Text(station.stationName, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              decoration: _buildInputDecoration(context, "From"),
              isExpanded: true,
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              value: _toStation,
              hint: Text("TO", style: TextStyle(color: Theme.of(context).canvasColor)),
              icon: Icon(Icons.train, color: Theme.of(context).indicatorColor),
              onChanged: (String? newValue) {
                setState(() {
                  _toStation = newValue;
                });
                _addListeners();
              },
              items: _stationList.map((station) {
                return DropdownMenuItem<String>(
                  value: station.id,
                  child: Text(station.stationName, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              decoration: _buildInputDecoration(context, "To"),
              isExpanded: true,
            ),
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () => _selectDate(context), // Open date picker on tap
              child: IgnorePointer(
                // Prevents field from gaining focus
                child: Field(
                  controller: _dateController,
                  hinttext: "DATE",
                  icon: Icons.calendar_month,
                  readOnly: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Field(
              controller: _travelerController,
              hinttext: "TRAVELERS",
              icon: Icons.group,
              readOnly: false,
            ),
            const SizedBox(
              height: 30,
            ),
            DropdownButtonFormField<String>(
              value: _class,
              hint: Text("CLASS", style: TextStyle(color: Theme.of(context).canvasColor)),
              icon: Icon(Icons.airline_seat_recline_extra, color: Theme.of(context).indicatorColor),
              onChanged: (String? newValue) {
                setState(() {
                  _class = newValue;
                });
                _addListeners();
              },
              items: <String>['First', 'Second', 'Third']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(color: Colors.black)),
                );
              }).toList(),
              decoration: _buildInputDecoration(context, "Class"),
              isExpanded: true,
            ),
            const SizedBox(
              height: 30,
            ),
            Positioned(
              right: 30,
              bottom: 30,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_right, size: 30),
                  color: _isFormFilled ? Colors.blue : Colors.grey,
                  onPressed: _isFormFilled
                      ? () {
                          // Navigate to the next screen
                          widget.onNavigateToTrain();
                        }
                      : null, // Disabled if form is not filled
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
