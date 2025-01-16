import 'package:gymapp/models/exercise.dart';

class Workout {
  // ignore: prefer_typing_uninitialized_variables
  final name;
  final List<Exercise> exercises;

  Workout({required this.name, required this.exercises});
}
