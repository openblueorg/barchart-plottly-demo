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
      title: 'Candlestick Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ChartTestScreen(),
    );
  }
}

class ChartTestScreen extends StatefulWidget {
  const ChartTestScreen({super.key});

  @override
  State<ChartTestScreen> createState() => _ChartTestScreenState();
}

class _ChartTestScreenState extends State<ChartTestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Candlestick Chart Demo'), elevation: 2),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: _buildCandlestickExamples(),
      ),
    );
  }

  Widget _buildCandlestickExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Candlestick Chart Examples',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        _buildCard(
          title: 'Simple Stock Price Chart',
          description: 'Basic candlestick chart showing daily stock prices',
          child: MaterialCandlestickChart(
            data: _getSampleStockData(),
            width: 400,
            height: 300,
            backgroundColor: Colors.white,
            style: const CandlestickStyle(
              bullishColor: Colors.green,
              bearishColor: Colors.red,
              candleWidth: 8.0,
              wickWidth: 1.5,
              spacing: 0.3,
              animationDuration: Duration(milliseconds: 2000),
            ),
            axisConfig: const ChartAxisConfig(
              priceDivisions: 6,
              dateDivisions: 5,
              yAxisWidth: 80.0,
              xAxisHeight: 40.0,
            ),
            showGrid: true,
          ),
        ),

        _buildCard(
          title: 'Custom Styled Chart',
          description: 'Candlestick chart with custom colors and styling',
          child: MaterialCandlestickChart(
            data: _getSampleStockData(),
            width: 400,
            height: 300,
            backgroundColor: const Color(0xFFF8F9FA),
            style: const CandlestickStyle(
              bullishColor: Color(0xFF2E7D32),
              bearishColor: Color(0xFFD32F2F),
              candleWidth: 10.0,
              wickWidth: 2.0,
              spacing: 0.4,
              animationDuration: Duration(milliseconds: 1500),
              animationCurve: Curves.easeOut,
            ),
            axisConfig: const ChartAxisConfig(
              priceDivisions: 8,
              dateDivisions: 6,
              yAxisWidth: 70.0,
              xAxisHeight: 35.0,
            ),
            showGrid: true,
          ),
        ),

        _buildCard(
          title: 'Compact Chart',
          description:
              'Smaller candlesticks with tight spacing for more data points',
          child: MaterialCandlestickChart(
            data: _getExtendedStockData(),
            width: 400,
            height: 250,
            backgroundColor: Colors.white,
            style: const CandlestickStyle(
              bullishColor: Colors.green,
              bearishColor: Colors.red,
              candleWidth: 4.0,
              wickWidth: 1.0,
              spacing: 0.1,
              animationDuration: Duration(milliseconds: 3000),
            ),
            axisConfig: const ChartAxisConfig(
              priceDivisions: 5,
              dateDivisions: 4,
              yAxisWidth: 60.0,
              xAxisHeight: 30.0,
            ),
            showGrid: true,
          ),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required Widget child,
    String? description,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 24),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(description, style: TextStyle(color: Colors.grey[600])),
            ],
            const SizedBox(height: 16),
            Center(child: child),
          ],
        ),
      ),
    );
  }

  List<CandlestickData> _getSampleStockData() {
    final now = DateTime.now();
    return [
      CandlestickData(
        date: now.subtract(const Duration(days: 10)),
        open: 100.0,
        high: 105.0,
        low: 98.0,
        close: 103.0,
        volume: 1000000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 9)),
        open: 103.0,
        high: 108.0,
        low: 101.0,
        close: 106.0,
        volume: 1200000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 8)),
        open: 106.0,
        high: 107.0,
        low: 102.0,
        close: 104.0,
        volume: 900000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 7)),
        open: 104.0,
        high: 110.0,
        low: 103.0,
        close: 108.0,
        volume: 1500000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 6)),
        open: 108.0,
        high: 112.0,
        low: 106.0,
        close: 109.0,
        volume: 1100000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 5)),
        open: 109.0,
        high: 111.0,
        low: 105.0,
        close: 107.0,
        volume: 800000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 4)),
        open: 107.0,
        high: 109.0,
        low: 103.0,
        close: 105.0,
        volume: 950000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 3)),
        open: 105.0,
        high: 108.0,
        low: 102.0,
        close: 106.0,
        volume: 1300000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 2)),
        open: 106.0,
        high: 110.0,
        low: 104.0,
        close: 108.0,
        volume: 1400000,
      ),
      CandlestickData(
        date: now.subtract(const Duration(days: 1)),
        open: 108.0,
        high: 115.0,
        low: 107.0,
        close: 112.0,
        volume: 1600000,
      ),
    ];
  }

  List<CandlestickData> _getExtendedStockData() {
    final now = DateTime.now();
    final data = <CandlestickData>[];

    // Generate 20 days of sample data
    for (int i = 20; i >= 0; i--) {
      final basePrice = 100.0 + (20 - i) * 0.5;
      final random = (i * 7) % 10; // Simple pseudo-random based on day

      final open = basePrice + (random - 5) * 0.5;
      final close = open + (random % 3 - 1) * 1.5;
      final high =
          [open, close].reduce((a, b) => a > b ? a : b) + (random % 2) * 1.0;
      final low =
          [open, close].reduce((a, b) => a < b ? a : b) - (random % 2) * 1.0;

      data.add(
        CandlestickData(
          date: now.subtract(Duration(days: i)),
          open: open,
          high: high,
          low: low,
          close: close,
          volume: 800000 + (random * 100000),
        ),
      );
    }

    return data;
  }
}
