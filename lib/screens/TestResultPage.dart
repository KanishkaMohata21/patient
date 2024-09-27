import 'package:flutter/material.dart';

class TestResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 247, 255, 1), // rgba(254,247,255,255)
      appBar: AppBar(
        title: Text('Test Results'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Add refresh logic here
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // text and icon color
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(  // Allows scrolling if content overflows
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,  // Aligns content to the start (left)
            children: [
              Table(
                border: TableBorder.all(), // Optional: Adds border to the table
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  _buildTableRow('Test Date', '24/9/2024'),
                  _buildTableRow('Test Time', '9:1'),
                  _buildTableRow('Posture', 'sitting'),
                  _buildTableRow('Hand', 'Left'),
                  _buildTableRow('Trial 1', '14.2 Kg'),
                  _buildTableRow('Trial 2', '12.5 Kg'),
                  _buildTableRow('Trial 3', '17.5 Kg'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow _buildTableRow(String key, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            key,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
