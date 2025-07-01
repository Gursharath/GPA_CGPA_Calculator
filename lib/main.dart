import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/semester_screen.dart';
import 'screens/target_gpa_screen.dart';
import 'widgets/animated_card.dart'; // ✅ import AnimatedCard

void main() {
  runApp(const GPAApp());
}

class GPAApp extends StatelessWidget {
  const GPAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPA & CGPA Calculator',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        textTheme: GoogleFonts.orbitronTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0F1C),
        textTheme: GoogleFonts.orbitronTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF112B3C),
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyanAccent,
          brightness: Brightness.dark,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const HomeMenu(),
    );
  }
}

class HomeMenu extends StatelessWidget {
  const HomeMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "🚀 FUTURE DECIDER",
          style: GoogleFonts.orbitron(fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            AnimatedCard(
              icon: Icons.calculate_outlined,
              title: "GPA Calculator",
              subtitle: "Semester-wise GPA with grades & credits",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
            ),
            const SizedBox(height: 24),
            AnimatedCard(
              icon: Icons.school_outlined,
              title: "CGPA Calculator",
              subtitle: "Calculate cumulative CGPA",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SemesterScreen()),
                  ),
            ),
            const SizedBox(height: 24),
            AnimatedCard(
              icon: Icons.trending_up_outlined,
              title: "Target GPA Predictor",
              subtitle: "Find GPA needed for your dream CGPA",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TargetGPAScreen()),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
