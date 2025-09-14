import 'package:flutter/material.dart';

import 'material_charts/material_charts.dart';
// Import your chart files:
// import 'lib/src/area_chart/models.dart';
// import 'lib/src/area_chart/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Area Chart Demo',
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Area Charts'), elevation: 2),
      body: Column(
        children: [
          // Tab bar
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _selectedIndex == 0
                                ? Colors.blue
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Original API',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _selectedIndex == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 1),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _selectedIndex == 1
                                ? Colors.blue
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Plotly JSON',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _selectedIndex == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedIndex = 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color:
                            _selectedIndex == 2
                                ? Colors.blue
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Comparison',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              _selectedIndex == 2 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: _buildContent(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOriginalExamples();
      case 1:
        return _buildPlotlyExamples();
      case 2:
        return _buildComparisonView();
      default:
        return const SizedBox();
    }
  }

  Widget _buildOriginalExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Original Implementation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        _buildCard(
          title: 'Simple Area Chart',
          child: MaterialAreaChart(
            series: [
              AreaChartSeries(
                name: 'Revenue',
                dataPoints: const [
                  AreaChartData(value: 10, label: 'Jan'),
                  AreaChartData(value: 15, label: 'Feb'),
                  AreaChartData(value: 12, label: 'Mar'),
                  AreaChartData(value: 18, label: 'Apr'),
                  AreaChartData(value: 22, label: 'May'),
                  AreaChartData(value: 25, label: 'Jun'),
                ],
                color: Colors.blue,
                gradientColor: Colors.blue.withOpacity(0.2),
                lineWidth: 3.0,
                showPoints: true,
                pointSize: 5.0,
              ),
            ],
            width: 400,
            height: 250,
            style: const AreaChartStyle(
              backgroundColor: Colors.white,
              showGrid: true,
              animationDuration: Duration(milliseconds: 2000),
            ),
          ),
        ),

        _buildCard(
          title: 'Multi-Series Chart',
          child: MaterialAreaChart(
            series: [
              AreaChartSeries(
                name: 'Product A',
                dataPoints: const [
                  AreaChartData(value: 20, label: 'Q1'),
                  AreaChartData(value: 25, label: 'Q2'),
                  AreaChartData(value: 22, label: 'Q3'),
                  AreaChartData(value: 28, label: 'Q4'),
                ],
                color: Colors.red,
                gradientColor: Colors.red.withOpacity(0.3),
                lineWidth: 2.0,
              ),
              AreaChartSeries(
                name: 'Product B',
                dataPoints: const [
                  AreaChartData(value: 15, label: 'Q1'),
                  AreaChartData(value: 18, label: 'Q2'),
                  AreaChartData(value: 20, label: 'Q3'),
                  AreaChartData(value: 23, label: 'Q4'),
                ],
                color: Colors.green,
                gradientColor: Colors.green.withOpacity(0.3),
                lineWidth: 2.0,
              ),
            ],
            width: 400,
            height: 250,
          ),
        ),
      ],
    );
  }

  Widget _buildPlotlyExamples() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Plotly JSON Implementation',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        _buildCard(
          title: 'From Python Plotly JSON',
          description:
              'Direct conversion from Python plotly.graph_objects output',
          child: MaterialAreaChart.fromPlotlyJson(
            plotlyJson: _getSimplePlotlyJson(),
            width: 400,
            height: 250,
          ),
        ),

        _buildCard(
          title: 'Multi-Series with Custom Colors',
          description: 'Multiple traces with hex colors and RGBA fills',
          child: MaterialAreaChart.fromPlotlyJson(
            plotlyJson: _getMultiSeriesPlotlyJson(),
            width: 400,
            height: 250,
          ),
        ),

        _buildCard(
          title: 'Style Overrides',
          description: 'Plotly data with Flutter-specific style customizations',
          child: MaterialAreaChart.fromPlotlyJson(
            plotlyJson: _getSimplePlotlyJson(),
            width: 400,
            height: 250,
            styleOverrides: const AreaChartStyle(
              backgroundColor: Color(0xFFF8F9FA),
              gridColor: Colors.blue,
              animationDuration: Duration(milliseconds: 3000),
              showPoints: true,
              defaultPointSize: 8.0,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Side-by-Side Comparison',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        const Text(
          'Same Data, Different APIs',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _buildCard(
                title: 'Original API',
                child: MaterialAreaChart(
                  series: [
                    AreaChartSeries(
                      name: 'Sales',
                      dataPoints: const [
                        AreaChartData(value: 100, label: 'Jan'),
                        AreaChartData(value: 120, label: 'Feb'),
                        AreaChartData(value: 110, label: 'Mar'),
                        AreaChartData(value: 140, label: 'Apr'),
                      ],
                      color: Colors.purple,
                      gradientColor: Colors.purple.withOpacity(0.2),
                      lineWidth: 3.0,
                    ),
                  ],
                  width: 350,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildCard(
                title: 'Plotly JSON',
                child: MaterialAreaChart.fromPlotlyJson(
                  plotlyJson: '''
                  {
                    "data": [
                      {
                        "x": ["Jan", "Feb", "Mar", "Apr"],
                        "y": [100, 120, 110, 140],
                        "fill": "tozeroy",
                        "name": "Sales",
                        "line": {"color": "purple", "width": 3},
                        "fillcolor": "rgba(128, 0, 128, 0.2)"
                      }
                    ],
                    "layout": {
                      "title": "Monthly Sales"
                    }
                  }
                  ''',
                  width: 350,
                  height: 200,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),
        const Text(
          'Performance Metrics',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),

        _buildMetricsTable(),
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

  Widget _buildMetricsTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(2),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[100]),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Feature',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Original',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Plotly JSON',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            _buildTableRow('Data Input', '✅ Manual', '✅ JSON/Map'),
            _buildTableRow('Python Compatibility', '❌ No', '✅ Direct'),
            _buildTableRow(
              'Styling Options',
              '✅ Full Control',
              '✅ + Overrides',
            ),
            _buildTableRow('Performance', '✅ Optimal', '✅ Good*'),
            _buildTableRow('Type Safety', '✅ Compile-time', '⚠️ Runtime'),
            _buildTableRow(
              'Learning Curve',
              '⚠️ Flutter-specific',
              '✅ Familiar',
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String feature, String original, String plotly) {
    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8), child: Text(feature)),
        Padding(padding: const EdgeInsets.all(8), child: Text(original)),
        Padding(padding: const EdgeInsets.all(8), child: Text(plotly)),
      ],
    );
  }

  String _getSimplePlotlyJson() {
    return '''
    {
      "data": [
        {
          "x": ["Jan", "Feb", "Mar", "Apr", "May", "Jun"],
          "y": [20, 14, 23, 25, 22, 16],
          "type": "scatter",
          "mode": "lines",
          "fill": "tozeroy",
          "name": "Monthly Sales",
          "line": {
            "color": "#4CAF50",
            "width": 3
          },
          "marker": {
            "size": 6
          },
          "fillcolor": "rgba(76, 175, 80, 0.3)"
        }
      ],
      "layout": {
        "title": "Sales Performance",
        "xaxis": {
          "title": "Month"
        },
        "yaxis": {
          "title": "Sales (K)"
        },
        "plot_bgcolor": "#FAFAFA"
      }
    }
    ''';
  }

  String _getMultiSeriesPlotlyJson() {
    return '''
    {
      "data": [
        {
          "x": [1, 2, 3, 4, 5, 6],
          "y": [10, 15, 13, 17, 16, 18],
          "type": "scatter",
          "mode": "lines",
          "fill": "tozeroy",
          "name": "Product A",
          "line": {
            "color": "#FF6B6B",
            "width": 3
          },
          "fillcolor": "rgba(255, 107, 107, 0.3)"
        },
        {
          "x": [1, 2, 3, 4, 5, 6],
          "y": [8, 12, 11, 14, 13, 15],
          "type": "scatter",
          "mode": "lines",
          "fill": "tonexty",
          "name": "Product B",
          "line": {
            "color": "#4ECDC4",
            "width": 2
          },
          "fillcolor": "rgba(78, 205, 196, 0.3)"
        }
      ],
      "layout": {
        "title": "Product Performance",
        "xaxis": {"title": "Quarter"},
        "yaxis": {"title": "Performance Score"}
      }
    }
    ''';
  }
}
