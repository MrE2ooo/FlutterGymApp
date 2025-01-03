import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';
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
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: Text(widget.workoutName,
                style: const TextStyle(color: Colors.white)),
          ),
          body: ListView.builder(
            itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
            itemBuilder: (context, index) {
              return ExerciseTile(
                exerciseName: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name,
                weights: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .weight,
                reps: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .reps,
                sets: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .sets,
                isCompleted: value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .isCompleted,
                onCheckBoxChanged: (val) => onCheckBoxChenged(
                    context,
                    widget.workoutName,
                    value
                        .getRelevantWorkout(widget.workoutName)
                        .exercises[index]
                        .name),
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
