import 'package:flutter/material.dart';
import 'material_charts/material_charts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gantt Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SimpleChartHome(),
    );
  }
}

class SimpleChartApp extends StatelessWidget {
  const SimpleChartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SimpleChartHome(),
    );
  }
}

class SimpleChartHome extends StatelessWidget {
  const SimpleChartHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Chart Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Progress Charts',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),

            // Basic chart
            MaterialChartHollowSemiCircle(percentage: 75, size: 200),

            SizedBox(height: 40),

            // Custom styled chart
            MaterialChartHollowSemiCircle(
              percentage: 60,
              size: 150,
              hollowRadius: 0.5,
              style: ChartStyle(
                activeColor: Colors.green,
                inactiveColor: Colors.grey,
                showPercentageText: true,
                showLegend: true,
                animationDuration: Duration(seconds: 2),
                animationCurve: Curves.easeInOut,
              ),
            ),

            SizedBox(height: 40),

            // Multiple charts in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialChartHollowSemiCircle(
                  percentage: 25,
                  size: 120,
                  style: ChartStyle(activeColor: Colors.red, showLegend: false),
                ),
                MaterialChartHollowSemiCircle(
                  percentage: 50,
                  size: 120,
                  style: ChartStyle(
                    activeColor: Colors.orange,
                    showLegend: false,
                  ),
                ),
                MaterialChartHollowSemiCircle(
                  percentage: 90,
                  size: 120,
                  style: ChartStyle(
                    activeColor: Colors.purple,
                    showLegend: false,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
