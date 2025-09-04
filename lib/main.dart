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
      home: const MaterialChartsDemo(),
    );
  }
}

/// Enhanced charts demo with comprehensive JSON schema support
class MaterialChartsDemo extends StatefulWidget {
  const MaterialChartsDemo({super.key});

  @override
  State<MaterialChartsDemo> createState() => _MaterialChartsDemoState();
}

class _MaterialChartsDemoState extends State<MaterialChartsDemo>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentChartIndex = 0;


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
        title: const Text('Material Charts Demo'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF7B9E87),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFB0BEC5),
          tabs: const [
            Tab(text: 'LineChart Examples'),
            Tab(text: 'MultiLineChart Examples'),
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
            _buildMultiLineChartExamples(),
          ],
        ),
      ),
    );
  }
  // ========================================
  // MULTI-LINE CHART EXAMPLES
  // ========================================

  Widget _buildMultiLineChartExamples() {
    return Column(
      children: [
        // Multi-line chart tab buttons
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
                _buildTabButton(6, 'Basic Multi'),
                const SizedBox(width: 8),
                _buildTabButton(7, 'Simple JSON'),
                const SizedBox(width: 8),
                _buildTabButton(8, 'Plotly JSON'),
                const SizedBox(width: 8),
                _buildTabButton(9, 'Interactive'),
                const SizedBox(width: 8),
                _buildTabButton(10, 'From Data'),
              ],
            ),
          ),
        ),
        
        // Multi-line chart content
        Expanded(
          child: Center(
            child: _buildCurrentMultiLineChart(),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentMultiLineChart() {
    switch (_currentChartIndex) {
      case 6:
        return _buildBasicMultiLineChart();
      case 7:
        return _buildSimpleJsonMultiLineChart();
      case 8:
        return _buildPlotlyJsonMultiLineChart();
      case 9:
        return _buildInteractiveMultiLineChart();
      case 10:
        return _buildFromDataMultiLineChart();
      default:
        return _buildBasicMultiLineChart();
    }
  }

  /// Basic multi-line chart
  Widget _buildBasicMultiLineChart() {
    final series = [
      ChartSeries(
        name: 'Revenue',
        dataPoints: [
          const ChartDataPoint(value: 120, label: 'Jan'),
          const ChartDataPoint(value: 150, label: 'Feb'),
          const ChartDataPoint(value: 180, label: 'Mar'),
          const ChartDataPoint(value: 165, label: 'Apr'),
          const ChartDataPoint(value: 200, label: 'May'),
          const ChartDataPoint(value: 185, label: 'Jun'),
        ],
        color: const Color(0xFF4CAF50),
        lineWidth: 3.0,
        showPoints: true,
      ),
      ChartSeries(
        name: 'Expenses',
        dataPoints: [
          const ChartDataPoint(value: 80, label: 'Jan'),
          const ChartDataPoint(value: 95, label: 'Feb'),
          const ChartDataPoint(value: 110, label: 'Mar'),
          const ChartDataPoint(value: 105, label: 'Apr'),
          const ChartDataPoint(value: 125, label: 'May'),
          const ChartDataPoint(value: 115, label: 'Jun'),
        ],
        color: const Color(0xFF2196F3),
        lineWidth: 2.5,
        smoothLine: true,
        showPoints: true,
      ),
    ];

    final style = MultiLineChartStyle(
      colors: [const Color(0xFF4CAF50), const Color(0xFF2196F3)],
      backgroundColor: const Color(0xFF16213E),
      gridColor: const Color(0xFF34495E),
      showGrid: true,
      showLegend: true,
      legendPosition: LegendPosition.top,
      padding: const EdgeInsets.fromLTRB(32, 60, 32, 32),
      animation: const ChartAnimation(
        duration: Duration(milliseconds: 2000),
        curve: Curves.easeInOut,
      ),
    );

    return _buildChartContainer(
      title: 'Basic MultiLineChart',
      subtitle: 'Multiple series with traditional constructor',
      child: MultiLineChart(
        series: series,
        style: style,
        width: 750,
        height: 350,
      ),
    );
  }

  /// Simple JSON multi-line chart
  Widget _buildSimpleJsonMultiLineChart() {
    final multiLineJson = {
      "series": [
        {
          "name": "Product A",
          "dataPoints": [
            {"label": "Q1", "value": 120},
            {"label": "Q2", "value": 150},
            {"label": "Q3", "value": 180},
            {"label": "Q4", "value": 165}
          ],
          "color": "#E74C3C",
          "lineWidth": 3,
          "showPoints": true
        },
        {
          "name": "Product B",
          "dataPoints": [
            {"label": "Q1", "value": 80},
            {"label": "Q2", "value": 95},
            {"label": "Q3", "value": 110},
            {"label": "Q4", "value": 125}
          ],
          "color": "#3498DB",
          "smoothLine": true,
          "lineWidth": 2.5,
          "showPoints": true
        },
        {
          "name": "Product C",
          "dataPoints": [
            {"label": "Q1", "value": 100},
            {"label": "Q2", "value": 115},
            {"label": "Q3", "value": 130},
            {"label": "Q4", "value": 140}
          ],
          "color": "#2ECC71",
          "lineWidth": 2,
          "showPoints": true
        }
      ],
      "style": {
        "backgroundColor": "#16213E",
        "gridColor": "#34495E",
        "showGrid": true,
        "showLegend": true,
        "legendPosition": "top",
        "padding": {"top": 60, "right": 32, "bottom": 32, "left": 32},
        "animation": {
          "duration": 2200,
          "curve": "easeInOut"
        }
      },
      "width": 750,
      "height": 350
    };

    return _buildChartContainer(
      title: 'MultiLineChart Simple JSON',
      subtitle: 'Multiple series with simple JSON format',
      child: MultiLineChart.fromJson(multiLineJson),
    );
  }

  /// Plotly JSON multi-line chart
  Widget _buildPlotlyJsonMultiLineChart() {
    const plotlyMultiJson = '''
    {
      "data": [
        {
          "x": ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"],
          "y": [85, 92, 78, 95, 88],
          "name": "Team Alpha",
          "type": "scatter",
          "mode": "lines+markers",
          "line": {"color": "#9B59B6", "width": 3},
          "marker": {"size": 8}
        },
        {
          "x": ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"],
          "y": [70, 85, 90, 87, 92],
          "name": "Team Beta",
          "type": "scatter",
          "mode": "lines+markers",
          "line": {"color": "#E67E22", "width": 2, "shape": "spline"},
          "marker": {"size": 6}
        },
        {
          "x": ["Week 1", "Week 2", "Week 3", "Week 4", "Week 5"],
          "y": [60, 75, 82, 79, 85],
          "name": "Team Gamma",
          "type": "scatter",
          "mode": "lines",
          "line": {"color": "#1ABC9C", "width": 3, "shape": "spline"}
        }
      ],
      "layout": {
        "width": 750,
        "height": 350,
        "plot_bgcolor": "#16213E",
        "paper_bgcolor": "#16213E",
        "showlegend": true,
        "legend": {"orientation": "top"},
        "xaxis": {
          "showgrid": true,
          "gridcolor": "#34495E"
        },
        "yaxis": {
          "showgrid": true,
          "gridcolor": "#34495E"
        },
        "margin": {
          "l": 32,
          "r": 32,
          "t": 60,
          "b": 32
        }
      }
    }
    ''';

    return _buildChartContainer(
      title: 'MultiLineChart Plotly JSON',
      subtitle: 'Standard Plotly format with multiple traces',
      child: MultiLineChart.fromJsonString(plotlyMultiJson),
    );
  }

  /// Interactive multi-line chart with zoom and pan
  Widget _buildInteractiveMultiLineChart() {
    final interactiveData = {
      "data": [
        {
          "x": List.generate(20, (i) => "Day ${i + 1}"),
          "y": List.generate(20, (i) => 50 + (i * 0.8) + (i % 7) * 5),
          "name": "Stock A",
          "line": {"color": "#E74C3C", "width": 2}
        },
        {
          "x": List.generate(20, (i) => "Day ${i + 1}"),
          "y": List.generate(20, (i) => 45 + (i * 0.6) + (i % 5) * 4),
          "name": "Stock B",
          "line": {"color": "#3498DB", "width": 2, "shape": "spline"}
        },
        {
          "x": List.generate(20, (i) => "Day ${i + 1}"),
          "y": List.generate(20, (i) => 40 + (i * 0.7) + (i % 6) * 3),
          "name": "Stock C",
          "line": {"color": "#2ECC71", "width": 2}
        }
      ],
      "layout": {
        "width": 750,
        "height": 350,
        "plot_bgcolor": "#16213E",
        "showlegend": true,
        "crosshair": {
          "enabled": true,
          "lineColor": "#7F8C8D",
          "showLabel": true
        },
        "hoverlabel": {
          "bgcolor": "#34495E",
          "font": {"color": "#ECF0F1"}
        }
      },
      "enableZoom": true,
      "enablePan": true
    };

    return _buildChartContainer(
      title: 'Interactive MultiLineChart',
      subtitle: 'Zoom, pan, and crosshair functionality (try pinch/scroll to zoom)',
      child: MultiLineChart.fromJson(interactiveData),
    );
  }

  /// From data arrays multi-line chart
  Widget _buildFromDataMultiLineChart() {
    return _buildChartContainer(
      title: 'MultiLineChart From Data',
      subtitle: 'Created from simple data arrays',
      child: MultiLineChart.fromData(
        labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
        seriesData: [
          [20, 30, 25, 35, 40, 38], // Series 1
          [15, 25, 30, 28, 35, 33], // Series 2
          [10, 20, 15, 25, 30, 28], // Series 3
        ],
        seriesNames: ['Revenue', 'Costs', 'Profit'],
        colors: [
          const Color(0xFF4CAF50),
          const Color(0xFFFF9800),
          const Color(0xFF2196F3)
        ],
        width: 750,
        height: 350,
        style: {
          'backgroundColor': '#16213E',
          'gridColor': '#34495E',
          'showGrid': true,
          'showLegend': true,
          'legendPosition': 'top',
          'padding': {'top': 60, 'right': 32, 'bottom': 32, 'left': 32},
          'animation': {
            'duration': 2500,
            'curve': 'easeInOut'
          }
        },
      ),
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
          fontSize: 13,
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