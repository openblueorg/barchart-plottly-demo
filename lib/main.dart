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
      title: 'Gantt Chart Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const GanttExamplePage(),
    );
  }
}

/// Example demonstrating Gantt chart functionality
class GanttExamplePage extends StatelessWidget {
  const GanttExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gantt Chart Examples'),
        backgroundColor: Colors.blue[100],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 1: Basic Gantt chart
            _buildSectionTitle('1. Basic Gantt Chart'),
            _buildBasicExample(),

            const SizedBox(height: 32),

            // Example 2: Styled Gantt chart
            _buildSectionTitle('2. Styled Gantt Chart'),
            _buildStyledExample(),

            const SizedBox(height: 32),

            // Example 3: Interactive Gantt chart
            _buildSectionTitle('3. Interactive Gantt Chart'),
            _buildInteractiveExample(),
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

  /// Example using basic Gantt chart
  Widget _buildBasicExample() {
    final ganttData = [
      GanttData(
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 15),
        label: 'Project Planning',
        description: 'Initial project setup and planning phase',
        color: Colors.blue,
        icon: Icons.assignment,
      ),
      GanttData(
        startDate: DateTime(2024, 1, 10),
        endDate: DateTime(2024, 1, 25),
        label: 'Development',
        description: 'Core development work',
        color: Colors.green,
        icon: Icons.code,
      ),
      GanttData(
        startDate: DateTime(2024, 1, 20),
        endDate: DateTime(2024, 2, 5),
        label: 'Testing',
        description: 'Quality assurance and testing',
        color: Colors.orange,
        icon: Icons.bug_report,
      ),
      GanttData(
        startDate: DateTime(2024, 1, 30),
        endDate: DateTime(2024, 2, 10),
        label: 'Deployment',
        description: 'Production deployment',
        color: Colors.purple,
        icon: Icons.rocket_launch,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Basic Gantt chart with default styling:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: MaterialGanttChart(
            data: ganttData,
            width: 600,
            height: 400,
            interactive: true,
            onPointTap: (data) {
              debugPrint('Tapped: ${data.label}');
            },
          ),
        ),
      ],
    );
  }

  /// Example using styled Gantt chart
  Widget _buildStyledExample() {
    final ganttData = [
      GanttData(
        startDate: DateTime(2024, 2, 1),
        endDate: DateTime(2024, 2, 20),
        label: 'Research Phase',
        description: 'Market research and analysis',
        color: Colors.indigo,
        icon: Icons.search,
      ),
      GanttData(
        startDate: DateTime(2024, 2, 15),
        endDate: DateTime(2024, 3, 10),
        label: 'Design Phase',
        description: 'UI/UX design and prototyping',
        color: Colors.teal,
        icon: Icons.design_services,
      ),
      GanttData(
        startDate: DateTime(2024, 3, 5),
        endDate: DateTime(2024, 4, 15),
        label: 'Implementation',
        description: 'Feature development and integration',
        color: Colors.deepOrange,
        icon: Icons.build,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Styled Gantt chart with custom colors and spacing:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(8),
          ),
          child: MaterialGanttChart(
            data: ganttData,
            width: 600,
            height: 350,
            style: const GanttChartStyle(
              lineColor: Colors.blue,
              pointColor: Colors.red,
              connectionLineColor: Colors.grey,
              backgroundColor: Colors.white,
              lineWidth: 3.0,
              pointRadius: 6.0,
              connectionLineWidth: 2.0,
              verticalSpacing: 100.0,
              horizontalPadding: 40.0,
              labelOffset: 30.0,
              timelineYOffset: 80.0,
              animationDuration: Duration(milliseconds: 2000),
              animationCurve: Curves.easeInOut,
              showConnections: true,
            ),
            interactive: true,
          ),
        ),
      ],
    );
  }

  /// Example using interactive Gantt chart
  Widget _buildInteractiveExample() {
    return Builder(
      builder: (context) {
        final ganttData = [
          GanttData(
            startDate: DateTime(2024, 3, 1),
            endDate: DateTime(2024, 3, 12),
            label: 'Sprint 1',
            description: 'First development sprint',
            color: Colors.blue,
            icon: Icons.sports_esports,
            tapContent: 'Sprint 1 includes user authentication and basic UI',
          ),
          GanttData(
            startDate: DateTime(2024, 3, 10),
            endDate: DateTime(2024, 3, 22),
            label: 'Sprint 2',
            description: 'Second development sprint',
            color: Colors.green,
            icon: Icons.sports_esports,
            tapContent: 'Sprint 2 focuses on core features and API integration',
          ),
          GanttData(
            startDate: DateTime(2024, 3, 20),
            endDate: DateTime(2024, 4, 2),
            label: 'Sprint 3',
            description: 'Third development sprint',
            color: Colors.orange,
            icon: Icons.sports_esports,
            tapContent: 'Sprint 3 includes testing and bug fixes',
          ),
          GanttData(
            startDate: DateTime(2024, 3, 30),
            endDate: DateTime(2024, 4, 8),
            label: 'Sprint 4',
            description: 'Final development sprint',
            color: Colors.purple,
            icon: Icons.sports_esports,
            tapContent: 'Sprint 4 focuses on polish and deployment preparation',
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Interactive Gantt chart with tap callbacks:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: MaterialGanttChart(
                data: ganttData,
                width: 600,
                height: 450,
                style: const GanttChartStyle(
                  lineColor: Colors.deepPurple,
                  pointColor: Colors.amber,
                  connectionLineColor: Colors.blueGrey,
                  backgroundColor: Colors.grey,
                  lineWidth: 4.0,
                  pointRadius: 8.0,
                  connectionLineWidth: 1.5,
                  verticalSpacing: 110.0,
                  horizontalPadding: 50.0,
                  labelOffset: 35.0,
                  timelineYOffset: 100.0,
                  animationDuration: Duration(milliseconds: 2500),
                  animationCurve: Curves.elasticOut,
                  showConnections: true,
                ),
                interactive: true,
                onPointTap: (data) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Tapped: ${data.label}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                onPointHover: (data) {
                  debugPrint('Hovered: ${data.label}');
                },
                onAnimationComplete: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gantt chart animation completed!'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Tip: Tap on any task to see details, hover for tooltips',
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Example of how to use the Gantt chart with dynamic data loading
class DynamicGanttExample extends StatefulWidget {
  const DynamicGanttExample({super.key});

  @override
  State<DynamicGanttExample> createState() => _DynamicGanttExampleState();
}

class _DynamicGanttExampleState extends State<DynamicGanttExample> {
  List<GanttData>? ganttData;
  bool isLoading = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Gantt Chart Loading'),
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
              child: Text(isLoading ? 'Loading...' : 'Load Gantt Data'),
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
            else if (ganttData != null)
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: MaterialGanttChart(
                          data: ganttData!,
                          width: 600,
                          height: 400,
                          interactive: true,
                          onAnimationComplete: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Dynamic Gantt chart loaded!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                        ),
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
                  'Click "Load Gantt Data" to see a dynamically loaded chart',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Simulates loading data from an API
  Future<void> _loadMockData() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // Simulate API delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Simulate API response with Gantt data
      final mockData = [
        GanttData(
          startDate: DateTime.now().subtract(const Duration(days: 30)),
          endDate: DateTime.now().subtract(const Duration(days: 20)),
          label: 'Phase 1',
          description: 'Initial development phase',
          color: Colors.blue,
          icon: Icons.play_arrow,
        ),
        GanttData(
          startDate: DateTime.now().subtract(const Duration(days: 25)),
          endDate: DateTime.now().subtract(const Duration(days: 10)),
          label: 'Phase 2',
          description: 'Feature development',
          color: Colors.green,
          icon: Icons.settings,
        ),
        GanttData(
          startDate: DateTime.now().subtract(const Duration(days: 15)),
          endDate: DateTime.now().add(const Duration(days: 5)),
          label: 'Phase 3',
          description: 'Testing and refinement',
          color: Colors.orange,
          icon: Icons.check_circle,
        ),
        GanttData(
          startDate: DateTime.now().subtract(const Duration(days: 5)),
          endDate: DateTime.now().add(const Duration(days: 15)),
          label: 'Phase 4',
          description: 'Final deployment',
          color: Colors.purple,
          icon: Icons.rocket_launch,
        ),
      ];

      setState(() {
        ganttData = mockData;
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
