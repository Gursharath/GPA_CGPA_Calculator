import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';
import 'screens/semester_screen.dart';
import 'screens/target_gpa_screen.dart'; // ✅ import new screen

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.orbitronTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.orbitronTextTheme(ThemeData.dark().textTheme),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
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
        title: Text("FUTURE DECIDER :)", style: GoogleFonts.orbitron()),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedButton(
              icon: Icons.calculate,
              label: "GPA Calculator",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                  ),
            ),
            const SizedBox(height: 24),
            AnimatedButton(
              icon: Icons.school,
              label: "CGPA Calculator",
              onTap:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SemesterScreen()),
                  ),
            ),
            const SizedBox(height: 24),
            AnimatedButton(
              icon: Icons.trending_up,
              label: "Target GPA Calculator", // ✅ New button
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

class AnimatedButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const AnimatedButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 26),
      label: Text(label, style: GoogleFonts.orbitron(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
