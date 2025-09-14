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
      home: const CandlestickExamplePage(),
    );
  }
}

/// Example demonstrating both traditional data input and Plotly JSON support
class CandlestickExamplePage extends StatelessWidget {
  const CandlestickExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candlestick Chart Examples'),
        backgroundColor: Colors.blue[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Traditional data approach
            _buildSectionTitle('1. Traditional Data Approach'),
            _buildTraditionalExample(),

            const SizedBox(height: 32),

            // Example 2: Plotly JSON approach
            _buildSectionTitle('2. Plotly JSON Approach'),
            _buildPlotlyJsonExample(),

            const SizedBox(height: 32),

            // Example 3: Advanced Plotly JSON with styling
            _buildSectionTitle('3. Advanced Plotly JSON with Custom Styling'),
            _buildAdvancedPlotlyExample(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  /// Example using traditional CandlestickData list
  Widget _buildTraditionalExample() {
    final traditionalData = [
      CandlestickData(
        date: DateTime(2024, 1, 1),
        open: 100.0,
        high: 120.0,
        low: 95.0,
        close: 110.0,
        volume: 1000,
      ),
      CandlestickData(
        date: DateTime(2024, 1, 2),
        open: 110.0,
        high: 125.0,
        low: 105.0,
        close: 115.0,
        volume: 1200,
      ),
      CandlestickData(
        date: DateTime(2024, 1, 3),
        open: 115.0,
        high: 130.0,
        low: 110.0,
        close: 125.0,
        volume: 1500,
      ),
      CandlestickData(
        date: DateTime(2024, 1, 4),
        open: 125.0,
        high: 135.0,
        low: 115.0,
        close: 118.0,
        volume: 1300,
      ),
      CandlestickData(
        date: DateTime(2024, 1, 5),
        open: 118.0,
        high: 128.0,
        low: 112.0,
        close: 122.0,
        volume: 1100,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Using traditional CandlestickData objects:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: MaterialCandlestickChart(
            data: traditionalData,
            width: 400,
            height: 300,
            style: const CandlestickStyle(
              bullishColor: Colors.green,
              bearishColor: Colors.red,
              candleWidth: 8.0,
            ),
            showGrid: true,
          ),
        ),
      ],
    );
  }

  /// Example using Plotly JSON format (identical to Python Plotly)
  Widget _buildPlotlyJsonExample() {
    const plotlyJsonString = '''
    {
      "data": [
        {
          "type": "candlestick",
          "x": ["2024-01-01", "2024-01-02", "2024-01-03", "2024-01-04", "2024-01-05"],
          "open": [100, 110, 115, 125, 118],
          "high": [120, 125, 130, 135, 128],
          "low": [95, 105, 110, 115, 112],
          "close": [110, 115, 125, 118, 122],
          "volume": [1000, 1200, 1500, 1300, 1100],
          "increasing": {"line": {"color": "#00CC00"}},
          "decreasing": {"line": {"color": "#FF3333"}}
        }
      ],
      "layout": {
        "title": "Stock Price Movement",
        "xaxis": {"title": "Date"},
        "yaxis": {"title": "Price (\$)"}
      }
    }
    ''';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Using Plotly JSON (identical to Python Plotly format):',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        MaterialCandlestickChart.fromPlotlyJson(
          plotlyJsonString: plotlyJsonString,
          width: 400,
          height: 300,
          showGrid: true,
        ),
      ],
    );
  }

  /// Advanced example with more complex Plotly JSON
  Widget _buildAdvancedPlotlyExample() {
    const advancedPlotlyJson = '''
    {
      "data": [
        {
          "type": "candlestick",
          "x": ["2024-02-01", "2024-02-02", "2024-02-03", "2024-02-04", "2024-02-05", 
                "2024-02-06", "2024-02-07", "2024-02-08", "2024-02-09", "2024-02-10"],
          "open": [150, 155, 148, 152, 159, 162, 158, 165, 170, 168],
          "high": [165, 162, 158, 164, 168, 172, 169, 175, 178, 174],
          "low": [148, 150, 142, 149, 155, 159, 152, 160, 166, 163],
          "close": [155, 148, 152, 159, 162, 158, 165, 170, 168, 171],
          "name": "AAPL Stock",
          "increasing": {"line": {"color": "#26C281"}},
          "decreasing": {"line": {"color": "#ED5564"}}
        }
      ],
      "layout": {
        "title": "Apple Stock Price - Advanced Example",
        "xaxis": {
          "title": "Date",
          "type": "date"
        },
        "yaxis": {
          "title": "Price (USD)"
        }
      }
    }
    ''';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Advanced Plotly JSON with custom colors and metadata:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        MaterialCandlestickChart.fromPlotlyJson(
          plotlyJsonString: advancedPlotlyJson,
          width: 400,
          height: 300,
          showGrid: true,
          baseStyle: const CandlestickStyle(
            candleWidth: 10.0,
            spacing: 0.3,
            animationDuration: Duration(milliseconds: 2000),
          ),
        ),
      ],
    );
  }
}

/// Example of how to use the chart with dynamic data loading
class DynamicPlotlyExample extends StatefulWidget {
  const DynamicPlotlyExample({super.key});

  @override
  State<DynamicPlotlyExample> createState() => _DynamicPlotlyExampleState();
}

class _DynamicPlotlyExampleState extends State<DynamicPlotlyExample> {
  String? plotlyJson;
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Plotly JSON Loading'),
        actions: [
          IconButton(icon: const Icon(Icons.refresh), onPressed: _loadMockData),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: isLoading ? null : _loadMockData,
              child: Text(isLoading ? 'Loading...' : 'Load Chart Data'),
            ),
            const SizedBox(height: 16),
            if (errorMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  border: Border.all(color: Colors.red[200]!),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Error: $errorMessage',
                  style: TextStyle(color: Colors.red[700]),
                ),
              )
            else if (plotlyJson != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MaterialCandlestickChart.fromPlotlyJson(
                        plotlyJsonString: plotlyJson!,
                        width: 400,
                        height: 300,
                        showGrid: true,
                        onAnimationComplete: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Chart animation completed!'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Loaded from simulated API response',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: Text(
                  'Click "Load Chart Data" to see a dynamically loaded chart',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Simulates loading data from an API that returns Plotly JSON
  Future<void> _loadMockData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Simulate API response with Plotly JSON
      const mockApiResponse = '''
      {
        "data": [
          {
            "type": "candlestick",
            "x": ["2024-03-01", "2024-03-04", "2024-03-05", "2024-03-06", "2024-03-07", "2024-03-08"],
            "open": [180, 182, 178, 185, 188, 190],
            "high": [190, 188, 185, 195, 198, 200],
            "low": [175, 176, 170, 180, 183, 185],
            "close": [182, 178, 185, 188, 190, 195],
            "volume": [3000, 2800, 3200, 3500, 3100, 2900],
            "increasing": {"line": {"color": "#4CAF50"}},
            "decreasing": {"line": {"color": "#F44336"}}
          }
        ],
        "layout": {
          "title": "Dynamically Loaded Stock Data",
          "xaxis": {"title": "Trading Day"},
          "yaxis": {"title": "Stock Price"}
        }
      }
      ''';

      setState(() {
        plotlyJson = mockApiResponse;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }
}

/// Helper class for generating sample Plotly JSON data
class PlotlyDataGenerator {
  /// Generates random candlestick data in Plotly JSON format
  static String generateRandomCandlestickJson({
    int dataPoints = 10,
    double basePrice = 100.0,
    double volatility = 0.1,
  }) {
    final List<String> dates = [];
    final List<double> opens = [];
    final List<double> highs = [];
    final List<double> lows = [];
    final List<double> closes = [];
    final List<int> volumes = [];

    var currentPrice = basePrice;
    final startDate = DateTime.now().subtract(Duration(days: dataPoints));

    for (int i = 0; i < dataPoints; i++) {
      final date = startDate.add(Duration(days: i));
      dates.add(date.toIso8601String().split('T')[0]);

      final open = currentPrice;
      final change = (2 * (0.5 - (i % 10) / 10.0)) * volatility * currentPrice;
      final close = open + change;

      final high =
          [open, close].reduce((a, b) => a > b ? a : b) +
          (volatility * currentPrice * 0.5);
      final low =
          [open, close].reduce((a, b) => a < b ? a : b) -
          (volatility * currentPrice * 0.5);

      opens.add(double.parse(open.toStringAsFixed(2)));
      closes.add(double.parse(close.toStringAsFixed(2)));
      highs.add(double.parse(high.toStringAsFixed(2)));
      lows.add(double.parse(low.toStringAsFixed(2)));
      volumes.add((1000 + (i * 100) + (change.abs() * 50)).round());

      currentPrice = close;
    }

    return '''
    {
      "data": [
        {
          "type": "candlestick",
          "x": ${dates.map((d) => '"$d"').toList()},
          "open": $opens,
          "high": $highs,
          "low": $lows,
          "close": $closes,
          "volume": $volumes,
          "increasing": {"line": {"color": "#00AA00"}},
          "decreasing": {"line": {"color": "#AA0000"}}
        }
      ],
      "layout": {
        "title": "Generated Random Stock Data",
        "xaxis": {"title": "Date"},
        "yaxis": {"title": "Price"}
      }
    }
    ''';
  }
}
