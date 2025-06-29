import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TargetGPAScreen extends StatefulWidget {
  const TargetGPAScreen({super.key});

  @override
  State<TargetGPAScreen> createState() => _TargetGPAScreenState();
}

class _TargetGPAScreenState extends State<TargetGPAScreen> {
  final currentCGPAController = TextEditingController();
  final totalCreditsController = TextEditingController();
  final desiredCGPAController = TextEditingController();
  final upcomingCreditsController = TextEditingController();

  double requiredGPA = 0.0;
  bool calculated = false;

  void calculateRequiredGPA() {
    final currentCGPA = double.tryParse(currentCGPAController.text);
    final totalCredits = double.tryParse(totalCreditsController.text);
    final desiredCGPA = double.tryParse(desiredCGPAController.text);
    final upcomingCredits = double.tryParse(upcomingCreditsController.text);

    if (currentCGPA == null ||
        totalCredits == null ||
        desiredCGPA == null ||
        upcomingCredits == null ||
        upcomingCredits == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter valid values'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    final required =
        ((desiredCGPA * (totalCredits + upcomingCredits)) -
            (currentCGPA * totalCredits)) /
        upcomingCredits;

    setState(() {
      requiredGPA = required;
      calculated = true;
    });
  }

  void reset() {
    currentCGPAController.clear();
    totalCreditsController.clear();
    desiredCGPAController.clear();
    upcomingCreditsController.clear();
    setState(() {
      requiredGPA = 0.0;
      calculated = false;
    });
  }

  @override
  void dispose() {
    currentCGPAController.dispose();
    totalCreditsController.dispose();
    desiredCGPAController.dispose();
    upcomingCreditsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Target GPA Calculator', style: GoogleFonts.orbitron()),
        actions: [
          IconButton(
            onPressed: reset,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset All',
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            buildInputField(
              controller: currentCGPAController,
              label: 'Current CGPA',
            ),
            const SizedBox(height: 12),
            buildInputField(
              controller: totalCreditsController,
              label: 'Total Credits Completed',
            ),
            const SizedBox(height: 12),
            buildInputField(
              controller: desiredCGPAController,
              label: 'Desired CGPA',
            ),
            const SizedBox(height: 12),
            buildInputField(
              controller: upcomingCreditsController,
              label: 'Upcoming Semester Credits',
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: calculateRequiredGPA,
              icon: const Icon(Icons.calculate),
              label: Text(
                'Calculate Required GPA',
                style: GoogleFonts.orbitron(fontSize: 16),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
              ),
            ),
            const SizedBox(height: 24),
            if (calculated)
              Center(
                child: Text(
                  'Required GPA: ${requiredGPA.toStringAsFixed(2)}',
                  style: GoogleFonts.orbitron(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color:
                        requiredGPA > 10
                            ? Colors.redAccent
                            : requiredGPA < 6
                            ? Colors.amber
                            : Colors.greenAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
  }) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.orbitron(),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.orbitron(),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
