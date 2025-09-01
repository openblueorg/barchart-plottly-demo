import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:math';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const StackedBarChartDemo(),
    );
  }
}

/// Demo showing MaterialStackedBarChart with the exact same API patterns
/// as your existing MaterialBarChart implementation.
class StackedBarChartDemo extends StatefulWidget {
  const StackedBarChartDemo({super.key});

  @override
  State<StackedBarChartDemo> createState() => _StackedBarChartDemoState();
}

class _StackedBarChartDemoState extends State<StackedBarChartDemo> {
  int _currentIndex = 0;
  StreamController<List<List<double>>>? _streamController;
  Timer? _dataTimer;
  List<List<double>> _streamData = [
    [45, 78, 32, 89], // Series 1
    [35, 52, 44, 67], // Series 2
    [25, 33, 28, 44], // Series 3
  ];

  // Animation keys for each chart type
  final List<GlobalKey> _chartKeys = List.generate(4, (index) => GlobalKey());

  // Animation trigger state
  int _animationTrigger = 0;

  // Aesthetically pleasing pastel color palette
  static const List<Color> pastelColors = [
    Color(0xFFB8D4E3), // Soft blue
    Color(0xFFC7E8CA), // Mint green
    Color(0xFFF4D1AE), // Peach
    Color(0xFFE6B8AF), // Dusty rose
    Color(0xFFD4C5F9), // Lavender
    Color(0xFFF7D794), // Soft yellow
    Color(0xFFB8E6B8), // Light green
    Color(0xFFE8D5C4), // Beige
  ];

  // Pastel color hex strings for charts
  static const List<String> pastelColorHex = [
    '#B8D4E3', // Soft blue
    '#C7E8CA', // Mint green
    '#F4D1AE', // Peach
    '#E6B8AF', // Dusty rose
    '#D4C5F9', // Lavender
    '#F7D794', // Soft yellow
    '#B8E6B8', // Light green
    '#E8D5C4', // Beige
  ];

  @override
  void dispose() {
    _dataTimer?.cancel();
    _streamController?.close();
    super.dispose();
  }

  void _triggerAnimation() {
    setState(() {
      _animationTrigger++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stacked Bar Chart Demo',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFFE8F4F8),
          ),
        ),
        backgroundColor: const Color(0xFF16213E),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A2E), // Dark navy
              Color(0xFF0F3460), // Darker blue
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
                color: const Color(0xFF16213E), // Dark container
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
                  _buildTabButton(0, 'Traditional API'),
                  const SizedBox(width: 12),
                  _buildTabButton(1, 'Simple Data Arrays'),
                  const SizedBox(width: 12),
                  _buildTabButton(2, 'JSON Configuration'),

                ],
              ),
            ),

            // Chart content
            Expanded(child: Center(child: _buildCurrentChart())),
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
        _triggerAnimation();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected
            ? const Color(0xFF7B9E87) // Sage green when selected
            : Colors.transparent,
        foregroundColor: isSelected
            ? const Color(0xFF1A1A2E) // Dark text on light background
            : const Color(0xFFE8F4F8), // Light text when not selected
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
        return _buildTraditionalChart();
      case 1:
        return _buildSimpleDataChart();
      case 2:
        return _buildJsonChart();

      default:
        return _buildTraditionalChart();
    }
  }

  /// Traditional API using StackedBarData objects directly
  Widget _buildTraditionalChart() {
    return Container(
      key: _chartKeys[0],
      width: 1000,
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E), // Dark container
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
      child: MaterialStackedBarChart(
        data: [
          StackedBarData(
            label: 'Q1',
            segments: [
              StackedBarSegment(value: 45, color: pastelColors[0], label: 'Sales'),
              StackedBarSegment(value: 35, color: pastelColors[1], label: 'Marketing'),
              StackedBarSegment(value: 25, color: pastelColors[2], label: 'Operations'),
            ],
          ),
          StackedBarData(
            label: 'Q2',
            segments: [
              StackedBarSegment(value: 78, color: pastelColors[0], label: 'Sales'),
              StackedBarSegment(value: 52, color: pastelColors[1], label: 'Marketing'),
              StackedBarSegment(value: 33, color: pastelColors[2], label: 'Operations'),
            ],
          ),
          StackedBarData(
            label: 'Q3',
            segments: [
              StackedBarSegment(value: 32, color: pastelColors[0], label: 'Sales'),
              StackedBarSegment(value: 44, color: pastelColors[1], label: 'Marketing'),
              StackedBarSegment(value: 28, color: pastelColors[2], label: 'Operations'),
            ],
          ),
          StackedBarData(
            label: 'Q4',
            segments: [
              StackedBarSegment(value: 89, color: pastelColors[0], label: 'Sales'),
              StackedBarSegment(value: 67, color: pastelColors[1], label: 'Marketing'),
              StackedBarSegment(value: 44, color: pastelColors[2], label: 'Operations'),
            ],
          ),
        ],
        width: 800,
        height: 300,
        style: StackedBarChartStyle(
          gridColor: const Color(0xFF34495E), // Darker grid for contrast
          backgroundColor: const Color(0xFF16213E), // Dark background
          barSpacing: 0.3,
          cornerRadius: 12.0,
          animationDuration: const Duration(milliseconds: 2000),
          animationCurve: Curves.easeInOut,
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFFE8F4F8), // Light text for dark background
          ),
          valueStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E), // Dark text on light bars
          ),
        ),
        showGrid: true,
        showValues: true,
        padding: const EdgeInsets.all(32),
        horizontalGridLines: 6,
        interactive: true,
        onAnimationComplete: () {
          print('Traditional stacked chart animation completed! (Trigger: $_animationTrigger)');
        },
      ),
    );
  }

  /// Simple data arrays - matches your MaterialBarChart.fromData() API exactly
  Widget _buildSimpleDataChart() {
    return Container(
      key: _chartKeys[1],
      width: 1000,
      height: 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E), // Dark container
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
      child: MaterialStackedBarChart.fromData(
        labels: ['Q1', 'Q2', 'Q3', 'Q4'],
        values: [
          [45, 78, 32, 89], // Sales data for each quarter
          [35, 52, 44, 67], // Marketing data for each quarter
          [25, 33, 28, 44], // Operations data for each quarter
        ],
        seriesLabels: ['Sales', 'Marketing', 'Operations'],
        colors: [pastelColorHex[0], pastelColorHex[1], pastelColorHex[2]],
        width: 800,
        height: 300,
        showGrid: true,
        showValues: true,
        padding: const EdgeInsets.all(32),
        horizontalGridLines: 6,
        interactive: true,
        style: {
          'barSpacing': 0.3,
          'cornerRadius': 12.0,
          'animationDuration': 2000,
          'animationCurve': 'easeInOut',
          'gridColor': '#34495E', // Darker grid
          'backgroundColor': '#16213E', // Dark background
        },
        onAnimationComplete: () {
          print('Simple data stacked chart animation completed! (Trigger: $_animationTrigger)');
        },
      ),
    );
  }

  /// JSON configuration - supports both simple and Plotly formats
  Widget _buildJsonChart() {
    // Plotly-style JSON configuration
    final jsonConfig = {
      "data": [
        {
          "type": "bar",
          "x": ["Q1", "Q2", "Q3", "Q4"],
          "y": [45, 78, 32, 89],
          "name": "Sales",
          "marker": {"color": "#B8D4E3"}
        },
        {
          "type": "bar",
          "x": ["Q1", "Q2", "Q3", "Q4"],
          "y": [35, 52, 44, 67],
          "name": "Marketing",
          "marker": {"color": "#C7E8CA"}
        },
        {
          "type": "bar",
          "x": ["Q1", "Q2", "Q3", "Q4"],
          "y": [25, 33, 28, 44],
          "name": "Operations",
          "marker": {"color": "#F4D1AE"}
        }
      ],
      "layout": {
        "barmode": "stack",
        "width": 800,
        "height": 300,
        "plot_bgcolor": "#16213E",
        "paper_bgcolor": "#16213E",
        "bargap": 0.3,
        "showValues": true,
        "valueStyle": {
          "color": "#000000",
          "size": 12,
          "weight": "bold"
        },
        "xaxis": {
          "showgrid": true,
          "gridcolor": "#34495E",
          "tickfont": {
            "size": 12,
            "color": "#E8F4F8"
          },
          "title": {
            "text": "Quarter",
            "font": {
              "size": 14,
              "color": "#E8F4F8"
            }
          }
        },
        "yaxis": {
          "showgrid": true,
          "gridcolor": "#34495E",
          "nticks": 6,
          "tickfont": {
            "size": 12,
            "color": "#E8F4F8"
          },
          "title": {
            "text": "Revenue",
            "font": {
              "size": 14,
              "color": "#E8F4F8"
            }
          }
        },
        "font": {
          "size": 12,
          "color": "#E8F4F8"
        }
      }
    };

    return Container(
      key: _chartKeys[2],
      width: 1000,
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
      child: MaterialStackedBarChart.fromJson(jsonConfig),
    );
  }
}
