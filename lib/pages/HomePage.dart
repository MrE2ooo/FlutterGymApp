import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';
import 'package:gymapp/data/workout_data.dart';
import 'package:gymapp/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // Text controller
  final newWorkoutNameController = TextEditingController();

  // Create new Workout
  void createNewWorkout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New Workout"),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: const InputDecoration(hintText: "Enter workout name"),
        ),
        actions: [
          // Save button
          MaterialButton(
            onPressed: () => save(context), // Pass context here
            child: const Text("Save"),
          ),

          // Cancel button
          MaterialButton(
            onPressed: () {
              cancel(context); // Pass context here
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // Save workout
  void save(BuildContext context) {
    // Get workout name from text controller
    String newWorkoutName = newWorkoutNameController.text;

    // Add workout to workout data list
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);

    // Close the dialog after saving
    Navigator.of(context).pop();

    // Optionally clear the text field
    newWorkoutNameController.clear();
  }

  // Cancel
  void cancel(BuildContext context) {
    // Close the dialog without saving
    Navigator.of(context).pop();
  }

  // Go to new workout page
  void goToWorkoutPage(BuildContext context, String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPage(workoutName: workoutName)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.primaryColor,
            title: const Text(
              "Workout Tracker",
              style: TextStyle(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () => createNewWorkout(context), // Pass context here
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView.builder(
            itemCount: value.workoutList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(value.getWorkoutList()[index].name),
                trailing: IconButton(
                  onPressed: () => goToWorkoutPage(context, value.getWorkoutList()[index].name),
                  icon: const Icon(Icons.arrow_forward_ios), // Changed icon for clarity
                ),
              );
            },
          ),
        );
      },
    );
  }
}
