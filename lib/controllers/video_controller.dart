import 'package:chewie/chewie.dart';
import 'package:e_learning_application/models/course.dart';
import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class LessonVideoController {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  final String lessonId;
  final VoidCallback onVideoCompleted;
  final Function(bool) onLoadingChanged;
  final Function(Course) onCertificateEarned;

  bool _isCompleted = false;

  LessonVideoController({
    required this.lessonId,
    required this.onLoadingChanged,
    required this.onCertificateEarned,
    required this.onVideoCompleted,
  });

  Future<void> initializeVideo() async {
    final courseId = Get.parameters['courseId'];
    if (courseId == null) return;

    final course = DummyDataService.getCourseById(courseId);

    final lesson = course.lessons.firstWhere((l) => l.id == lessonId);

    videoPlayerController = VideoPlayerController.network(
      lesson.videoStreamUrl,
    );

    await videoPlayerController!.initialize();
    videoPlayerController!.addListener(_videoListener);

    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: false,
      aspectRatio: 16 / 9,
    );

    onLoadingChanged(false);
  }

  void _videoListener() {
    final controller = videoPlayerController;
    if (controller == null || _isCompleted) return;

    final value = controller.value;
    if (!value.isInitialized) return;

    if (value.isCompleted) {
      _isCompleted = true;
      _handleLessonCompleted();
    }
  }

  void _handleLessonCompleted() {
    final courseId = Get.parameters['courseId'];
    if (courseId == null) return;

    final course = DummyDataService.getCourseById(courseId);
    final index = course.lessons.indexWhere((l) => l.id == lessonId);
    if (index == -1) return;

    DummyDataService.updateLessonStatus(courseId, lessonId, isComplete: true);

    if (index < course.lessons.length - 1) {
      DummyDataService.updateLessonStatus(
        courseId,
        course.lessons[index + 1].id,
        isComplete: false,
      );
    }

    final isLassLesson = index == course.lessons.length - 1;
    final allCompleted = DummyDataService.isCourseCompleted(courseId);

    if (isLassLesson && allCompleted) {
      onCertificateEarned(course);
    } else {
      onVideoCompleted();
    }
  }

  void dispose() {
    videoPlayerController?.removeListener(_videoListener);
    videoPlayerController?.dispose();
    chewieController?.dispose();
  }
}
