import 'package:antriksh/screens/Devices.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _VitalStepScreenState createState() => _VitalStepScreenState();
}

class _VitalStepScreenState extends State<HomePage> {
  int _currentIndex = 0;

  // Navigation function to go to the devices screen
  void _navigateToDevices() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Devices()), // Ensure the Devices screen is defined
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vital Step'),
        actions: [
          IconButton(
            icon: const Icon(Icons.devices, color: Colors.black), // Changed icon
            onPressed: _navigateToDevices, // Navigate on click
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hi, pragman!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/home1.PNG', // Adjusted path
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '88.62 %',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/home2.PNG', // Adjusted path
                      width: 80,
                      height: 80,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '100 %',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 16, thickness: 1), // Added space between divider and images
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Videos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Image.asset(
                'assets/images/home3.PNG', // Adjusted path
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
