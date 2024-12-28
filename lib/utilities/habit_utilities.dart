import 'package:habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any(
    (date) =>
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day,
  );
}

//Heatmap dataset
Map<DateTime, int> prepHeatMapDatabase(List<Habit> habits) {
  Map<DateTime, int> dataset = {};

  for (var habit in habits) {
    for (var date in habit.completedDays) {
      final normalisedDate = DateTime(date.year, date.month, date.day);
      if (dataset.containsKey(normalisedDate)) {
        dataset[normalisedDate] = dataset[normalisedDate]! + 1;
      } else {
        dataset[normalisedDate] = 1;
      }
    }
  }
  return dataset;
}
