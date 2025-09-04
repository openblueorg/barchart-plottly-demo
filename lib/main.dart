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

/// Enhanced line chart demo with JSON schema support
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
        title: const Text('Material Charts Demo'),
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabButton(0, 'Basic Line'),
                    const SizedBox(width: 8),
                    _buildTabButton(1, 'Curved Line'),
                    const SizedBox(width: 8),
                    _buildTabButton(2, 'Simple JSON'),
                    const SizedBox(width: 8),
                    _buildTabButton(3, 'Plotly JSON'),
                    const SizedBox(width: 8),
                    _buildTabButton(4, 'Advanced JSON'),
                    const SizedBox(width: 8),
                    _buildTabButton(5, 'From Data'),
                  ],
                ),
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
      case 2:
        return _buildSimpleJsonChart();
      case 3:
        return _buildPlotlyJsonChart();
      case 4:
        return _buildAdvancedJsonChart();
      case 5:
        return _buildFromDataChart();
      default:
        return _buildBasicLineChart();
    }
  }

  /// Basic line chart with simple styling
  Widget _buildBasicLineChart() {
    return _buildChartContainer(
      title: 'Basic Line Chart',
      subtitle: 'Traditional constructor approach',
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
    return _buildChartContainer(
      title: 'Curved Line Chart',
      subtitle: 'Smooth spline interpolation',
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

  /// Simple JSON format example
  Widget _buildSimpleJsonChart() {
    final jsonData = {
      "data": [
        {"x": "Q1", "y": 25},
        {"x": "Q2", "y": 42},
        {"x": "Q3", "y": 35},
        {"x": "Q4", "y": 58},
        {"x": "Q5", "y": 48},
        {"x": "Q6", "y": 65}
      ],
      "style": {
        "lineColor": "#FF9800",
        "pointColor": "#FF9800",
        "backgroundColor": "#16213E",
        "gridColor": "#34495E",
        "strokeWidth": 4.0,
        "pointRadius": 6.0,
        "useCurvedLines": true,
        "curveIntensity": 0.4,
        "animationDuration": 2000,
        "showTooltips": true,
      },
      "width": 750.0,
      "height": 350.0,
      "padding": {
        "left": 32,
        "top": 32,
        "right": 32,
        "bottom": 32
      },
      "showPoints": true,
      "showGrid": true,
      "horizontalGridLines": 6
    };

    return _buildChartContainer(
      title: 'Simple JSON Format',
      subtitle: 'Lightweight JSON schema for quick setup',
      child: MaterialChartLine.fromJson(jsonData),
    );
  }

  /// Plotly-compatible JSON format
  Widget _buildPlotlyJsonChart() {
    const plotlyJson = '''
    {
      "data": [{
        "x": ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5", "Week 6"],
        "y": [30, 45, 38, 52, 48, 62],
        "type": "scatter",
        "mode": "lines+markers",
        "line": {
          "color": "#E91E63",
          "width": 3,
          "shape": "spline",
          "smoothing": 0.6
        },
        "marker": {
          "color": "#E91E63",
          "size": 7
        }
      }],
      "layout": {
        "width": 750,
        "height": 350,
        "plot_bgcolor": "#16213E",
        "showgrid": true,
        "animation": {
          "duration": 2200,
          "curve": "easeInOut"
        },
        "xaxis": {
          "gridcolor": "#34495E",
          "showgrid": true
        },
        "yaxis": {
          "gridcolor": "#34495E",
          "showgrid": true
        },
        "hoverlabel": {
          "bgcolor": "#FFFFFF",
          "bordercolor": "#E91E63",
          "font": {
            "size": 12,
            "color": "#424242"
          }
        },
        "margin": {
          "l": 32,
          "r": 32,
          "t": 32,
          "b": 32
        }
      }
    }
    ''';

    return _buildChartContainer(
      title: 'Plotly JSON Format',
      subtitle: 'Full Plotly.js compatibility with layout configuration',
      child: MaterialChartLine.fromJsonString(plotlyJson),
    );
  }

  /// Advanced JSON with comprehensive styling
  Widget _buildAdvancedJsonChart() {
    const advancedJson = '''
    {
      "data": [{
        "x": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"],
        "y": [15, 28, 22, 35, 42, 38, 48, 55],
        "type": "scatter",
        "mode": "lines+markers",
        "line": {
          "color": "#9C27B0",
          "width": 4,
          "shape": "spline",
          "smoothing": 0.7
        },
        "marker": {
          "color": "#9C27B0",
          "size": 8
        }
      }],
      "layout": {
        "width": 750,
        "height": 350,
        "plot_bgcolor": "#16213E",
        "paper_bgcolor": "#16213E",
        "xaxis": {
          "gridcolor": "#34495E",
          "showgrid": true,
          "tickfont": {
            "size": 12,
            "color": "#E8F4F8"
          }
        },
        "yaxis": {
          "gridcolor": "#34495E",
          "showgrid": true
        },
        "hoverlabel": {
          "bgcolor": "#FFFFFF",
          "bordercolor": "#9C27B0",
          "font": {
            "size": 14,
            "color": "#7B1FA2"
          }
        },
        "margin": {
          "l": 32,
          "r": 32,
          "t": 32,
          "b": 32
        }
      }
    }
    ''';

    return _buildChartContainer(
      title: 'Advanced JSON Styling',
      subtitle: 'Complex styling with custom animations and tooltips',
      child: MaterialChartLine.fromJsonString(advancedJson),
    );
  }

  /// From data array constructor
  Widget _buildFromDataChart() {
    return _buildChartContainer(
      title: 'From Data Arrays',
      subtitle: 'Programmatic chart creation with style map',
      child: MaterialChartLine.fromData(
        labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
        values: [22, 35, 28, 45, 38, 52, 48],
        style: {
          'lineColor': '#00BCD4',
          'pointColor': '#00BCD4',
          'backgroundColor': '#16213E',
          'gridColor': '#34495E',
          'strokeWidth': 3.5,
          'pointRadius': 6.0,
          'useCurvedLines': true,
          'curveIntensity': 0.5,
          'animationDuration': 2400,
          'animationCurve': 'easeInOut',
          'showTooltips': true,
        },
        width: 750,
        height: 350,
        showPoints: true,
        showGrid: true,
        padding: const EdgeInsets.all(32),
        horizontalGridLines: 6,
        onAnimationComplete: () {
          print('From data chart animation completed!');
        },
      ),
    );
  }

  /// Helper method to build consistent chart containers
  Widget _buildChartContainer({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Chart info
        Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFFE8F4F8),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // Chart container
        Container(
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
          child: child,
        ),
      ],
    );
  }
}
