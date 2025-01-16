import 'package:flutter/material.dart';

class WorkoutTrackerListTile extends StatelessWidget {
  final String workoutName;
  final VoidCallback onDelete;
  final VoidCallback onNavigate;

  const WorkoutTrackerListTile({
    super.key,
    required this.workoutName,
    required this.onDelete,
    required this.onNavigate,
  });

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
      child:ListTile(
      title: Text(workoutName),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onNavigate,
            icon: const Icon(Icons.arrow_forward_ios),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
    ) ,
    )
     ;
  }
}
