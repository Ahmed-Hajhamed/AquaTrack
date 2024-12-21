// SettingsScreen.dart
import 'package:flutter/material.dart';
import 'UserSettings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int age = 25;
  String gender = 'Male';
  bool isAthlete = false;
  double height = 170; // in cm
  double weight = 70; // in kg
  String levelOfActivity = 'Moderate'; // 'Low', 'Moderate', 'High'
  bool useRecommendedGoal = true;
  double dailyGoal = 2000; // Custom daily goal if not using recommended

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Settings'),
      ),
      body: SingleChildScrollView( // Added to prevent overflow
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
                  age = int.tryParse(value) ?? age;
                });
              },
              decoration: InputDecoration(hintText: 'Enter your age'),
            ),
            SizedBox(height: 20),

            // Gender input
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
            SizedBox(height: 20),

            // Athlete status
            Text('Are you an athlete?', style: TextStyle(fontSize: 18)),
            SwitchListTile(
              title: Text(isAthlete ? 'Yes' : 'No'),
              value: isAthlete,
              onChanged: (value) {
                setState(() {
                  isAthlete = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Height input
            Text('Height (cm)', style: TextStyle(fontSize: 18)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  height = double.tryParse(value) ?? height;
                });
              },
              decoration: InputDecoration(hintText: 'Enter your height in cm'),
            ),
            SizedBox(height: 20),

            // Weight input
            Text('Weight (kg)', style: TextStyle(fontSize: 18)),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  weight = double.tryParse(value) ?? weight;
                });
              },
              decoration: InputDecoration(hintText: 'Enter your weight in kg'),
            ),
            SizedBox(height: 20),

            // Level of Activity
            Text('Level of Activity', style: TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: levelOfActivity,
              onChanged: (String? newValue) {
                setState(() {
                  levelOfActivity = newValue!;
                });
              },
              items: <String>['Low', 'Moderate', 'High']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),

            // Use Recommended Goal
            Text('Use Recommended Water Goal?', style: TextStyle(fontSize: 18)),
            SwitchListTile(
              title: Text(useRecommendedGoal ? 'Yes' : 'No'),
              value: useRecommendedGoal,
              onChanged: (bool value) {
                setState(() {
                  useRecommendedGoal = value;
                });
              },
            ),
            SizedBox(height: 20),

            // Custom Daily Water Goal Input (if not using recommended)
            if (!useRecommendedGoal) ...[
              Text('Set Your Daily Water Goal (ml)', style: TextStyle(fontSize: 18)),
              Slider(
                min: 1000,
                max: 5000,
                divisions: 40,
                value: dailyGoal,
                label: '${dailyGoal.toStringAsFixed(0)} ml',
                onChanged: (value) {
                  setState(() {
                    dailyGoal = value;
                  });
                },
              ),
              Text('Goal: ${dailyGoal.toStringAsFixed(0)} ml'),
              SizedBox(height: 20),
            ],

            // Save button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Compute the recommended daily goal if useRecommendedGoal is true
                  double finalDailyGoal = dailyGoal;
                  if (useRecommendedGoal) {
                    // Implement the formula here
                    double activityMultiplier = 35; // default for 'Moderate'
                    if (levelOfActivity == 'Low') {
                      activityMultiplier = 30;
                    } else if (levelOfActivity == 'High') {
                      activityMultiplier = 40;
                    }
                    finalDailyGoal = weight * activityMultiplier; // in ml

                    // Adjust for athlete status
                    if (isAthlete) {
                      finalDailyGoal += 500; // Add extra 500 ml for athletes
                    }
                  }
                  // Return the settings to the previous screen
                  final userSettings = UserSettings(
                    age: age,
                    gender: gender,
                    isAthlete: isAthlete,
                    height: height,
                    weight: weight,
                    levelOfActivity: levelOfActivity,
                    useRecommendedGoal: useRecommendedGoal,
                    dailyGoal: finalDailyGoal,
                  );
                  Navigator.pop(context, userSettings);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Save Settings',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}