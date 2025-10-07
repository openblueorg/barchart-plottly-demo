import 'package:flutter/material.dart';
import 'package:material_charts/material_charts.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B9E87), // Sage green
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(
          0xFF1A1A2E,
        ), // Dark navy background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16213E), // Darker blue-grey
          foregroundColor: Color(0xFFE8F4F8), // Light mint text
          elevation: 0,
        ),
      ),
      home: const BarChartDemo(),
    );
  }
}

class BarChartDemo extends StatefulWidget {
  const BarChartDemo({super.key});

  @override
  State<BarChartDemo> createState() => _BarChartDemoState();
}

class _BarChartDemoState extends State<BarChartDemo> {
  int _currentIndex = 2;
  StreamController<List<double>>? _streamController;
  Timer? _dataTimer;
  List<double> _streamData = [45, 78, 32, 89, 56, 67, 23, 91];

  // Animation keys for each chart type
  final List<GlobalKey> _chartKeys = List.generate(4, (index) => GlobalKey());

  // Animation trigger state
  int _animationTrigger = 0;

  // Rotation state for each chart type (index 0-3)
  final Map<int, double> _chartRotations = {
    0: 0.0, // Traditional API
    1: 0.0, // Simple Data Arrays
    2: 180.0, // JSON Configuration (matches current JSON config)
    3: 0.0, // Stream Data
  };

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
    _streamController?.close();
    _dataTimer?.cancel();
    super.dispose();
  }

  void _triggerAnimation() {
    setState(() {
      _animationTrigger++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 600;
    final isMediumScreen = screenWidth >= 600 && screenWidth < 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bar Chart Demo',
          style: TextStyle(
            fontWeight: FontWeight.w300,
            color: Color(0xFFE8F4F8),
            fontSize: isSmallScreen ? 16 : 20,
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
              margin: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
              padding: EdgeInsets.all(isSmallScreen ? 4.0 : 8.0),
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
              child:
                  isSmallScreen
                      ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildTabButton(0, 'Traditional API'),
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: _buildTabButton(1, 'Simple Data'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: _buildTabButton(2, 'JSON Config'),
                              ),
                              // const SizedBox(width: 4),
                              // Expanded(child: _buildTabButton(3, 'Stream')),
                            ],
                          ),
                        ],
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildTabButton(
                            0,
                            isSmallScreen ? 'Trad' : 'Traditional API',
                          ),
                          SizedBox(width: isSmallScreen ? 4 : 12),
                          _buildTabButton(
                            1,
                            isSmallScreen ? 'Simple' : 'Simple Data Arrays',
                          ),
                          SizedBox(width: isSmallScreen ? 4 : 12),
                          _buildTabButton(
                            2,
                            isSmallScreen ? 'JSON' : 'JSON Configuration',
                          ),
                          // SizedBox(width: isSmallScreen ? 4 : 12),
                          // _buildTabButton(
                          //   3,
                          //   isSmallScreen ? 'Stream' : 'Stream Data',
                          // ),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final isSelected = _currentIndex == index;
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _currentIndex = index;
        });
        // Trigger animation when switching tabs
        _triggerAnimation();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected
                ? const Color(0xFF7B9E87) // Sage green when selected
                : Colors.transparent,
        foregroundColor:
            isSelected
                ? const Color(0xFF1A1A2E) // Dark text on light background
                : const Color(0xFFE8F4F8), // Light text when not selected
        elevation: 0,
        padding: EdgeInsets.symmetric(
          horizontal: isSmallScreen ? 8 : 16,
          vertical: isSmallScreen ? 8 : 12,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side:
            isSelected
                ? null
                : BorderSide(color: const Color(0xFF2C3E50), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: isSmallScreen ? 10 : 13,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        ),
        textAlign: TextAlign.center,
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
      case 3:
        return _buildStreamChart();
      default:
        return _buildTraditionalChart();
    }
  }

  Widget _buildTraditionalChart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isSmallScreen = screenWidth < 600;

        // Calculate responsive dimensions
        final containerWidth = screenWidth * 0.95;
        final containerHeight = (screenHeight * 0.6).clamp(300.0, 500.0);
        final chartWidth = (containerWidth - (isSmallScreen ? 32 : 48));
        final chartHeight = (containerHeight - (isSmallScreen ? 48 : 96));

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildRotationControls(0),
              Container(
                key: _chartKeys[0],
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 16,
                ),
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
                child: MaterialBarChart(
                  data: [
                    BarChartData(
                      value: 45,
                      label: 'Jan',
                      color: pastelColors[0],
                    ),
                    BarChartData(
                      value: 78,
                      label: 'Feb',
                      color: pastelColors[1],
                    ),
                    BarChartData(
                      value: 32,
                      label: 'Mar',
                      color: pastelColors[2],
                    ),
                    BarChartData(
                      value: 89,
                      label: 'Apr',
                      color: pastelColors[3],
                    ),
                    BarChartData(
                      value: 56,
                      label: 'May',
                      color: pastelColors[4],
                    ),
                    BarChartData(
                      value: 67,
                      label: 'Jun',
                      color: pastelColors[5],
                    ),
                    BarChartData(
                      value: 23,
                      label: 'Jul',
                      color: pastelColors[6],
                    ),
                    BarChartData(
                      value: 91,
                      label: 'Aug',
                      color: pastelColors[7],
                    ),
                  ],
                  width: chartWidth,
                  height: chartHeight,
                  style: BarChartStyle(
                    barColor: const Color(0xFF7B9E87),
                    gridColor: const Color(
                      0xFF34495E,
                    ), // Darker grid for contrast
                    backgroundColor: const Color(0xFF16213E), // Dark background
                    barSpacing: 0.3,
                    cornerRadius: 12.0,
                    animationDuration: const Duration(milliseconds: 2000),
                    animationCurve: Curves.easeInOut,
                    gradientEffect: true,
                    gradientColors: const [
                      Color(0xFFB8D4E3),
                      Color(0xFF7B9E87),
                    ],
                    rotation: _chartRotations[0]!,
                    labelStyle: TextStyle(
                      fontSize: isSmallScreen ? 9 : 12,
                      fontWeight: FontWeight.w500,
                      color: Color(
                        0xFFE8F4F8,
                      ), // Light text for dark background
                    ),
                    valueStyle: TextStyle(
                      fontSize: isSmallScreen ? 8 : 10,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E), // Dark text on light bars
                    ),
                  ),
                  showGrid: true,
                  showValues: true,
                  padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
                  horizontalGridLines: 6,
                  interactive: true,
                  onAnimationComplete: () {
                    print(
                      'Traditional bar chart animation completed! (Trigger: $_animationTrigger)',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSimpleDataChart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isSmallScreen = screenWidth < 600;

        // Calculate responsive dimensions
        final containerWidth = screenWidth * 0.95;
        final containerHeight = (screenHeight * 0.6).clamp(300.0, 500.0);
        final chartWidth = (containerWidth - (isSmallScreen ? 32 : 48));
        final chartHeight = (containerHeight - (isSmallScreen ? 48 : 96));

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildRotationControls(1),
              Container(
                key: _chartKeys[1],
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 16,
                ),
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
                child: MaterialBarChart.fromData(
                  labels: [
                    'Jan',
                    'Feb',
                    'Mar',
                    'Apr',
                    'May',
                    'Jun',
                    'Jul',
                    'Aug',
                  ],
                  values: [45, 78, 32, 89, 56, 67, 23, 91],
                  colors: pastelColorHex,
                  width: chartWidth,
                  height: chartHeight,
                  showGrid: true,
                  showValues: true,
                  padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
                  horizontalGridLines: 6,
                  interactive: true,
                  style: {
                    'barSpacing': 0.3,
                    'cornerRadius': 12.0,
                    'animationDuration': 2000,
                    'animationCurve': 'easeInOut',
                    'gradientEffect': true,
                    'gradientColors': ['#B8D4E3', '#7B9E87'],
                    'gridColor': '#34495E', // Darker grid
                    'backgroundColor': '#16213E', // Dark background
                    'rotation': _chartRotations[1]!,
                  },
                  onAnimationComplete: () {
                    print(
                      'Simple data chart animation completed! (Trigger: $_animationTrigger)',
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildJsonChart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isSmallScreen = screenWidth < 600;

        // Calculate responsive dimensions
        final containerWidth = screenWidth * 0.95;
        final containerHeight = (screenHeight * 0.6).clamp(300.0, 500.0);
        final chartWidth = (containerWidth - (isSmallScreen ? 32 : 48));
        final chartHeight = (containerHeight - (isSmallScreen ? 48 : 96));

        final jsonConfig = {
          "data": [
            {
              "type": "bar",
              "x": ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug"],
              "y": [45, 78, 32, 89, 56, 67, 23, 91],
              "marker": {
                "color": [
                  "#F1C40F",
                  "#E67E22",
                  "#1ABC9C",
                  "#3498DB",
                  "#9B59B6",
                  "#2ECC71",
                  "#E74C3C",
                  "#34495E",
                ],
                "colorscale": ["#B8D4E3", "#7B9E87"],
              },
            },
          ],
          "layout": {
            "width": chartWidth,
            "height": chartHeight,
            "plot_bgcolor": "#16213E",
            "paper_bgcolor": "#16213E",
            "showlegend": false,
            "rotation": _chartRotations[2]!,
            "bargap": 0.3,
            "bargroupgap": 0.1,

            "xaxis": {
              "showgrid": true,
              "gridcolor": "#34495E",
              "tickfont": {"size": isSmallScreen ? 10 : 16, "color": "#E8F4F8"},
              "tickcolor": "#E8F4F8",
              "title": {
                "text": "Months",
                "font": {"size": isSmallScreen ? 12 : 18, "color": "#E8F4F8"},
              },
            },
            "yaxis": {
              "showgrid": true,
              "gridcolor": "#34495E",
              "nticks": 6,
              "tickfont": {"size": isSmallScreen ? 10 : 14, "color": "#E8F4F8"},
              "tickcolor": "#E8F4F8",
              "title": {
                "text": "Values",
                "font": {"size": isSmallScreen ? 12 : 18, "color": "#E8F4F8"},
              },
            },

            "font": {"size": isSmallScreen ? 10 : 12, "color": "#E8F4F8"},
          },
        };

        return SingleChildScrollView(
          child: Column(
            children: [
              _buildRotationControls(2),
              Container(
                key: _chartKeys[2],
                width: containerWidth,
                height: containerHeight,
                padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
                margin: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 8 : 16,
                ),
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
                child: MaterialBarChart.fromJson(jsonConfig),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStreamChart() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isSmallScreen = screenWidth < 600;

        // Calculate responsive dimensions
        final containerWidth = screenWidth * 0.95;
        final containerHeight = (screenHeight * 0.5).clamp(250.0, 450.0);
        final chartWidth = (containerWidth - (isSmallScreen ? 32 : 48));
        final chartHeight = (containerHeight - (isSmallScreen ? 48 : 96));

        return SingleChildScrollView(
          child: Column(
            children: [
              // Rotation controls
              _buildRotationControls(3),

              // Control buttons
              Container(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 8.0 : 16.0),
                padding: EdgeInsets.all(isSmallScreen ? 8.0 : 16.0),
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
                child:
                    isSmallScreen
                        ? Column(
                          children: [
                            _buildControlButton(
                              'Start',
                              const Color(0xFFC7E8CA), // Mint green
                              const Color(0xFF1A1A2E), // Dark text
                              _startStreaming,
                            ),
                            const SizedBox(height: 8),
                            _buildControlButton(
                              'Stop',
                              const Color(0xFFE6B8AF), // Dusty rose
                              const Color(0xFF1A1A2E), // Dark text
                              _stopStreaming,
                            ),
                            const SizedBox(height: 8),
                            _buildControlButton(
                              'Reset',
                              const Color(0xFFF4D1AE), // Peach
                              const Color(0xFF1A1A2E), // Dark text
                              _resetData,
                            ),
                          ],
                        )
                        : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildControlButton(
                              'Start Streaming',
                              const Color(0xFFC7E8CA), // Mint green
                              const Color(0xFF1A1A2E), // Dark text
                              _startStreaming,
                            ),
                            const SizedBox(width: 16),
                            _buildControlButton(
                              'Stop Streaming',
                              const Color(0xFFE6B8AF), // Dusty rose
                              const Color(0xFF1A1A2E), // Dark text
                              _stopStreaming,
                            ),
                            const SizedBox(width: 16),
                            _buildControlButton(
                              'Reset Data',
                              const Color(0xFFF4D1AE), // Peach
                              const Color(0xFF1A1A2E), // Dark text
                              _resetData,
                            ),
                          ],
                        ),
              ),

              // Status indicator
              Container(
                margin: EdgeInsets.only(bottom: isSmallScreen ? 8.0 : 16.0),
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 20,
                  vertical: isSmallScreen ? 8 : 12,
                ),
                decoration: BoxDecoration(
                  color:
                      _dataTimer?.isActive == true
                          ? const Color(0xFFC7E8CA) // Full opacity mint
                          : const Color(0xFF34495E), // Dark grey
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        _dataTimer?.isActive == true
                            ? const Color(0xFF7B9E87) // Sage green
                            : const Color(0xFF2C3E50), // Dark border
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _dataTimer?.isActive == true
                          ? Icons.circle
                          : Icons.circle_outlined,
                      size: isSmallScreen ? 10 : 12,
                      color:
                          _dataTimer?.isActive == true
                              ? const Color(
                                0xFF1A1A2E,
                              ) // Dark icon on light background
                              : const Color(
                                0xFFE8F4F8,
                              ), // Light icon on dark background
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _dataTimer?.isActive == true
                          ? 'Streaming Active'
                          : 'Streaming Stopped',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: isSmallScreen ? 11 : 14,
                        color:
                            _dataTimer?.isActive == true
                                ? const Color(
                                  0xFF1A1A2E,
                                ) // Dark text on light background
                                : const Color(
                                  0xFFE8F4F8,
                                ), // Light text on dark background
                      ),
                    ),
                  ],
                ),
              ),

              // Chart
              StreamBuilder<List<double>>(
                stream: _streamController?.stream,
                initialData: _streamData,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? _streamData;
                  return Container(
                    key: _chartKeys[3],
                    width: containerWidth,
                    height: containerHeight,
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 24),
                    margin: EdgeInsets.symmetric(
                      horizontal: isSmallScreen ? 8 : 16,
                    ),
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
                      border: Border.all(
                        color: const Color(0xFF2C3E50),
                        width: 1,
                      ),
                    ),
                    child: MaterialBarChart.fromData(
                      labels: [
                        'Jan',
                        'Feb',
                        'Mar',
                        'Apr',
                        'May',
                        'Jun',
                        'Jul',
                        'Aug',
                      ],
                      values: data,
                      colors: pastelColorHex,
                      width: chartWidth,
                      height: chartHeight,
                      showGrid: true,
                      showValues: true,
                      padding: EdgeInsets.all(isSmallScreen ? 16 : 32),
                      horizontalGridLines: 6,
                      interactive: true,
                      style: {
                        'barSpacing': 0.3,
                        'cornerRadius': 12.0,
                        'animationDuration':
                            500, // Faster animation for streaming
                        'animationCurve': 'easeInOut',
                        'gradientEffect': true,
                        'gradientColors': ['#B8D4E3', '#7B9E87'],
                        'gridColor': '#34495E', // Darker grid
                        'backgroundColor': '#16213E', // Dark background
                        'rotation': _chartRotations[3]!,
                      },
                      onAnimationComplete: () {
                        if (_dataTimer?.isActive == true) {
                          print(
                            'Stream data updated! Current values: $data (Trigger: $_animationTrigger)',
                          );
                        } else {
                          print(
                            'Stream chart animation completed! (Trigger: $_animationTrigger)',
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildControlButton(
    String label,
    Color backgroundColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return SizedBox(
      width: isSmallScreen ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(
            horizontal: isSmallScreen ? 16 : 20,
            vertical: isSmallScreen ? 10 : 12,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: isSmallScreen ? 11 : 13,
          ),
        ),
      ),
    );
  }

  void _startStreaming() {
    _streamController ??= StreamController<List<double>>.broadcast();

    _dataTimer?.cancel();
    _dataTimer = Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      if (mounted) {
        setState(() {
          // Simulate real-time data updates
          final random = Random();
          _streamData =
              _streamData.map((value) {
                // Add some randomness to simulate real-world data fluctuations
                final change = (random.nextDouble() - 0.5) * 20; // ±10 change
                return (value + change).clamp(
                  10.0,
                  100.0,
                ); // Keep values in reasonable range
              }).toList();

          _streamController?.add(_streamData);
        });
      }
    });
  }

  void _stopStreaming() {
    _dataTimer?.cancel();
    setState(() {});
  }

  void _resetData() {
    _stopStreaming();
    setState(() {
      _streamData = [45, 78, 32, 89, 56, 67, 23, 91];
      _streamController?.add(_streamData);
    });
  }

  void _setRotation(int chartIndex, double rotation) {
    setState(() {
      _chartRotations[chartIndex] = rotation;
    });
  }

  Widget _buildRotationControls(int chartIndex) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;
    final rotations = [0.0, 90.0, 180.0, 270.0];

    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 8.0 : 16.0),
      padding: EdgeInsets.all(isSmallScreen ? 8.0 : 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2C3E50), width: 1),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: isSmallScreen ? 4 : 8,
        runSpacing: isSmallScreen ? 4 : 0,
        children: [
          Text(
            'Rotation: ',
            style: TextStyle(
              fontSize: isSmallScreen ? 11 : 13,
              fontWeight: FontWeight.w500,
              color: Color(0xFFE8F4F8),
            ),
          ),
          ...rotations.map((rotation) {
            final isSelected = _chartRotations[chartIndex] == rotation;
            return ElevatedButton(
              onPressed: () => _setRotation(chartIndex, rotation),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isSelected ? const Color(0xFF7B9E87) : Colors.transparent,
                foregroundColor:
                    isSelected
                        ? const Color(0xFF1A1A2E)
                        : const Color(0xFFE8F4F8),
                elevation: 0,
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 12 : 16,
                  vertical: isSmallScreen ? 6 : 8,
                ),
                minimumSize: Size(
                  isSmallScreen ? 50 : 60,
                  isSmallScreen ? 32 : 36,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                side:
                    isSelected
                        ? null
                        : BorderSide(color: const Color(0xFF2C3E50), width: 1),
              ),
              child: Text(
                '${rotation.toInt()}°',
                style: TextStyle(
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
