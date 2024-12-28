import 'package:flutter/material.dart';
import 'package:habit_tracker/models/app_settings.dart';
import 'package:habit_tracker/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  //Initialising the database
  static Future<void> initialise() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
      directory: dir.path,
    );
  }

  //Saving the initial date of the app
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //Fetch the initial date
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  //Habit list
  final List<Habit> currentHabits = [];

  //Creating a new Habit
  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar
        .writeTxn(() => isar.habits.put(newHabit)); //Saved into the database
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> fetchedHabits = await isar.habits.where().findAll();
    currentHabits
      ..clear()
      ..addAll(fetchedHabits);
    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(
        () async {
          //Habit completed += current date to completed days
          if (isCompleted && !habit.completedDays.contains(DateTime.now())) {
            final today = DateTime.now();
            habit.completedDays.add(
              DateTime(
                today.year,
                today.month,
                today.day,
              ),
            );
          }

          //Habit incomplete -= current date from completed days
          else {
            habit.completedDays.removeWhere(
              (date) =>
                  date.year == DateTime.now().year &&
                  date.month == DateTime.now().month &&
                  date.day == DateTime.now().day,
            );
          }
          await isar.habits.put(habit);
        },
      );
    }
    await readHabits();
  }

  //Updating the habit name
  Future<void> updateHabitName(int id, String newName) async {
    final habit = await isar.habits.get(id);
    if (habit != null) {
      await isar.writeTxn(
        () async {
          habit.name = newName;
          await isar.habits.put(habit);
        },
      );
    }
    await readHabits();
  }

  //Deleting the habit
  Future<void> deleteHabit(int id) async {
    await isar.writeTxn(
      () async {
        await isar.habits.delete(id);
      },
    );
    await readHabits();
  }
}
