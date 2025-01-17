import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';
import 'package:gymapp/components/CustomAppBar.dart';
import 'package:gymapp/components/WorkoutTrackerListTile.dart';
import 'package:gymapp/data/workout_data.dart';
import 'package:gymapp/pages/workout_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  final newWorkoutNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newWorkoutNameController.dispose();
    super.dispose();
  }

  void createNewWorkout(BuildContext context) {
    showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: AppColors.backgroundColor, // Applying background color
    title: const Text(
      "Create New Workout",
      style: TextStyle(
        color: AppColors.primaryColor, // Applying primary color to title
      ),
    ),
    content: TextField(
      controller: newWorkoutNameController,
      decoration: InputDecoration(
        hintText: "Enter workout name",
        hintStyle: TextStyle(color: AppColors.primaryColor.withOpacity(0.6)), // Applying primary color with opacity to hint text
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor), // Applying primary color to underline
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.primaryColor), // Applying primary color to focused underline
        ),
      ),
    ),
    actions: [
      MaterialButton(
        onPressed: () => save(context),
        color: AppColors.customChipColor, // Applying custom chip color to button
        child: const Text(
          "Save",
          style: TextStyle(color: AppColors.customWhite), // Applying custom white color to button text
        ),
      ),
      MaterialButton(
        onPressed: () => cancel(context),
        color: AppColors.deleteColor, // Applying delete color to button
        child: const Text(
          "Cancel",
          style: TextStyle(color: AppColors.customWhite), // Applying custom white color to button text
        ),
      ),
    ],
  ),
);

  }

  void save(BuildContext context) {
    String newWorkoutName = newWorkoutNameController.text;

    if (newWorkoutName.isNotEmpty) {
      Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
      Navigator.of(context).pop();
      newWorkoutNameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a workout name.')),
      );
    }
  }

  void cancel(BuildContext context) {
    Navigator.of(context).pop();
    newWorkoutNameController.clear();
  }

  void goToWorkoutPage(BuildContext context, String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WorkoutPage(workoutName: workoutName)),
    );
  }

  void confirmDeleteWorkout(BuildContext context, String workoutName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Workout"),
        content: const Text("Are you sure you want to delete this workout?"),
        actions: [
          TextButton(
            onPressed: () {
              Provider.of<WorkoutData>(context, listen: false).deleteWorkout(workoutName);
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

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, workoutData, child) {
        return Scaffold(
          appBar: const CustomAppBar(title: "Workout Tracker"),
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () => createNewWorkout(context),
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: ListView.builder(
            itemCount: workoutData.workoutList.length,
            itemBuilder: (context, index) {
              String workoutName = workoutData.getWorkoutList()[index].name;
              return WorkoutTrackerListTile(
                workoutName: workoutName,
                onNavigate: () => goToWorkoutPage(context, workoutName),
                onDelete: () => confirmDeleteWorkout(context, workoutName),
              );
            },
          ),
        );
      },
    );
  }
}
