import 'package:isar/isar.dart';

//Run the command to generate file: dart run build_runner build
part 'habit.g.dart';

@Collection()
class Habit {
  //Habit ID
  Id id = Isar.autoIncrement;

  //Habit name
  late String name;

  //Completed days
  List<DateTime> completedDays = [
    //DateTime(YY, MM, DD)
  ];
}
