import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({super.key});

  @override
  State<SemesterScreen> createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  final List<Map<String, dynamic>> semesters = [];

  final gpaController = TextEditingController();
  final creditController = TextEditingController();

  double cgpa = 0.0;

  void addSemester() {
    final gpa = double.tryParse(gpaController.text);
    final credits = double.tryParse(creditController.text);

    if (gpa == null || credits == null) return;

    setState(() {
      semesters.add({'gpa': gpa, 'credits': credits});
      gpaController.clear();
      creditController.clear();
    });
  }

  void calculateCGPA() {
    double totalWeightedGPA = 0;
    double totalCredits = 0;

    for (var sem in semesters) {
      totalWeightedGPA += sem['gpa'] * sem['credits'];
      totalCredits += sem['credits'];
    }

    setState(() {
      cgpa = totalCredits > 0 ? totalWeightedGPA / totalCredits : 0.0;
    });
  }

  void reset() {
    setState(() {
      semesters.clear();
      cgpa = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('CGPA Calculator', style: GoogleFonts.orbitron()),
        actions: [
          IconButton(
            onPressed: reset,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset',
          ),
        ],
      ),
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: gpaController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.orbitron(),
              decoration: InputDecoration(
                labelText: 'Semester GPA',
                labelStyle: GoogleFonts.orbitron(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: creditController,
              keyboardType: TextInputType.number,
              style: GoogleFonts.orbitron(),
              decoration: InputDecoration(
                labelText: 'Credits for Semester',
                labelStyle: GoogleFonts.orbitron(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: addSemester,
              icon: const Icon(Icons.add),
              label: Text('Add Semester', style: GoogleFonts.orbitron()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child:
                  semesters.isEmpty
                      ? Center(
                        child: Text(
                          'No semesters added',
                          style: GoogleFonts.orbitron(fontSize: 18),
                        ),
                      )
                      : ListView.builder(
                        itemCount: semesters.length,
                        itemBuilder: (context, index) {
                          final sem = semesters[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color:
                                  isDark
                                      ? Colors.grey[900]
                                      : Colors.deepPurple.shade50,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              title: Text(
                                'GPA: ${sem['gpa']}',
                                style: GoogleFonts.orbitron(),
                              ),
                              subtitle: Text(
                                'Credits: ${sem['credits']}',
                                style: GoogleFonts.orbitron(fontSize: 14),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    semesters.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: calculateCGPA,
              icon: const Icon(Icons.calculate),
              label: Text(
                'Calculate CGPA',
                style: GoogleFonts.orbitron(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 10,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your CGPA: ${cgpa.toStringAsFixed(2)}',
              style: GoogleFonts.orbitron(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
