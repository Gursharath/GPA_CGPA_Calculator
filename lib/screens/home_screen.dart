import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../grade_to_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> subjects = [];
  double gpa = 0.0;

  final subjectController = TextEditingController();

  void addSubject() {
    if (subjectController.text.isEmpty) return;

    setState(() {
      subjects.add({
        'name': subjectController.text,
        'grade': 'S',
        'credits': 1.0,
      });
      subjectController.clear();
    });
  }

  void calculateGPA() {
    double totalPoints = 0;
    double totalCredits = 0;

    for (var sub in subjects) {
      final grade = sub['grade'];
      final credits = sub['credits'];
      final points = gradeToPoint[grade] ?? 0;

      totalPoints += points * credits;
      totalCredits += credits;
    }

    setState(() {
      gpa = totalCredits > 0 ? totalPoints / totalCredits : 0.0;
    });
  }

  void reset() {
    setState(() {
      subjects.clear();
      gpa = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator', style: GoogleFonts.orbitron()),
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
              controller: subjectController,
              style: GoogleFonts.orbitron(),
              decoration: InputDecoration(
                labelText: 'Subject Name',
                labelStyle: GoogleFonts.orbitron(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: addSubject,
                    icon: const Icon(Icons.add),
                    label: Text('Add Subject', style: GoogleFonts.orbitron()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontSize: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 6,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child:
                  subjects.isEmpty
                      ? Center(
                        child: Text(
                          'No subjects added',
                          style: GoogleFonts.orbitron(fontSize: 18),
                        ),
                      )
                      : ListView.builder(
                        itemCount: subjects.length,
                        itemBuilder: (context, index) {
                          final subject = subjects[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn,
                            margin: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isDark
                                          ? Colors.black.withOpacity(0.4)
                                          : Colors.grey.withOpacity(0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              color:
                                  isDark
                                      ? Colors.grey[900]
                                      : Colors.deepPurple.shade50,
                            ),
                            child: ListTile(
                              title: Text(
                                subject['name'],
                                style: GoogleFonts.orbitron(),
                              ),
                              subtitle: Row(
                                children: [
                                  Text(
                                    "Grade: ",
                                    style: GoogleFonts.orbitron(),
                                  ),
                                  DropdownButton<String>(
                                    value: subject['grade'],
                                    dropdownColor:
                                        isDark
                                            ? Colors.grey[850]
                                            : Colors.white,
                                    style: GoogleFonts.orbitron(),
                                    items:
                                        gradeList
                                            .map(
                                              (grade) => DropdownMenuItem(
                                                value: grade,
                                                child: Text(grade),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        subject['grade'] = val!;
                                      });
                                    },
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    "Credits: ",
                                    style: GoogleFonts.orbitron(),
                                  ),
                                  DropdownButton<double>(
                                    value: subject['credits'],
                                    dropdownColor:
                                        isDark
                                            ? Colors.grey[850]
                                            : Colors.white,
                                    style: GoogleFonts.orbitron(),
                                    items:
                                        [1.0, 1.5, 2.0, 3.0, 4.0, 5.0, 20.0]
                                            .map(
                                              (credit) => DropdownMenuItem(
                                                value: credit,
                                                child: Text(credit.toString()),
                                              ),
                                            )
                                            .toList(),
                                    onChanged: (val) {
                                      setState(() {
                                        subject['credits'] = val!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setState(() {
                                    subjects.removeAt(index);
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
              onPressed: calculateGPA,
              icon: const Icon(Icons.calculate),
              label: Text(
                'Calculate GPA',
                style: GoogleFonts.orbitron(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 8,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your GPA: ${gpa.toStringAsFixed(2)}',
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
