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
      home: const GanttPlotlyExamples(),
    );
  }
}

/// Example demonstrating various Plotly JSON formats for Gantt charts
class GanttPlotlyExamples extends StatelessWidget {
  const GanttPlotlyExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gantt Chart - Plotly JSON Examples')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Plotly JSON Compatibility Examples',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Example 1: Plotly Figure Factory Format
            _buildExample(
              title: '1. Plotly Figure Factory Format',
              description:
                  'Same format as plotly.figure_factory.create_gantt()',
              chart: _buildFigureFactoryExample(),
              jsonExample: _figureFactoryJson,
            ),

            const SizedBox(height: 40),

            // Example 2: Plotly Traces Format
            _buildExample(
              title: '2. Plotly Traces Format',
              description: 'Standard Plotly.js traces with x/y arrays',
              chart: _buildTracesExample(),
              jsonExample: _tracesJson,
            ),

            const SizedBox(height: 40),

            // Example 3: Simple Array Format
            _buildExample(
              title: '3. Simple Data Format',
              description: 'Simplified format for quick creation',
              chart: _buildSimpleExample(),
              jsonExample: _simpleJson,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExample({
    required String title,
    required String description,
    required Widget chart,
    required String jsonExample,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 16),

        // Chart display
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: chart,
        ),

        const SizedBox(height: 16),

        // JSON example
        ExpansionTile(
          title: const Text('JSON Example'),
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                jsonExample,
                style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Example 1: Figure Factory Format (matches Python plotly.figure_factory.create_gantt)
  Widget _buildFigureFactoryExample() {
    const jsonData = '''
{
  "data": [
    {
      "Task": "Job A",
      "Start": "2024-01-01",
      "Finish": "2024-01-15",
      "Resource": "Team 1"
    },
    {
      "Task": "Job B",
      "Start": "2024-01-10", 
      "Finish": "2024-01-25",
      "Resource": "Team 2"
    },
    {
      "Task": "Job C",
      "Start": "2024-01-20",
      "Finish": "2024-02-05",
      "Resource": "Team 1"
    }
  ],
  "layout": {
    "title": "Project Timeline",
    "width": 700,
    "height": 400
  }
}''';

    return MaterialGanttChart.fromJsonString(jsonData);
  }

  // Example 2: Traces Format (matches Plotly.js traces)
  Widget _buildTracesExample() {
    const jsonData = '''
{
  "data": [
    {
      "x": ["2024-02-01", "2024-02-15"],
      "y": ["Design Phase", "Design Phase"],
      "mode": "lines",
      "line": {"width": 20, "color": "rgb(31, 119, 180)"},
      "name": "Design Phase"
    },
    {
      "x": ["2024-02-10", "2024-02-28"], 
      "y": ["Development", "Development"],
      "mode": "lines",
      "line": {"width": 20, "color": "rgb(255, 127, 14)"},
      "name": "Development"
    },
    {
      "x": ["2024-02-25", "2024-03-10"],
      "y": ["Testing", "Testing"],
      "mode": "lines", 
      "line": {"width": 20, "color": "rgb(44, 160, 44)"},
      "name": "Testing"
    }
  ],
  "layout": {
    "title": "Software Development",
    "xaxis": {"title": "Date", "type": "date"},
    "yaxis": {"title": "Phase"},
    "width": 700,
    "height": 400
  }
}''';

    return MaterialGanttChart.fromJsonString(jsonData);
  }

  // Example 3: Simple Format
  Widget _buildSimpleExample() {
    return MaterialGanttChart.fromData(
      tasks: ['Research', 'Planning', 'Implementation', 'Review'],
      startDates: ['2024-03-01', '2024-03-05', '2024-03-12', '2024-03-20'],
      endDates: ['2024-03-08', '2024-03-15', '2024-03-25', '2024-03-30'],
      colors: [Colors.purple, Colors.blue, Colors.orange, Colors.green],
      descriptions: [
        'Initial research phase',
        'Project planning and design',
        'Core development work',
        'Final review and testing',
      ],
      width: 700,
      height: 400,
    );
  }

  // JSON examples for display
  final String _figureFactoryJson = '''
{
  "data": [
    {
      "Task": "Job A",
      "Start": "2024-01-01", 
      "Finish": "2024-01-15",
      "Resource": "Team 1"
    },
    {
      "Task": "Job B",
      "Start": "2024-01-10",
      "Finish": "2024-01-25", 
      "Resource": "Team 2"
    }
  ],
  "layout": {
    "title": "Project Timeline",
    "width": 700,
    "height": 400
  }
}''';

  final String _tracesJson = '''
{
  "data": [
    {
      "x": ["2024-02-01", "2024-02-15"],
      "y": ["Design Phase", "Design Phase"],
      "mode": "lines",
      "line": {"width": 20, "color": "rgb(31, 119, 180)"},
      "name": "Design Phase"
    }
  ],
  "layout": {
    "title": "Software Development",
    "xaxis": {"title": "Date", "type": "date"},
    "yaxis": {"title": "Phase"}
  }
}''';

  final String _simpleJson = '''
MaterialGanttChart.fromData(
  tasks: ['Research', 'Planning', 'Implementation'],
  startDates: ['2024-03-01', '2024-03-05', '2024-03-12'],
  endDates: ['2024-03-08', '2024-03-15', '2024-03-25'],
  colors: [Colors.purple, Colors.blue, Colors.orange],
)''';
}

/// Standalone example showing Python/JavaScript compatibility
class PlotlyCompatibilityDemo extends StatelessWidget {
  const PlotlyCompatibilityDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plotly Compatibility Demo')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cross-Platform Compatibility',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            const Text(
              'The same JSON works across:',
              style: TextStyle(fontSize: 16),
            ),
            const Text('• Python: plotly.figure_factory.create_gantt()'),
            const Text('• JavaScript: Plotly.newPlot()'),
            const Text('• Flutter: MaterialGanttChart.fromJson()'),

            const SizedBox(height: 24),

            // Python equivalent code
            _buildCodeExample('Python Code', '''
import plotly.figure_factory as ff

df = [
    dict(Task="Job A", Start='2024-01-01', Finish='2024-01-15', Resource="Team 1"),
    dict(Task="Job B", Start='2024-01-10', Finish='2024-01-25', Resource="Team 2"),
    dict(Task="Job C", Start='2024-01-20', Finish='2024-02-05', Resource="Team 1")
]

fig = ff.create_gantt(df, title='Project Timeline')
fig.show()
'''),

            const SizedBox(height: 16),

            // JavaScript equivalent
            _buildCodeExample('JavaScript Code', '''
const data = [{
    x: ['2024-01-01', '2024-01-15'],
    y: ['Job A', 'Job A'],
    mode: 'lines',
    line: {width: 20},
    name: 'Job A'
}];

const layout = {
    title: 'Project Timeline',
    xaxis: {title: 'Date', type: 'date'},
    yaxis: {title: 'Tasks'}
};

Plotly.newPlot('gantt-div', data, layout);
'''),

            const SizedBox(height: 16),

            // Flutter code
            _buildCodeExample('Flutter Code', '''
MaterialGanttChart.fromJson({
  "data": [
    {
      "Task": "Job A",
      "Start": "2024-01-01", 
      "Finish": "2024-01-15",
      "Resource": "Team 1"
    }
  ],
  "layout": {
    "title": "Project Timeline",
    "width": 700,
    "height": 400
  }
})
'''),

            const SizedBox(height: 24),

            // Live example
            const Text(
              'Live Example:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildLiveExample(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCodeExample(String title, String code) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            code,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveExample() {
    // This exact JSON format works in Python, JavaScript, and Flutter
    const plotlyJson = '''
{
  "data": [
    {
      "Task": "Research Phase",
      "Start": "2024-01-01",
      "Finish": "2024-01-15", 
      "Resource": "Data Team"
    },
    {
      "Task": "Design Phase",
      "Start": "2024-01-12",
      "Finish": "2024-01-28",
      "Resource": "Design Team"
    },
    {
      "Task": "Development Phase", 
      "Start": "2024-01-25",
      "Finish": "2024-02-15",
      "Resource": "Dev Team"
    },
    {
      "Task": "Testing Phase",
      "Start": "2024-02-10",
      "Finish": "2024-02-25",
      "Resource": "QA Team"
    },
    {
      "Task": "Deployment",
      "Start": "2024-02-22",
      "Finish": "2024-03-01",
      "Resource": "DevOps Team"
    }
  ],
  "layout": {
    "title": "Software Development Lifecycle",
    "width": 800,
    "height": 500,
    "plot_bgcolor": "white",
    "paper_bgcolor": "white"
  }
}''';

    return MaterialGanttChart.fromJsonString(plotlyJson);
  }
}
