
import 'package:gymapp/dateTime/date_time.dart';
import 'package:gymapp/models/exercise.dart';
import 'package:gymapp/models/workout.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  // Reference to our Hive database box
  final _myBox = Hive.box("Workout_database1");

  // Check if any previous data exists in the box
  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("previous data does not exist");
      _myBox.put("Start_Date", todaysDateYYYYMMDD()); // Store the current date as the start date
      return false;
    } else {
      print("previous data does exist");
      return true;
    }
  }

  // Retrieve the start date as a formatted string (yyyymmdd)
  String getStartDate() {
    return _myBox.get("Start_Date");
  }

  // Save workout data to the Hive database
  void saveToDataBase(List<Workout> workouts) {
    // Convert workout objects into a list of strings for storage
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = covertObjectToExerciseList(workouts);
    
    // Check if any exercises have been completed today
    if (exerciseCompled(workouts)) {
      _myBox.put("COMPLENTION_STATUS_${todaysDateYYYYMMDD()}", 1); // Store completion status as 1 if any exercise completed
    } else {
      _myBox.put("COMPLENTION_STATUS_${todaysDateYYYYMMDD()}", 0); // Store completion status as 0 if no exercise completed
    }
    
    // Save the converted workout and exercise lists into the database
    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  // Read stored data from the database and return a list of Workout objects
  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = []; // Initialize an empty list to store workouts
    List<String> workoutNames = _myBox.get("WORKOUTS"); // Retrieve the list of workout names from the database
    final exerciseDetails = _myBox.get("EXERCISES"); // Retrieve the list of exercise details

    // Create Workout objects from the stored data
    for (int i = 0; i < workoutNames.length; i++) {
      // Initialize a list to hold exercises for each workout
      List<Exercise> exercisesInEachWorkout = [];
      for (int j = 0; j < exerciseDetails[i].length; j++) {
        // Create Exercise objects from the stored exercise details
        exercisesInEachWorkout.add(Exercise(
          name: exerciseDetails[i][j][0],
          weight: exerciseDetails[i][j][1],
          reps: exerciseDetails[i][j][2],
          sets: exerciseDetails[i][j][3],
          isCompleted: exerciseDetails[i][j][4] == "true", // Convert stored string to boolean
        ));
      }
      // Create the individual Workout from the name and its exercises
      Workout workout = Workout(name: workoutNames[i], exercises: exercisesInEachWorkout);
      // Add the created workout to the overall saved workouts list
      mySavedWorkouts.add(workout);
    }
    return mySavedWorkouts; // Return the list of saved workouts
  }

  // Retrieve the completion status for a specified date (yyyymmdd)
  int getComplionStatus(String yyyymmdd) {
    // Return the completion status (0 or 1); if not found, return 0
    int complentionStatus = _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
    return complentionStatus;
  }// Check if any exercises have been completed in the provided list of workouts
  bool exerciseCompled(List<Workout> workouts) {
    // Iterate through each workout
    for (var workout in workouts) {
      // Iterating through each exercise in the workout
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) { // If any exercise is marked as completed
          return true; // Return true if at least one completed
        }
      }
    }
    return false; // Return false if no exercises are completed
  }
}

// Converts a list of Workout objects into a simple list of workout names
List<String> convertObjectToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [];

  // Add each workout's name into the list
  for (int i = 0; i < workouts.length; i++) {
    workoutList.add(workouts[i].name);
  }
  return workoutList; // Return the list of workout names
}

// Converts the exercises within Workout objects into a format suitable for storage
List<List<List<String>>> covertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];
  // Iterate through each workout
  for (int i = 0; i < workouts.length; i++) {
    // Retrieve exercises from the current workout
    List<Exercise> exercisesInWorkout = workouts[i].exercises;

    List<List<String>> indivitualWorkout = [];

    // Iterate through each exercise in the current workout
    for (int j = 0; j < exercisesInWorkout.length; j++) {
      List<String> indivitualExercise = [];
      // Add exercise details to the list
      indivitualExercise.addAll([
        exercisesInWorkout[j].name, // Exercise name
        exercisesInWorkout[j].isCompleted.toString(), // Completed status as string
        exercisesInWorkout[j].reps, // Reps count
        exercisesInWorkout[j].sets, // Sets count
      ]);
      indivitualWorkout.add(indivitualExercise); // Add exercise details to the individual workout list
    }
    exerciseList.add(indivitualWorkout); // Add the individual workout's exercises to the overall exercise list
  }
  return exerciseList; // Return the list of exercise details
}
