import 'package:flutter/material.dart';

import 'material_charts/material_charts.dart';
// Import your chart files
// import 'lib/src/hollow_semicircle_chart/widgets.dart';
// import 'lib/src/hollow_semicircle_chart/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hollow Semicircle Chart JSON Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const ChartDemoScreen(),
    );
  }
}

class ChartDemoScreen extends StatelessWidget {
  const ChartDemoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hollow Semicircle Chart JSON Demo'),
        backgroundColor: Colors.blue[100],
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Simple JSON Format Examples
            Text(
              'Simple JSON Format Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 20),

            SimpleJsonExamples(),

            SizedBox(height: 40),
            Divider(thickness: 2),
            SizedBox(height: 20),

            // Plotly JSON Format Examples
            Text(
              'Plotly-Compatible JSON Format Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 20),

            PlotlyJsonExamples(),

            SizedBox(height: 40),
            Divider(thickness: 2),
            SizedBox(height: 20),

            // JSON String Examples
            Text(
              'JSON String Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 20),

            JsonStringExamples(),
          ],
        ),
      ),
    );
  }
}

class SimpleJsonExamples extends StatelessWidget {
  const SimpleJsonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    // Simple JSON configurations
    final basicConfig = {
      "percentage": 75.0,
      "size": 200.0,
      "hollowRadius": 0.6,
      "style": {
        "activeColor": "#4CAF50",
        "inactiveColor": "#E0E0E0",
        "showPercentageText": true,
        "showLegend": false,
      },
    };

    final customizedConfig = {
      "percentage": 85.0,
      "size": 250.0,
      "hollowRadius": 0.5,
      "style": {
        "activeColor": "#FF5722",
        "inactiveColor": "#FFCCBC",
        "textColor": "#D84315",
        "showPercentageText": true,
        "showLegend": true,
        "animationDuration": 2500,
        "animationCurve": "bounceOut",
      },
    };

    final namedColorsConfig = {
      "percentage": 60.0,
      "size": 180.0,
      "hollowRadius": 0.7,
      "style": {
        "activeColor": "blue",
        "inactiveColor": "gray",
        "textColor": "black",
        "showPercentageText": true,
        "showLegend": true,
      },
    };

    return Column(
      children: [
        // Basic Configuration
        _ChartExample(
          title: '1. Basic Configuration (75%)',
          description: 'Simple green chart with no legend',
          jsonCode: _formatJson(basicConfig),
          child: MaterialChartHollowSemiCircle.fromJson(basicConfig),
        ),

        const SizedBox(height: 30),

        // Customized Configuration
        _ChartExample(
          title: '2. Customized Configuration (85%)',
          description: 'Orange theme with bounce animation and legend',
          jsonCode: _formatJson(customizedConfig),
          child: MaterialChartHollowSemiCircle.fromJson(customizedConfig),
        ),

        const SizedBox(height: 30),

        // Named Colors Configuration
        _ChartExample(
          title: '3. Named Colors Configuration (60%)',
          description: 'Using named colors instead of hex values',
          jsonCode: _formatJson(namedColorsConfig),
          child: MaterialChartHollowSemiCircle.fromJson(namedColorsConfig),
        ),
      ],
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    // Simple JSON formatting for display
    return json
        .toString()
        .replaceAllMapped(
          RegExp(r'([{,])\s*'),
          (match) => '${match.group(1)}\n  ',
        )
        .replaceAll('}', '\n}');
  }
}

class PlotlyJsonExamples extends StatelessWidget {
  const PlotlyJsonExamples({super.key});

  @override
  Widget build(BuildContext context) {
    // Plotly-compatible JSON configurations
    final indicatorGaugeConfig = {
      "data": [
        {
          "type": "indicator",
          "mode": "gauge+number",
          "value": 420,
          "gauge": {
            "axis": {
              "range": [0, 500],
            },
            "bar": {"color": "darkblue"},
            "bgcolor": "lightgray",
            "hole": 0.6,
          },
        },
      ],
      "layout": {
        "width": 300,
        "height": 150,
        "font": {"color": "darkblue", "size": 14},
      },
    };

    final simplifiedPlotlyConfig = {
      "data": [
        {
          "value": 90,
          "max": 100,
          "min": 0,
          "gauge": {
            "bar": {"color": "#2E7D32"},
            "bgcolor": "#F5F5F5",
            "hole": 0.5,
          },
        },
      ],
      "layout": {
        "width": 250,
        "height": 125,
        "showlegend": false,
        "font": {"size": 16, "color": "black"},
      },
    };

    final rgbaColorsConfig = {
      "data": [
        {
          "value": 45,
          "max": 100,
          "gauge": {
            "bar": {"color": "rgba(156, 39, 176, 0.8)"},
            "bgcolor": "rgba(233, 30, 99, 0.2)",
            "hole": 0.65,
          },
        },
      ],
      "layout": {
        "width": 220,
        "height": 110,
        "font": {"color": "rgba(156, 39, 176, 1)", "size": 12},
      },
    };

    return Column(
      children: [
        // Indicator Gauge Configuration
        _ChartExample(
          title: '1. Plotly Indicator Gauge (84%)',
          description: 'Full Plotly indicator format with range 0-500',
          jsonCode: _formatJson(indicatorGaugeConfig),
          child: MaterialChartHollowSemiCircle.fromJson(indicatorGaugeConfig),
        ),

        const SizedBox(height: 30),

        // Simplified Plotly Configuration
        _ChartExample(
          title: '2. Simplified Plotly Format (90%)',
          description: 'Streamlined Plotly format with green theme',
          jsonCode: _formatJson(simplifiedPlotlyConfig),
          child: MaterialChartHollowSemiCircle.fromJson(simplifiedPlotlyConfig),
        ),

        const SizedBox(height: 30),

        // RGBA Colors Configuration
        _ChartExample(
          title: '3. RGBA Colors Format (45%)',
          description: 'Using RGBA color values with transparency',
          jsonCode: _formatJson(rgbaColorsConfig),
          child: MaterialChartHollowSemiCircle.fromJson(rgbaColorsConfig),
        ),
      ],
    );
  }

  String _formatJson(Map<String, dynamic> json) {
    // Simple JSON formatting for display
    return json
        .toString()
        .replaceAllMapped(
          RegExp(r'([{,])\s*'),
          (match) => '${match.group(1)}\n  ',
        )
        .replaceAll('}', '\n}');
  }
}

class JsonStringExamples extends StatelessWidget {
  const JsonStringExamples({super.key});

  @override
  Widget build(BuildContext context) {
    // JSON strings for demonstration
    const jsonString1 = '''
{
  "percentage": 95,
  "size": 200,
  "hollowRadius": 0.4,
  "style": {
    "activeColor": "#FF6F00",
    "inactiveColor": "#FFF3E0",
    "textColor": "#E65100",
    "showPercentageText": true,
    "showLegend": false,
    "animationDuration": 3000,
    "animationCurve": "easeInOut"
  }
}''';

    const jsonString2 = '''
{
  "data": [
    {
      "type": "indicator",
      "value": 25,
      "gauge": {
        "axis": {"range": [0, 100]},
        "bar": {"color": "rgb(220, 53, 69)"},
        "bgcolor": "rgb(248, 249, 250)",
        "hole": 0.8
      }
    }
  ],
  "layout": {
    "width": 180,
    "height": 90,
    "font": {"color": "rgb(73, 80, 87)", "size": 13}
  }
}''';

    return Column(
      children: [
        // JSON String Example 1
        _ChartExample(
          title: '1. JSON String - High Performance (95%)',
          description: 'Parsed from JSON string with orange theme',
          jsonCode: jsonString1,
          child: MaterialChartHollowSemiCircle.fromJsonString(jsonString1),
        ),

        const SizedBox(height: 30),

        // JSON String Example 2
        _ChartExample(
          title: '2. JSON String - Plotly Format (25%)',
          description: 'Low percentage with red theme and large hollow',
          jsonCode: jsonString2,
          child: MaterialChartHollowSemiCircle.fromJsonString(jsonString2),
        ),
      ],
    );
  }
}

class _ChartExample extends StatefulWidget {
  final String title;
  final String description;
  final Widget child;
  final String jsonCode;

  const _ChartExample({
    required this.title,
    required this.description,
    required this.child,
    required this.jsonCode,
  });

  @override
  State<_ChartExample> createState() => _ChartExampleState();
}

class _ChartExampleState extends State<_ChartExample> {
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description
            Text(
              widget.title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              widget.description,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Chart
            Center(child: widget.child),

            const SizedBox(height: 16),

            // Code Toggle Button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _showCode = !_showCode;
                    });
                  },
                  icon: Icon(_showCode ? Icons.code_off : Icons.code),
                  label: Text(_showCode ? 'Hide JSON' : 'Show JSON'),
                ),
              ],
            ),

            // Code Display
            if (_showCode) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    widget.jsonCode,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
