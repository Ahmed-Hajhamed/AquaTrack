import 'package:flutter/material.dart';
import 'UserSettings.dart';
import 'SettingsScreen.dart';

void main() {
  runApp(SmartWaterBottleApp());
}

class SmartWaterBottleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Water Bottle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double waterLevel = 250; 
  double dailyGoal = 2000; 
  UserSettings? userSettings;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Water Bottle'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () async {
              // Navigate to the Settings Screen
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );

              if (result != null) {
                setState(() {
                  userSettings = result;
                  dailyGoal = userSettings!.dailyGoal;
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Water Level: ${waterLevel.toStringAsFixed(0)} ml',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: waterLevel / dailyGoal,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              'Daily Goal: $dailyGoal ml',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  waterLevel = waterLevel + 50; // Simulate water intake
                });
              },
              child: Text('Add 50 ml'),
            ),
          ],
        ),
      ),
    );
  }
}
