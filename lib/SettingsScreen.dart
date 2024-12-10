// settings_screen.dart
import 'package:flutter/material.dart';
import 'usersettings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int age = 25;
  String gender = 'Male';
  bool isAthlete = false;
  double dailyGoal = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Age input
            Text('Age', style: TextStyle(fontSize: 18)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  age = int.parse(value);
                });
              },
              decoration: InputDecoration(hintText: 'Enter your age'),
            ),
            // Gender input (Radio Buttons)
            SizedBox(height: 20),
            Text('Gender', style: TextStyle(fontSize: 18)),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Male'),
                Radio<String>(
                  value: 'Female',
                  groupValue: gender,
                  onChanged: (value) {
                    setState(() {
                      gender = value!;
                    });
                  },
                ),
                Text('Female'),
              ],
            ),
            // Athlete status (Switch)
            SizedBox(height: 20),
            Text('Are you an athlete?', style: TextStyle(fontSize: 18)),
            Switch(
              value: isAthlete,
              onChanged: (value) {
                setState(() {
                  isAthlete = value;
                });
              },
            ),
            // Daily water goal input (Slider)
            SizedBox(height: 20),
            Text('Daily Water Goal (ml)', style: TextStyle(fontSize: 18)),
            Slider(
              min: 1000,
              max: 5000,
              value: dailyGoal,
              onChanged: (value) {
                setState(() {
                  dailyGoal = value;
                });
              },
            ),
            Text('Goal: ${dailyGoal.toStringAsFixed(0)} ml'),
            // Save button
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Return the settings to the previous screen
                final userSettings = UserSettings(
                  age: age,
                  gender: gender,
                  isAthlete: isAthlete,
                  dailyGoal: dailyGoal,
                );
                Navigator.pop(context, userSettings);
              },
              child: Text('Save Settings'),
            ),
          ],
        ),
      ),
    );
  }
}
