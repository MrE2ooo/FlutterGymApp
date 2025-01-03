import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';

class ExerciseTile extends StatelessWidget {
  ExerciseTile(
      {super.key,
      required this.onCheckBoxChanged,
      required this.exerciseName,
      required this.weights,
      required this.reps,
      required this.sets,
      required this.isCompleted});
  final String exerciseName;
  final String weights;
  final String reps;
  final String sets;
  final bool isCompleted;
  void Function(bool?)? onCheckBoxChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListTile(
        title: Text(exerciseName),
        subtitle: Row(
          children: [
            // weight
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                  backgroundColor: Colors.white70, label: Text("$weights kg")),
            ),

            // reps
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                  backgroundColor: Colors.white70, label: Text("$reps reps")),
            ),
            // sets
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Chip(
                  backgroundColor: Colors.white70, label: Text("$sets sets")),
            )
          ],
        ),
        trailing: Checkbox(
          value: isCompleted,
          onChanged: (value) => onCheckBoxChanged!(value),
        ),
        //,
      ),
    );
  }
}
