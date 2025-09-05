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

/// Enhanced charts demo with pie chart examples
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
        title: const Text('Material Pie Charts Demo'),
        backgroundColor: const Color(0xFF16213E),
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: const Color(0xFF7B9E87),
          labelColor: Colors.white,
          unselectedLabelColor: const Color(0xFFB0BEC5),
          tabs: const [
            Tab(text: 'PieChart Examples'),
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
            _buildPieChartExamples(),
          ],
        ),
      ),
    );
  }

  // ========================================
  // PIE CHART EXAMPLES
  // ========================================

  Widget _buildPieChartExamples() {
    return Column(
      children: [
        // Pie chart tab buttons
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
                _buildTabButton(0, 'Basic Pie'),
                const SizedBox(width: 8),
                _buildTabButton(1, 'Doughnut'),
                const SizedBox(width: 8),
                _buildTabButton(2, 'Interactive'),
                const SizedBox(width: 8),
                _buildTabButton(3, 'Custom Colors'),
                const SizedBox(width: 8),
                _buildTabButton(4, 'Sales Data'),
              ],
            ),
          ),
        ),
        
        // Pie chart content
        Expanded(
          child: Center(
            child: _buildCurrentPieChart(),
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentPieChart() {
    switch (_currentChartIndex) {
      case 0:
        return _buildBasicPieChart();
      case 1:
        return _buildDoughnutChart();
      case 2:
        return _buildInteractivePieChart();
      case 3:
        return _buildCustomColorsPieChart();
      case 4:
        return _buildSalesDataPieChart();
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

  /// Doughnut chart
  Widget _buildDoughnutChart() {
    final data = [
      const PieChartData(value: 40, label: 'Revenue', color: Color(0xFF2ECC71)),
      const PieChartData(value: 30, label: 'Costs', color: Color(0xFFE74C3C)),
      const PieChartData(value: 20, label: 'Marketing', color: Color(0xFF3498DB)),
      const PieChartData(value: 10, label: 'R&D', color: Color(0xFFF39C12)),
    ];

    final style = const PieChartStyle(
      backgroundColor: Color(0xFF16213E),
      holeRadius: 0.4, // Creates doughnut effect
      showLabels: true,
      showValues: true,
      showLegend: true,
      legendPosition: PieChartLegendPosition.bottom,
      labelPosition: LabelPosition.outside,
      animationDuration: Duration(milliseconds: 2500),
      animationCurve: Curves.easeInOut,
    );

    return _buildChartContainer(
      title: 'Doughnut Chart',
      subtitle: 'Pie chart with center hole for doughnut effect',
      child: MaterialPieChart(
        data: data,
        width: 600,
        height: 400,
        style: style,
      ),
    );
  }

  /// Interactive pie chart
  Widget _buildInteractivePieChart() {
    final data = [
      PieChartData(
        value: 45,
        label: 'North America',
        color: const Color(0xFF8E44AD),
        onTap: () => _showSnackBar('North America: 45%'),
      ),
      PieChartData(
        value: 25,
        label: 'Europe',
        color: const Color(0xFF1ABC9C),
        onTap: () => _showSnackBar('Europe: 25%'),
      ),
      PieChartData(
        value: 20,
        label: 'Asia',
        color: const Color(0xFFE67E22),
        onTap: () => _showSnackBar('Asia: 20%'),
      ),
      PieChartData(
        value: 10,
        label: 'Others',
        color: const Color(0xFF95A5A6),
        onTap: () => _showSnackBar('Others: 10%'),
      ),
    ];

    final style = const PieChartStyle(
      backgroundColor: Color(0xFF16213E),
      showLabels: true,
      showValues: true,
      showLegend: true,
      legendPosition: PieChartLegendPosition.right,
      labelPosition: LabelPosition.outside,
      showConnectorLines: true,
      connectorLineColor: Color(0xFF7F8C8D),
      animationDuration: Duration(milliseconds: 3000),
      animationCurve: Curves.elasticOut,
    );

    return _buildChartContainer(
      title: 'Interactive Pie Chart',
      subtitle: 'Click on segments to see details',
      child: MaterialPieChart(
        data: data,
        width: 600,
        height: 400,
        style: style,
        interactive: true,
        onAnimationComplete: () => _showSnackBar('Animation completed!'),
      ),
    );
  }

  /// Custom colors pie chart
  Widget _buildCustomColorsPieChart() {
    final data = [
      const PieChartData(value: 30, label: 'Q1', color: Color(0xFFE74C3C)),
      const PieChartData(value: 25, label: 'Q2', color: Color(0xFF3498DB)),
      const PieChartData(value: 35, label: 'Q3', color: Color(0xFF2ECC71)),
      const PieChartData(value: 10, label: 'Q4', color: Color(0xFFF39C12)),
    ];

    final style = const PieChartStyle(
      backgroundColor: Color(0xFF16213E),
      showLabels: true,
      showValues: true,
      showLegend: true,
      legendPosition: PieChartLegendPosition.bottom,
      labelPosition: LabelPosition.inside,
      labelStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      valueStyle: TextStyle(
        color: Colors.white,
        fontSize: 10,
      ),
      animationDuration: Duration(milliseconds: 1800),
      animationCurve: Curves.bounceOut,
    );

    return _buildChartContainer(
      title: 'Custom Colors Pie Chart',
      subtitle: 'Quarterly data with custom styling',
      child: MaterialPieChart(
        data: data,
        width: 600,
        height: 400,
        style: style,
      ),
    );
  }

  /// Sales data pie chart
  Widget _buildSalesDataPieChart() {
    final data = [
      const PieChartData(value: 120, label: 'Electronics', color: Color(0xFF9B59B6)),
      const PieChartData(value: 80, label: 'Clothing', color: Color(0xFF1ABC9C)),
      const PieChartData(value: 60, label: 'Books', color: Color(0xFFE67E22)),
      const PieChartData(value: 40, label: 'Home & Garden', color: Color(0xFF34495E)),
      const PieChartData(value: 30, label: 'Sports', color: Color(0xFFE74C3C)),
      const PieChartData(value: 20, label: 'Beauty', color: Color(0xFFF39C12)),
    ];

    final style = const PieChartStyle(
      backgroundColor: Color(0xFF16213E),
      showLabels: true,
      showValues: true,
      showLegend: true,
      legendPosition: PieChartLegendPosition.right,
      labelPosition: LabelPosition.outside,
      labelOffset: 30,
      animationDuration: Duration(milliseconds: 2200),
      animationCurve: Curves.easeInOut,
    );

    return _buildChartContainer(
      title: 'Sales Data Pie Chart',
      subtitle: 'Product category sales distribution',
      child: MaterialPieChart(
        data: data,
        width: 600,
        height: 400,
        style: style,
        minSizePercent: 2.0, // Ensure small segments are visible
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
          child: child,
        ),
      ],
    );
  }

  /// Helper method to show snackbar messages
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF7B9E87),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}