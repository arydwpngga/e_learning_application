import 'package:chewie/chewie.dart';
import 'package:e_learning_application/models/course.dart';
import 'package:e_learning_application/services/dummy_data_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

enum LessonCompletionResult { nextLesson, courseCompleted }

class LessonVideoController {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  final String lessonId;
  final ValueChanged<bool> onLoadingChanged;

  late VoidCallback _videoListener;

  LessonVideoController({
    required this.lessonId,
    required this.onLoadingChanged,
  });

  Future<void> initializeVideo({required String courseId}) async {
    try {
      onLoadingChanged(true);

      final course = DummyDataService.getCourseById(courseId);

      final lesson = course.lessons.firstWhere(
        (l) => l.id == lessonId,
        orElse: () => course.lessons.first,
      );

      videoPlayerController = VideoPlayerController.network(
        lesson.videoStreamUrl,
      );

      await videoPlayerController!.initialize();

      _videoListener = () => _onVideoProgressChanged(courseId);
      videoPlayerController!.addListener(_videoListener);

      chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: false,
        aspectRatio: 16 / 9,
      );

      onLoadingChanged(false);
    } catch (e) {
      debugPrint('Video init error: $e');
      onLoadingChanged(false);
    }
  }

  void _onVideoProgressChanged(String courseId) async {
    final controller = videoPlayerController;
    if (controller == null) return;

    final position = controller.value.position;
    final duration = controller.value.duration;

    if (duration.inSeconds == 0) return;

    if (position >= duration - const Duration(seconds: 1)) {
      controller.removeListener(_videoListener);
      await markLessonAsCompleted(courseId);
    }
  }

  Future<LessonCompletionResult> markLessonAsCompleted(String courseId) async {
    final course = DummyDataService.getCourseById(courseId);
    final lessonIndex = course.lessons.indexWhere((l) => l.id == lessonId);

    DummyDataService.updateLessonStatus(courseId, lessonId, isComplete: true);

    if (lessonIndex < course.lessons.length - 1) {
      DummyDataService.updateLessonStatus(
        courseId,
        course.lessons[lessonIndex + 1].id,
        isComplete: false,
      );
    }

    final isLastLesson = lessonIndex == course.lessons.length - 1;
    final allCompleted = DummyDataService.isCourseCompleted(courseId);

    return (isLastLesson && allCompleted)
        ? LessonCompletionResult.courseCompleted
        : LessonCompletionResult.nextLesson;
  }

  void dispose() {
    if (videoPlayerController != null) {
      videoPlayerController!.removeListener(_videoListener);
      videoPlayerController!.dispose();
    }
    chewieController?.dispose();
  }
}
