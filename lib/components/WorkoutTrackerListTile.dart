import 'package:flutter/material.dart';
import 'package:gymapp/colors.dart';

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
        color: AppColors.customWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadowColor,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child:ListTile(
      title: Text(workoutName ,style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onNavigate,
            icon: const Icon(Icons.arrow_forward_ios,color: AppColors.primaryColor,),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(Icons.delete,color: AppColors.deleteColor,),
          ),
        ],
      ),
    ) ,
    )
     ;
  }
}
