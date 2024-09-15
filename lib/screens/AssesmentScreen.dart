import 'package:flutter/material.dart';
import 'package:antriksh/screens/TestPage.dart';
import 'package:antriksh/screens/Devices.dart'; // Import other required screens
import 'package:antriksh/screens/AssesmentDetailsScreen.dart'; // Import other required screens
import 'package:antriksh/widgets/bottomNavigationBar.dart';

import 'package:flutter/material.dart';
import 'package:antriksh/screens/TestPage.dart';
import 'package:antriksh/screens/Devices.dart'; // Import other required screens
import 'package:antriksh/screens/AssesmentDetailsScreen.dart'; // Import other required screens
import 'package:antriksh/widgets/bottomNavigationBar.dart';

class AssessmentPage extends StatefulWidget {
  @override
  _AssessmentPageState createState() => _AssessmentPageState();
}

class _AssessmentPageState extends State<AssessmentPage> {
  int _selectedIndex = 0; // Default index for the navigation bar

  // Handle navigation bar tap
  void _handleNavigation(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background of the whole page
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 254, 247, 255), // AppBar background
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 4), // Add padding here
          child: Text(
            'Assessment',
            style: TextStyle(color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.devices, color: Colors.black), // Use devices icon for computer/mobile
            onPressed: () {
              // Navigate to DeviceScreen on icon click
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Devices(),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 248, 247, 252), // Background of content area
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: assessments.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to AssessmentDetailsPage on tap
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AssessmentDetailPage(),
                  ),
                );
              },
              child: AssessmentTile(
                number: index + 1,
                title: assessments[index]['title']!,
                details: assessments[index]['details']!,
              ),
            );
          },
        ),
      ),
    );
  }

  final List<Map<String, String>> assessments = [
    {"title": "Weekly", "details": "sitting | 12 | Active"},
    {"title": "Monthly", "details": "sitting | 12 | Active"},
    {"title": "Daily", "details": "sitting | 12 | Active"},
  ];
}

class AssessmentTile extends StatefulWidget {
  final int number;
  final String title;
  final String details;

  AssessmentTile({
    required this.number,
    required this.title,
    required this.details,
  });

  @override
  _AssessmentTileState createState() => _AssessmentTileState();
}

class _AssessmentTileState extends State<AssessmentTile> {
  bool _isRightHandSelected = false;
  bool _isLeftHandSelected = false;
  String? _selectedDevice;

  void _startTest() {
    if ((_isRightHandSelected || _isLeftHandSelected) && _selectedDevice != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => TestPage(), // Navigate to TestPage
        ),
      );
    } else {
      // Show error if validation fails
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Validation Error"),
            content: Text("Please select at least one hand and a device."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Text(
          '${widget.number}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.details),
        trailing: SizedBox(
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                    return AlertDialog(
                      title: Text(
                        "Create Test",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                      content: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Select hand",
                              style: TextStyle(fontSize: 18),
                            ),
                            CheckboxListTile(
                              title: Text("Right"),
                              value: _isRightHandSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isRightHandSelected = value ?? false;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("Left"),
                              value: _isLeftHandSelected,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isLeftHandSelected = value ?? false;
                                });
                              },
                            ),
                            SizedBox(height: 8),
                            DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Select the device',
                                border: UnderlineInputBorder(),
                              ),
                              value: _selectedDevice,
                              items: <String>['Device 1', 'Device 2', 'Device 3'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedDevice = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _startTest,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                              minimumSize: Size(double.infinity, 50),
                            ),
                            child: Text(
                              "Start Test",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  });
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 46, 39, 179),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: Text(
              'Take Test',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}