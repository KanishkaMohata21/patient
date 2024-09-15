import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AssessmentDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(254, 247, 255, 1), // rgba(254,247,255,255)
      appBar: AppBar(
        title: Text('Assessment Detail'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous page
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black, // for text and icon color
        titleSpacing: 0, // Remove space between the back arrow and title
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the entire page
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // BMI Section
            RichText(
              text: TextSpan(
                text: 'BMI - ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '24.97',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Pressure Reading Section
            Text(
              'Pressure Reading',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Start Date: No assessments found',
              style: TextStyle(
                fontSize: 18, // Increased font size
              ),
            ),
            Text(
              'End Date: No assessments found',
              style: TextStyle(
                fontSize: 18, // Increased font size
              ),
            ),
            SizedBox(height: 30),

            // Option Links Section
            GestureDetector(
              onTap: () {
                // Navigate to AssessmentHistoryPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssessmentHistoryPage()),
                );
              },
              child: Text(
                'See Assessment History',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20), // Added space between options
            GestureDetector(
              onTap: () {
                _showReminderDialog(context);
              },
              child: Text(
                'Set Daily Reminder',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20), // Added space between options
            GestureDetector(
              onTap: () {
                // Handle 'Share the PDF with doctor' action
              },
              child: Text(
                'Share the PDF with doctor',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Set Reminder",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          content: StatefulBuilder(
            builder: (context, setState) {
              DateTime? selectedDateTime;

              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
             
                        'No date selected',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity, // Take full width
                    child: ElevatedButton(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );

                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (pickedTime != null) {
                            selectedDateTime = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                              pickedTime.hour,
                              pickedTime.minute,
                            );
                            setState(() {}); // Update the selected date and time
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                        minimumSize: Size(double.infinity, 50), // Full width and increased height
                        textStyle: TextStyle(
                          fontSize: 18, // Increased font size
                          color: Colors.white, // Text color
                        ),
                      ),
                      child: Center(
                        child: Text('Select Date and Time', style: TextStyle(color: Colors.white, fontSize: 18)), 
                        
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission here
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.white, fontSize: 18), // Increased font size
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class AssessmentHistoryPage extends StatefulWidget {
  @override
  _AssessmentHistoryPageState createState() => _AssessmentHistoryPageState();
}

class _AssessmentHistoryPageState extends State<AssessmentHistoryPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assessment History"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: "Table"),
            Tab(text: "Graph"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Table View
          tableView(),
          // Graph View
          graphView(),
        ],
      ),
    );
  }

  Widget tableView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Right Hand Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Trial 1 (Kg)")),
              DataColumn(label: Text("Trial 2 (Kg)")),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text("58")),
                DataCell(Text("1.497")),
                DataCell(Text("5.401")),
              ]),
            ],
          ),
          SizedBox(height: 20),
          Text("Left Hand Table", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Trial 1 (Kg)")),
              DataColumn(label: Text("Trial 2 (Kg)")),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text("60")),
                DataCell(Text("3.230")),
                DataCell(Text("2.337")),
              ]),
              DataRow(cells: [
                DataCell(Text("56")),
                DataCell(Text("1.670")),
                DataCell(Text("1.646")),
              ]),
            ],
          ),
          SizedBox(height: 20),
          Text("Latest Test", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DataTable(
            columns: [
              DataColumn(label: Text("RH")),
              DataColumn(label: Text("LH")),
              DataColumn(label: Text("Difference")),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text("3.93")),
                DataCell(Text("2.38")),
                DataCell(Text("-1.55")),
              ]),
            ],
          ),
        ],
      ),
    );
  }

  Widget graphView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Right Hand Graph", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 200,
            child: LineChart(LineChartData(
              gridData: FlGridData(show: true),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  color: Colors.red,
                  spots: [
                    FlSpot(1, 3.0),
                    FlSpot(2, 3.5),
                    FlSpot(3, 3.9),
                  ],
                  dotData: FlDotData(show: true),
                )
              ],
            )),
          ),
          SizedBox(height: 20),
          Text("Latest Test Graph", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 200,
            child: BarChart(BarChartData(
              barGroups: [
                BarChartGroupData(x: 1, barRods: [
                  BarChartRodData(toY: 5, color: Colors.green),
                ]),
                BarChartGroupData(x: 2, barRods: [
                  BarChartRodData(toY: 5, color: Colors.red),
                ]),
              ],
            )),
          ),
        ],
      ),
    );
  }
}