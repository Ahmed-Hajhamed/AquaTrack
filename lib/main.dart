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
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false, // Remove debug banner
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double waterLevel = 0; // Start at 0
  double dailyGoal = 2000; // Default daily goal
  UserSettings? userSettings;

  bool useRecommendedGoal = true; // Track whether to use recommended goal

  @override
  void initState() {
    super.initState();
    // Initialize userSettings with default values
    userSettings = UserSettings(
      age: 25,
      gender: 'Male',
      isAthlete: false,
      height: 170,
      weight: 70,
      levelOfActivity: 'Moderate',
      useRecommendedGoal: true,
      dailyGoal: dailyGoal,
    );
    calculateRecommendedGoal();
  }

  // Updated calculateRecommendedGoal() including height
  void calculateRecommendedGoal() {
    // Convert height from cm to meters
    double heightInMeters = userSettings!.height / 100;

    // Calculate BMI
    double bmi = userSettings!.weight / (heightInMeters * heightInMeters);

    // Base intake based on gender
    double baseIntake = 2700; // Default for women
    if (userSettings!.gender == 'Male') {
      baseIntake = 3700;
    }

    // Adjust for BMI
    if (bmi >= 25) {
      baseIntake += 250; // Increase for higher BMI
    } else if (bmi < 18.5) {
      baseIntake -= 250; // Decrease for lower BMI
    }

    // Adjust for age
    if (userSettings!.age > 50) {
      baseIntake *= 0.9; // Decrease by 10% for seniors
    } else if (userSettings!.age < 19) {
      baseIntake *= 0.9; // Decrease by 10% for teenagers
    }

    // Adjust for activity level
    double activityMultiplier = 1.0; // Default for 'Moderate'
    if (userSettings!.levelOfActivity == 'Low') {
      activityMultiplier = 0.9; // 10% decrease
    } else if (userSettings!.levelOfActivity == 'High') {
      activityMultiplier = 1.1; // 10% increase
    }
    baseIntake *= activityMultiplier;

    // Adjust for athlete status
    if (userSettings!.isAthlete) {
      baseIntake += 500; // Add extra 500 ml for athletes
    }

    setState(() {
      dailyGoal = baseIntake;
    });
  }

  void showAdjustDailyGoalDialog() {
    double newDailyGoal = dailyGoal;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text("Set Daily Water Goal"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Adjust your daily water goal (ml):"),
                  SizedBox(height: 10),
                  Slider(
                    min: 1000,
                    max: 5000,
                    divisions: 40,
                    value: newDailyGoal,
                    label: '${newDailyGoal.toStringAsFixed(0)} ml',
                    onChanged: (value) {
                      setStateDialog(() {
                        newDailyGoal = value;
                      });
                    },
                  ),
                  Text('Goal: ${newDailyGoal.toStringAsFixed(0)} ml'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    setState(() {
                      dailyGoal = newDailyGoal;
                      userSettings!.dailyGoal = newDailyGoal;
                      waterLevel = 0; // Optionally reset water level
                    });
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate the progress percentage
    double progress = (waterLevel / dailyGoal).clamp(0.0, 1.0);

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
                  useRecommendedGoal = userSettings!.useRecommendedGoal;
                  if (useRecommendedGoal) {
                    calculateRecommendedGoal();
                  } else {
                    dailyGoal = userSettings!.dailyGoal;
                  }
                  waterLevel = 0; // Reset water level when settings change
                });
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // Use Expanded widgets for responsiveness
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Water Intake Card with Buttons
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Water Intake',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      color: Colors.blueAccent,
                      minHeight: 20,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${(progress * 100).toStringAsFixed(0)}% of Daily Goal',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    // Add/Subtract Water Intake Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              waterLevel -= 50; // Subtract 50 ml
                              if (waterLevel < 0) {
                                waterLevel = 0; // Minimum of 0
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            '-50 ml',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              waterLevel += 50; // Add 50 ml
                              if (waterLevel > dailyGoal) {
                                waterLevel = dailyGoal; // Cap at daily goal
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            '+50 ml',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Display Daily Goal and Current Water Level
            Text(
              'Daily Goal: ${dailyGoal.toStringAsFixed(0)} ml',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Consumed: ${waterLevel.toStringAsFixed(0)} ml',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Toggle between recommended and custom goal
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Use Recommended Goal'),
                Switch(
                  value: useRecommendedGoal,
                  onChanged: (value) {
                    setState(() {
                      useRecommendedGoal = value;
                      userSettings!.useRecommendedGoal = value;
                      if (useRecommendedGoal) {
                        calculateRecommendedGoal();
                      } else {
                        dailyGoal = userSettings!.dailyGoal;
                      }
                    });
                  },
                ),
              ],
            ),
            if (!useRecommendedGoal) ...[
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Show a dialog to adjust daily goal
                    showAdjustDailyGoalDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    'Adjust Daily Goal',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 10),
            ],
            Spacer(),
            // Additional UI elements can be added here
          ],
        ),
      ),
    );
  }
}