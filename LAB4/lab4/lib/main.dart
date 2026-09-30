import 'package:flutter/material.dart';
import 'package:lab4/ex1.dart';
import 'package:lab4/ex2.dart';
import 'package:lab4/ex3.dart';
import 'package:lab4/ex4.dart';
import 'package:lab4/ex5.dart';

void main() {
  runApp(const Lab4MenuApp());
}

class Lab4MenuApp extends StatelessWidget {
  const Lab4MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainMenuScreen(),
    );
  }
}

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4 – Flutter UI Fundament...',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildMenuCard(
            context,
            title: 'Exercise 1 – Core Widgets Demo',
            targetScreen: const CoreWidgetsDemo(),
          ),

          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            title: 'Exercise 2 – Input Controls Demo',
            targetScreen: const InputControlsDemo(),
          ),

          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            title: 'Exercise 3 – Layout Demo',
            targetScreen: const LayoutDemoScreen(),
          ),

          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            title: 'Exercise 4 – App Structure & Theme',
            targetScreen: const AppStructureDemo(),
          ),

          const SizedBox(height: 12),
          _buildMenuCard(
            context,
            title: 'Exercise 5 – Common UI Fixes',
            targetScreen: const CommonUIFixes(),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required Widget targetScreen}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F7), // Màu xám nhạt như hình mẫu
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 0.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),
            // Mũi tên điều hướng bên phải
            const Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}

