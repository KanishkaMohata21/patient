import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
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