import 'package:e_learning_application/core/theme/app_colors.dart';
import 'package:e_learning_application/routes/app_routes.dart';
import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lesson_tile.dart';

class LessonsList extends StatelessWidget {
  final String courseId;
  final bool isUnlocked;
  final VoidCallback? onLessonComplete;

  const LessonsList({
    super.key,
    required this.courseId,
    required this.isUnlocked,
    this.onLessonComplete,
  });

  @override
  Widget build(BuildContext context) {
    final course = DummyDataService.getCourseById(courseId);

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: course.lessons.length,
      itemBuilder: (context, index) {
        final lesson = course.lessons[index];

        final isLocked =
            !lesson.isPreview &&
            index > 0 &&
            !DummyDataService.isLessonCompleted(
              courseId,
              course.lessons[index - 1].id,
            );

        return LessonTile(
          title: lesson.title,
          duration: '${lesson.duration} min',
          isCompleted: DummyDataService.isLessonCompleted(courseId, lesson.id),
          isLocked: isLocked,
          isUnlocked: isUnlocked,
          onTap: () async {
            if (course.isPremium && !isUnlocked) {
              Get.snackbar(
                'Premium Course',
                'Please purchase this course to access all lessons',
                snackPosition: SnackPosition.TOP,
                backgroundColor: AppColors.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
              return;
            }

            if (isLocked) {
              Get.snackbar(
                'Lesson Locked',
                'Please complete the previous lesson first',
                snackPosition: SnackPosition.TOP,
                backgroundColor: Colors.red,
                colorText: Colors.white,
                duration: const Duration(seconds: 2),
              );
              return;
            }

            final result = await Get.toNamed(
              AppRoutes.lesson.replaceAll(':id', lesson.id),
              parameters: {'courseId': courseId},
            );

            if (result == true) {
              onLessonComplete?.call();
            }
          },
        );
      },
    );
  }
}
