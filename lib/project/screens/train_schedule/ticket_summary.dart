import 'package:flutter/material.dart';

class TicketSummaryPage extends StatelessWidget {
  final String fromStation;
  final String toStation;
  final String travelDate;
  final int passengerCount;
  final double totalCost;

  const TicketSummaryPage({super.key, 
    required this.fromStation,
    required this.toStation,
    required this.travelDate,
    required this.passengerCount,
    required this.totalCost,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

      appBar: AppBar(title: const Text('Ticket Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStationRow(),
            const SizedBox(height: 16),
            _buildTicketDetails(),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            const Spacer(),
            _buildConfirmButton(context),
          ],
        ),
      ),
      )
    );
  }

  Widget _buildStationRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(fromStation, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Icon(Icons.arrow_forward),
        Text(toStation, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTicketDetails() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Travel Dates', travelDate),
          _buildDetailRowPassenger('Passenger', passengerCount),
          const SizedBox(height: 8),
          _buildDetailRow('Total Cost', 'Rs. ${totalCost.toStringAsFixed(2)}', isBold: true),
        ],
      ),
    );
  }

   Widget _buildDetailRow(String label, String value, {bool isBold = false}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      );
  }

  Widget _buildDetailRowPassenger(String label, int value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16)),
        Text(value.toString(), style: TextStyle(fontSize: 16, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }


  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle confirm and payment logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Confirm & Pay', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Text('Rs. ${totalCost.toStringAsFixed(2)}', style: const TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}