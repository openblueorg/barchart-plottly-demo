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
      title: 'Material Area Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const AreaChartDemo(),
    );
  }
}

/// Simple Area Chart Demo
class AreaChartDemo extends StatefulWidget {
  const AreaChartDemo({super.key});

  @override
  State<AreaChartDemo> createState() => _AreaChartDemoState();
}

class _AreaChartDemoState extends State<AreaChartDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Area Chart Demo'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF0F3460)],
          ),
        ),
        child: Center(child: _buildAreaChart()),
      ),
    );
  }

  Widget _buildAreaChart() {
    // Sample data for the area chart
    final series = [
      AreaChartSeries(
        name: 'Sales',
        dataPoints: [
          const AreaChartData(value: 10, label: 'Jan'),
          const AreaChartData(value: 25, label: 'Feb'),
          const AreaChartData(value: 35, label: 'Mar'),
          const AreaChartData(value: 20, label: 'Apr'),
          const AreaChartData(value: 45, label: 'May'),
          const AreaChartData(value: 55, label: 'Jun'),
          const AreaChartData(value: 40, label: 'Jul'),
          const AreaChartData(value: 60, label: 'Aug'),
          const AreaChartData(value: 50, label: 'Sep'),
          const AreaChartData(value: 70, label: 'Oct'),
          const AreaChartData(value: 65, label: 'Nov'),
          const AreaChartData(value: 80, label: 'Dec'),
        ],
        color: const Color(0xFF4CAF50),
        gradientColor: const Color(0xFF81C784),
        lineWidth: 3.0,
        showPoints: true,
        pointSize: 6.0,
      ),
    ];

    // Chart style configuration
    final style = const AreaChartStyle(
      colors: [Color(0xFF4CAF50)],
      gridColor: Color(0xFF2C3E50),
      backgroundColor: Color(0xFF16213E),
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      defaultLineWidth: 3.0,
      defaultPointSize: 6.0,
      showPoints: true,
      showGrid: true,
      animationDuration: Duration(milliseconds: 2000),
      animationCurve: Curves.easeInOut,
      padding: EdgeInsets.all(32),
      horizontalGridLines: 6,
      forceYAxisFromZero: true,
    );

    return Container(
      width: 800,
      height: 500,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: const Color(0xFF2C3E50), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Chart title
          const Text(
            'Monthly Sales Data',
            style: TextStyle(
              color: Color(0xFFE8F4F8),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Simple area chart showing sales progression throughout the year',
            style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 14),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          // Area chart
          Expanded(
            child: MaterialAreaChart(
              series: series,
              width: 700,
              height: 350,
              style: style,
              interactive: true,
              onAnimationComplete: () {
                print('Area chart animation completed!');
              },
            ),
          ),
        ],
      ),
    );
  }
}
