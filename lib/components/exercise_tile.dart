import 'package:flutter/material.dart';
import 'package:gymapp/components/CustomChip.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    super.key,
    required this.onCheckBoxChanged,
    required this.exerciseName,
    required this.weights,
    required this.reps,
    required this.sets,
    required this.isCompleted,
    required this.onDelete, // Add the onDelete parameter
  });

  final String exerciseName;
  final String weights;
  final String reps;
  final String sets;
  final bool isCompleted;
  final void Function(bool?)? onCheckBoxChanged;
  final VoidCallback? onDelete; // Function type for the onDelete callback

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        title: Text(
          exerciseName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF4dadf7),
          ),
        ),
        subtitle: Row(
          children: [
            // Weight
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomChip(label: "$weights kg"),
            ),
            // Reps
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomChip(label: "$reps reps"),
            ),
            // Sets
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomChip(label: "$sets sets"),
            ),
          ],
        ),
        trailing: Row(
          // Change to Row to include both Checkbox and Delete button
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: isCompleted,
              activeColor: const Color(0xFF4dadf7),
              onChanged: (value) => onCheckBoxChanged!(value),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete, // Call the onDelete function when pressed
            ),
          ],
        ),
      ),
    );
  }
}
