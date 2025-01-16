import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';
import 'package:gymapp/components/CustomAppBar.dart';
import 'package:gymapp/components/exercise_tile.dart';
import 'package:gymapp/data/workout_data.dart';
import 'package:provider/provider.dart';

class WorkoutPage extends StatefulWidget {
  const WorkoutPage({super.key, required this.workoutName});
  final String workoutName;

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

// Text controllers
final exerciseNameController = TextEditingController();
final weightController = TextEditingController();
final repsController = TextEditingController();
final setsController = TextEditingController();

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: createNewExercise,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          appBar:CustomAppBar(title: widget.workoutName),
          body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
            itemBuilder: (context, index) {
              final exercise = value.getRelevantWorkout(widget.workoutName).exercises[index];
              return ExerciseTile(
                exerciseName: exercise.name,
                weights: exercise.weight,
                reps: exercise.reps,
                sets: exercise.sets,
                isCompleted: exercise.isCompleted,
                onCheckBoxChanged: (val) => onCheckBoxChenged(
                    context,
                    widget.workoutName,
                    exercise.name),
                // Add a delete button to each exercise
                onDelete: () => confirmDeleteExercise(context, exercise.name), // Assuming ExerciseTile supports this
              );
            },
          ),
        );
      },
    );
  }

  // Check the completed exercise box
  void onCheckBoxChenged(
      BuildContext context, String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkoffExercise(workoutName, exerciseName);
  }

  // Confirm delete exercise
  void confirmDeleteExercise(BuildContext context, String exerciseName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Exercise"),
        content: const Text("Are you sure you want to delete this exercise?"),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<WorkoutData>(context, listen: false)
                  .deleteExercise(widget.workoutName, exerciseName);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("Yes, Delete"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Close the dialog
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // clear the controllers
  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    setsController.clear();
    repsController.clear();
  }

  // save exercise
  void save() {
    // Get exercise name from text controller
    String newExerciseName = exerciseNameController.text;

    // Get exercise details from text controllers
    String newExerciseWeight = weightController.text;
    String newExerciseSets = setsController.text;
    String newExerciseReps = repsController.text;

    // Check if the workout name is not empty
    if (newExerciseName.isNotEmpty &&
        newExerciseWeight.isNotEmpty &&
        newExerciseReps.isNotEmpty &&
        newExerciseSets.isNotEmpty) {
      // Add exercise to workout
      Provider.of<WorkoutData>(context, listen: false).addExercise(
          widget.workoutName,
          newExerciseName,
          newExerciseWeight,
          newExerciseReps,
          newExerciseSets);

      // Clear the controllers after saving
      clear();

      // Close the dialog after saving
      Navigator.of(context).pop();
    } else {
      // Show an error message if the name is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill out all fields.')),
      );
    }
  }

  void cancel(BuildContext context) {
    // Close the dialog without saving
    Navigator.of(context).pop();
    clear();
  }

  // Create new exercise
  void createNewExercise() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add a new Exercise"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Name
                TextField(
                  controller: exerciseNameController,
                  decoration: const InputDecoration(labelText: "Exercise Name"),
                ),
                // Weight
                TextField(
                  controller: weightController,
                  decoration: const InputDecoration(labelText: "Weight"),
                  keyboardType: TextInputType.number,
                ),
                // Reps
                TextField(
                  controller: repsController,
                  decoration: const InputDecoration(labelText: "Reps"),
                  keyboardType: TextInputType.number,
                ),
                // Sets
                TextField(
                  controller: setsController,
                  decoration: const InputDecoration(labelText: "Sets"),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            // save button
            MaterialButton(
              onPressed: () => save(), // Pass context here
              child: const Text("Save"),
            ),

            //  cancel
            MaterialButton(
              onPressed: () {
                cancel(context); // Pass context here
              },
              child: const Text("Cancel"),
            ),
          ],
        );
      },
    );
  }
}
