import 'package:flutter/material.dart';
import 'package:gymapp/models/exercise.dart';
import 'package:gymapp/models/workout.dart';

class WorkoutData extends ChangeNotifier {
  /*
  WORKOUT DATA STRUCTURE

  - This overall list contains different workouts.
  - Each workout has a name and a list of exercises associated with it.
   */
  List<Workout> workoutList = [
    // Default workout with an initial exercise
    Workout(name: "Upper Body", exercises: [
      Exercise(name: "Bicep Curls", weight: "10", reps: "10", sets: "3"),
    ]),
    Workout(name: "Lower Body", exercises: [
      Exercise(name: "Squats", weight: "10", reps: "10", sets: "3"),
    ]),
  ];

  // Method to get the number of exercises in a specified workout by its name
  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  // Method to retrieve the complete list of workouts
  List<Workout> getWorkoutList() {
    return workoutList;
  }

  // Method to add a new workout with an empty list of exercises
  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to add a new exercise to a specified workout
  void addExercise(
    String workoutName,
    String exerciseName,
    String weight,
    String reps,
    String sets,
  ) {
    // Find the relevant workout by its name
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // Add the new exercise to the workout's exercise list
    relevantWorkout.exercises.add(Exercise(
      name: exerciseName,
      weight: weight,
      reps: reps,
      sets: sets,
    ));
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to toggle the completion status of a specified exercise within a workout
  void checkoffExercise(String workoutName, String exerciseName) {
    // Find the relevant workout and the corresponding exercise
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    // Toggle the completion status of the exercise
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to return the relevant workout object given a workout name
  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout = workoutList.firstWhere(
      (workout) => workout.name == workoutName,
    );
    return relevantWorkout;
  }

  // Method to return the relevant exercise object given a workout name and exercise name
  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    // Find the relevant workout first
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // Then find the relevant exercise within that workout
    Exercise relevantExercise = relevantWorkout.exercises.firstWhere(
      (exercise) => exercise.name == exerciseName,
    );
    return relevantExercise;
  }

  // Method to delete a workout by its name
  void deleteWorkout(String workoutName) {
    workoutList.removeWhere((workout) => workout.name == workoutName);
    notifyListeners(); // Notify listeners about state changes
  }

  // Method to delete an exercise from a specified workout
  void deleteExercise(String workoutName, String exerciseName) {
    // Find the relevant workout by its name
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    // Remove the exercise from the workout's exercise list
    relevantWorkout.exercises.removeWhere((exercise) => exercise.name == exerciseName);
    notifyListeners(); // Notify listeners about state changes
  }
}
