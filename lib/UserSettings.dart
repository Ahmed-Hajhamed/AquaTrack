// UserSettings.dart
class UserSettings {
  int age;
  String gender;
  bool isAthlete;
  double height; // in cm
  double weight; // in kg
  String levelOfActivity; // 'Low', 'Moderate', 'High'
  bool useRecommendedGoal; // new
  double dailyGoal; // custom goal or calculated value

  UserSettings({
    required this.age,
    required this.gender,
    required this.isAthlete,
    required this.height,
    required this.weight,
    required this.levelOfActivity,
    required this.useRecommendedGoal,
    required this.dailyGoal,
  });
}