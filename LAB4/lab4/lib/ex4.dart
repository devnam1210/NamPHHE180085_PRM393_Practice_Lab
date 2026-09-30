import 'package:flutter/material.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}
class _AppStructureDemoState extends State<AppStructureDemo> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Exercise 4 – App Structure'),
          actions: [
            const Center(child: Text("Dark")),
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ],
        ),

        body: const Center(
          child: Text('This is a simple screen with theme toggle.'),
        ),
        
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("FAB Pressed");
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}