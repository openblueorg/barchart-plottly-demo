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
      title: 'Material Charts JSON Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const MaterialChartsJsonDemo(),
    );
  }
}

/// Pie Chart JSON Demo - showcasing Plotly compatibility
class MaterialChartsJsonDemo extends StatefulWidget {
  const MaterialChartsJsonDemo({super.key});

  @override
  State<MaterialChartsJsonDemo> createState() => _MaterialChartsJsonDemoState();
}

class _MaterialChartsJsonDemoState extends State<MaterialChartsJsonDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentChartIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
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
        title: const Text('Pie Chart JSON Demo - Plotly Compatible'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF7B9E87),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFB0BEC5),
          tabs: const [
            Tab(text: 'JSON Examples'),
          ],
        ),
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
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildJsonExamples(),
          ],
        ),
      ),
    );
  }

  Widget _buildJsonExamples() {
    return Column(
      children: [
        // JSON example buttons
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
                _buildTabButton(0, 'Your Example'),
                const SizedBox(width: 8),
                _buildTabButton(1, 'Simple JSON'),
                const SizedBox(width: 8),
                _buildTabButton(2, 'Basic Plotly'),
                const SizedBox(width: 8),
                _buildTabButton(3, 'Doughnut JSON'),
                const SizedBox(width: 8),
                _buildTabButton(4, 'Complex JSON'),
                const SizedBox(width: 8),
                _buildTabButton(5, 'Advanced JSON'),
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
    );
  }

  Widget _buildCurrentChart() {
    switch (_currentChartIndex) {
      case 0:
        return _buildBasicPieChart();
      case 1:
        return _buildSimpleJsonChart();
      case 2:
        return _buildBasicPlotlyChart();
      case 3:
        return _buildDoughnutJsonChart();
      case 4:
        return _buildComplexJsonChart();
      case 5:
        return _buildAdvancedJsonChart();
      default:
        return _buildBasicPieChart();
    }
  }


  /// Basic pie chart
  Widget _buildBasicPieChart() {
    final data = [
      const PieChartData(value: 35, label: 'Desktop', color: Color(0xFF4CAF50)),
      const PieChartData(value: 25, label: 'Mobile', color: Color(0xFF2196F3)),
      const PieChartData(value: 20, label: 'Tablet', color: Color(0xFFFF9800)),
      const PieChartData(value: 15, label: 'Other', color: Color(0xFF9C27B0)),
      const PieChartData(value: 5, label: 'TV', color: Color(0xFFF44336)),
    ];

    final style = const PieChartStyle(
      backgroundColor: Color(0xFF16213E),
      showLabels: true,
      showValues: true,
      showLegend: true,
      valueStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      connectorLineColor: Colors.white,
      labelStyle: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      legendPosition: PieChartLegendPosition.right,
      labelPosition: LabelPosition.outside,
      animationDuration: Duration(milliseconds: 2000),
      animationCurve: Curves.easeInOut,
    );

    return _buildChartContainer(
      title: 'Basic Pie Chart',
      subtitle: 'Simple pie chart with default styling',
      child: MaterialPieChart(
        data: data,
        width: 600,
        height: 400,
        style: style,
      ),
    );
  }

  

  /// Simple JSON format
  Widget _buildSimpleJsonChart() {
    final simpleJson = {
      "data": [
        {"value": 35, "label": "Desktop"},
        {"value": 45, "label": "Mobile"},
        {"value": 20, "label": "Tablet"}
      ],
      "layout": {
        "width": 500,
        "height": 350,
        "showlegend": true
      }
    };

    return _buildChartContainer(
      title: 'Simple JSON Format',
      subtitle: 'Basic JSON with minimal configuration',
      child: MaterialPieChart.fromJson(simpleJson),
    );
  }

  /// Basic Plotly format
  Widget _buildBasicPlotlyChart() {
    final basicPlotlyJson = {
      "data": [{
        "values": [45.2, 28.1, 18.7, 8.0],
        "labels": ["Chrome", "Firefox", "Safari", "Edge"],
        "type": "pie"
      }],
      "layout": {
        "title": "Browser Usage Statistics",
        "width": 550,
        "height": 380
      }
    };

    return _buildChartContainer(
      title: 'Basic Plotly Format',
      subtitle: 'Standard Plotly.js pie chart structure',
      child: MaterialPieChart.fromJson(basicPlotlyJson),
    );
  }

  /// Doughnut chart with hole
  Widget _buildDoughnutJsonChart() {
    final doughnutJson = {
      "data": [{
        "values": [35, 25, 20, 15, 5],
        "labels": ["Mobile", "Desktop", "Tablet", "Smart TV", "Other"],
        "type": "pie",
        "hole": 0.4,
        "marker": {
          "colors": ["#FF6B6B", "#4ECDC4", "#45B7D1", "#FFA07A", "#98D8C8"]
        }
      }],
      "layout": {
        "title": "Device Market Share",
        "width": 500,
        "height": 400,
        "showlegend": true,
        "legend": {
          "orientation": "v"
        }
      }
    };

    return _buildChartContainer(
      title: 'Doughnut Chart JSON',
      subtitle: 'Plotly doughnut using hole parameter',
      child: MaterialPieChart.fromJson(doughnutJson),
    );
  }

  /// Complex JSON with all attributes
  Widget _buildComplexJsonChart() {
    final complexJson = {
      "data": [{
        "values": [30, 25, 20, 15, 10],
        "labels": ["JavaScript", "Python", "Java", "C++", "Go"],
        "type": "pie",
        "rotation": 45,
        "textinfo": "label+percent",
        "textposition": "outside",
        "marker": {
          "colors": ["#F7DC6F", "#BB8FCE", "#85C1E9", "#F8C471", "#82E0AA"]
        }
      }],
      "layout": {
        "title": "Programming Language Popularity",
        "width": 600,
        "height": 450,
        "paper_bgcolor": "#2C3E50",
        "plot_bgcolor": "#34495E",
        "showlegend": true,
        "legend": {
          "orientation": "h",
          "x": 0,
          "y": -0.1
        },
        "font": {
          "size": 14,
          "color": "#ECF0F1"
        }
      }
    };

    return _buildChartContainer(
      title: 'Complex JSON Schema',
      subtitle: 'All Plotly attributes: rotation, textinfo, colors, fonts',
      child: MaterialPieChart.fromJson(complexJson),
    );
  }

  /// Advanced JSON with extensive styling
  Widget _buildAdvancedJsonChart() {
    final advancedJson = {
      "data": [{
        "values": [120, 100, 80, 60, 40, 20],
        "labels": ["Enterprise", "SMB", "Startup", "Education", "Non-Profit", "Government"],
        "type": "pie",
        "hole": 0.3,
        "rotation": -90,
        "textinfo": "label+value+percent",
        "textposition": "auto",
        "marker": {
          "colors": [
            "#E74C3C", "#3498DB", "#2ECC71", 
            "#F39C12", "#9B59B6", "#1ABC9C"
          ],
          "line": {
            "color": "#FFFFFF",
            "width": 3
          }
        }
      }],
      "layout": {
        "title": "Customer Segment Analysis",
        "width": 650,
        "height": 500,
        "paper_bgcolor": "#1A1A2E",
        "plot_bgcolor": "#16213E",
        "showlegend": true,
        "legend": {
          "orientation": "v",
          "x": 1.02,
          "y": 0.5,
          "bgcolor": "rgba(22, 33, 62, 0.8)",
          "bordercolor": "#2C3E50",
          "borderwidth": 1
        },
        "font": {
          "family": "Arial, sans-serif",
          "size": 12,
          "color": "#E8F4F8"
        },
        "margin": {
          "l": 50,
          "r": 50,
          "t": 80,
          "b": 50
        }
      }
    };

    return _buildChartContainer(
      title: 'Advanced JSON Configuration',
      subtitle: 'Complete Plotly schema: margins, fonts, borders, positions',
      child: MaterialPieChart.fromJson(advancedJson),
    );
  }

  // ========================================
  // HELPER WIDGETS
  // ========================================

  Widget _buildTabButton(int index, String label) {
    final isSelected = _currentChartIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentChartIndex = index;
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
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
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
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFB0BEC5),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        // Chart container
        Container(
          width: 800,
          height: 550,
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