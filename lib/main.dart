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
      title: 'Material Charts Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const LineChartDemo(),
    );
  }
}

/// Simple line chart demo
class LineChartDemo extends StatefulWidget {
  const LineChartDemo({super.key});

  @override
  State<LineChartDemo> createState() => _LineChartDemoState();
}

class _LineChartDemoState extends State<LineChartDemo> {
  int _currentIndex = 0;
  
  // Sample data for the line chart
  final List<ChartData> _chartData = [
    const ChartData(value: 20, label: 'Jan'),
    const ChartData(value: 35, label: 'Feb'),
    const ChartData(value: 28, label: 'Mar'),
    const ChartData(value: 45, label: 'Apr'),
    const ChartData(value: 52, label: 'May'),
    const ChartData(value: 38, label: 'Jun'),
    const ChartData(value: 65, label: 'Jul'),
    const ChartData(value: 72, label: 'Aug'),
    const ChartData(value: 58, label: 'Sep'),
    const ChartData(value: 48, label: 'Oct'),
    const ChartData(value: 55, label: 'Nov'),
    const ChartData(value: 68, label: 'Dec'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Line Chart Demo'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E),
              Color(0xFF0F3460),
            ],
          ),
        ),
        child: Column(
          children: [
            // Tab buttons
            Container(
              margin: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: const Color(0xFF2C3E50), width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTabButton(0, 'Basic Line Chart'),
                  const SizedBox(width: 12),
                  _buildTabButton(1, 'Curved Line Chart'),
                ],
              ),
            ),
            
            // Chart content
            Expanded(
              child: Center(
                child: _buildCurrentChart(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(int index, String label) {
    final isSelected = _currentIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF7B9E87)
            : Colors.transparent,
        foregroundColor: isSelected
            ? const Color(0xFF1A1A2E)
            : const Color(0xFFE8F4F8),
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: isSelected
            ? null
            : BorderSide(color: const Color(0xFF2C3E50), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }

  Widget _buildCurrentChart() {
    switch (_currentIndex) {
      case 0:
        return _buildBasicLineChart();
      case 1:
        return _buildCurvedLineChart();
      default:
        return _buildBasicLineChart();
    }
  }

  /// Basic line chart with simple styling
  Widget _buildBasicLineChart() {
    return Container(
      width: 800,
      height: 400,
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
      child: MaterialChartLine(
        data: _chartData,
        width: 750,
        height: 350,
        style: const LineChartStyle(
          lineColor: Color(0xFF4CAF50),
          pointColor: Color(0xFF4CAF50),
          backgroundColor: Color(0xFF16213E),
          gridColor: Color(0xFF34495E),
          strokeWidth: 3.0,
          pointRadius: 5.0,
          animationDuration: Duration(milliseconds: 2000),
          animationCurve: Curves.easeInOut,
        ),
        showPoints: true,
        showGrid: true,
        showTooltips: true,
        padding: const EdgeInsets.all(32),
        horizontalGridLines: 6,
        onAnimationComplete: () {
          print('Basic line chart animation completed!');
        },
      ),
    );
  }

  /// Curved line chart with smooth curves
  Widget _buildCurvedLineChart() {
    return Container(
      width: 800,
      height: 400,
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
      child: MaterialChartLine(
        data: _chartData,
        width: 750,
        height: 350,
        style: const LineChartStyle(
          lineColor: Color(0xFF2196F3),
          pointColor: Color(0xFF2196F3),
          backgroundColor: Color(0xFF16213E),
          gridColor: Color(0xFF34495E),
          strokeWidth: 3.0,
          pointRadius: 5.0,
          useCurvedLines: true,
          curveIntensity: 0.5,
          animationDuration: Duration(milliseconds: 2500),
          animationCurve: Curves.easeInOut,
        ),
        showPoints: true,
        showGrid: true,
        showTooltips: true,
        padding: const EdgeInsets.all(32),
        horizontalGridLines: 6,
        onAnimationComplete: () {
          print('Curved line chart animation completed!');
        },
      ),
    );
  }
}