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

class _WorkoutPageState extends State<WorkoutPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) {
        return Scaffold(
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

  void onCheckBoxChenged(
      BuildContext context, String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkoffExercise(workoutName, exerciseName);
  }
}
