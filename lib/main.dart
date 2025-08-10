import 'package:flutter/material.dart';
import 'summary_screen.dart';

void main() {
  runApp(const HealthApp());
}

class HealthApp extends StatelessWidget {
  const HealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _stepsController = TextEditingController();
  final _waterController = TextEditingController();
  final _sleepController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _stepsController.dispose();
    _waterController.dispose();
    _sleepController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SummaryScreen(
          name: _nameController.text.trim(),
          age: int.parse(_ageController.text.trim()),
          steps: int.parse(_stepsController.text.trim()),
          water: double.parse(_waterController.text.trim()),
          sleep: double.parse(_sleepController.text.trim()),
        ),
      ),
    );
  }

  Widget _buildNumberField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?) validator,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint),
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Health Input')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter name' : null,
              ),
              const SizedBox(height: 12),
              _buildNumberField(
                label: 'Age',
                controller: _ageController,
                validator: (v) {
                  final val = int.tryParse(v ?? '');
                  if (val == null || val < 0 || val > 120) {
                    return 'Enter valid age (0–120)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildNumberField(
                label: 'Steps Walked',
                controller: _stepsController,
                hint: '0 - 25000',
                validator: (v) {
                  final val = int.tryParse(v ?? '');
                  if (val == null || val < 0 || val > 25000) {
                    return 'Enter valid steps (0–25000)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildNumberField(
                label: 'Water Intake (liters)',
                controller: _waterController,
                hint: 'e.g. 2.5',
                validator: (v) {
                  final val = double.tryParse(v ?? '');
                  if (val == null || val < 0 || val > 25) {
                    return 'Enter valid water (0–25 liters)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              _buildNumberField(
                label: 'Sleep Duration (hours)',
                controller: _sleepController,
                hint: 'e.g. 7.5',
                validator: (v) {
                  final val = double.tryParse(v ?? '');
                  if (val == null || val < 0 || val > 24) {
                    return 'Enter valid sleep (0–24 hours)';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
