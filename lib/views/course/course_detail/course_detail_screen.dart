import 'package:e_learning_application/core/theme/app_colors.dart';
import 'package:e_learning_application/routes/app_routes.dart';
import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:e_learning_application/views/course/course_detail/widgets/action_buttons.dart';
import 'package:e_learning_application/views/course/course_detail/widgets/course_detail_app_bar.dart';
import 'package:e_learning_application/views/course/course_detail/widgets/course_info_card.dart';
import 'package:e_learning_application/views/course/course_detail/widgets/lessons_list.dart';
import 'package:e_learning_application/views/course/course_detail/widgets/reviews_section.dart';
import 'package:e_learning_application/views/course/lesson_screen/lesson_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  String? _activeLessonId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final courseId = Get.parameters['id'] ?? widget.courseId;
    final course = DummyDataService.getCourseById(courseId);

    final isUnlocked = DummyDataService.isCourseUnlocked(courseId);
    final isCompleted = DummyDataService.isCourseCompleted(courseId);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CourseDetailAppBar(imageUrl: course.imageUrl),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        course.rating.toString(),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '(${course.reviewCount} reviews)',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        '\$${course.price}',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.description,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  CourseInfoCard(course: course),
                  const SizedBox(height: 24),
                  Text(
                    'Course Content',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  LessonsList(
                    courseId: courseId,
                    isUnlocked: isUnlocked,
                    activeLessonId: _activeLessonId,
                    onLessonTap: (lessonId) async {
                      setState(() {
                        _activeLessonId = lessonId;
                      });

                      final result = await Get.toNamed(
                        AppRoutes.lesson.replaceAll(':id', lessonId),
                        parameters: {'courseId': courseId},
                      );

                      if (result is String) {
                        setState(() {
                          _activeLessonId = result;
                        });
                      }
                      setState(() {});
                    },
                  ),

                  const SizedBox(height: 16),
                  ReviewsSection(courseId: courseId),
                  ActionButtons(course: course),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: course.isPremium && !isUnlocked
          ? Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.payment,
                    arguments: {
                      'courseId': courseId,
                      'courseName': course.title,
                      'price': course.price,
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.all(16),
                ),
                child: Text('Buy Now for \$${course.price}'),
              ),
            )
          : null,
    );
  }
}
