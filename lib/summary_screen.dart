import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryScreen extends StatelessWidget {
  final String name;
  final int age;
  final int steps;
  final double water;
  final double sleep;

  const SummaryScreen({
    super.key,
    required this.name,
    required this.age,
    required this.steps,
    required this.water,
    required this.sleep,
  });

  @override
  Widget build(BuildContext context) {
    final int safeSteps = steps.clamp(0, 25000);
    final double safeWater = water.clamp(0.0, 25.0);
    final double safeSleep = sleep.clamp(0.0, 24.0);

    return Scaffold(
      appBar: AppBar(title: const Text('Health Summary')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: $name', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Age: $age', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.black45,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Steps Walked: $safeSteps',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Water Intake: ${safeWater.toStringAsFixed(1)} liters',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Sleep Duration: ${safeSleep.toStringAsFixed(1)} hours',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Health Metrics Chart',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 300,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 25000,
                  barGroups: [
                    BarChartGroupData(
                      x: 0,
                      barRods: [
                        BarChartRodData(
                          toY: safeSteps.toDouble(),
                          width: 22,
                          gradient: const LinearGradient(
                            colors: [Colors.teal, Colors.greenAccent],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 1,
                      barRods: [
                        BarChartRodData(
                          toY: safeWater * 1000,
                          width: 22,
                          gradient: const LinearGradient(
                            colors: [Colors.blueAccent, Colors.lightBlueAccent],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                    BarChartGroupData(
                      x: 2,
                      barRods: [
                        BarChartRodData(
                          toY: safeSleep * 1000,
                          width: 22,
                          gradient: const LinearGradient(
                            colors: [Colors.deepPurple, Colors.purpleAccent],
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ],
                    ),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('Steps');
                            case 1:
                              return const Text('Water (ml)');
                            case 2:
                              return const Text('Sleep (x1000)');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
