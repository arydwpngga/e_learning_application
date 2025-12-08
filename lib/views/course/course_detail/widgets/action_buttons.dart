import 'package:e_learning_application/models/course.dart';
import 'package:e_learning_application/services.dart/dummy_data_service.dart';
import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final Course course;

  const ActionButtons({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              if (course.isPremium &&
                  !DummyDataService.isCourseUnlocked(course.id)) {
                // navigate to payment screen if the course is premium and not purchased
              } else {
                // navigate to first lesson if course is free of already purchased
              }
            },
            label: const Text('Start Learning'),
            icon: const Icon(Icons.play_circle),
          ),
        ),
        // only show chat button if course is not premium or if it's unlocked
        if (!course.isPremium ||
            DummyDataService.isCourseUnlocked(course.id)) ...[
          const SizedBox(width: 16),
          IconButton(onPressed: () {
            // navigate to chat screen
          }, icon: const Icon(Icons.chat)),
        ],
      ],
    );
  }
}
