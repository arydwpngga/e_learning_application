import 'package:e_learning_application/main_screen.dart';
import 'package:e_learning_application/views/auth/forgot_password.dart';
import 'package:e_learning_application/views/auth/login_screen.dart';
import 'package:e_learning_application/views/auth/register_screen.dart';
import 'package:e_learning_application/views/course/course_detail/course_detail_screen.dart';
import 'package:e_learning_application/views/course/course_list/course_list_screen.dart';
import 'package:e_learning_application/views/course/lesson_screen/lesson_screen.dart';
import 'package:e_learning_application/views/course/payment/payment_screen.dart';
import 'package:e_learning_application/views/home/home_screen.dart';
import 'package:e_learning_application/views/onboarding/onboarding_screen.dart';
import 'package:e_learning_application/views/profile/profile_screen.dart';
import 'package:e_learning_application/views/quiz/quiz_list/quiz_list_screen.dart';
import 'package:e_learning_application/views/splash/splash_screen.dart';
import 'package:e_learning_application/views/teacher/teacher_home_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  // main
  static const String main = '/main';

  // auth
  static const String splash = '/splash';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // course routes
  static const String courseList = '/course';
  static const String courseDetail = '/course/:id';
  static const String payment = '/payment';
  static const String lesson = '/lesson/:id';

  // quiz routes
  static const String quizList = '/quizzes';

  // profile routes
  static const String profile = '/profile';

  // user
  static const String home = '/home';

  // teacher
  static const String teacherHome = '/teacher-home';

  static Route<dynamic> onGenerateRoute(RouteSettings setting) {
    switch (setting.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case main:
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            initialIndex: setting.arguments is Map
                ? (setting.arguments as Map<String, dynamic>)['initialIndex']
                      as int?
                : null,
          ),
        );

      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());

      case teacherHome:
        return MaterialPageRoute(builder: (_) => const TeacherHomeScreen());

      case courseList:
        final args = setting.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CourseListScreen(
            categoryId: args?['category'] as String?,
            categoryName: args?['categoryName'] as String?,
          ),
        );

      case courseDetail:
        String courseId;
        if (setting.arguments != null) {
          courseId = setting.arguments as String;
        } else {
          final uri = Uri.parse(setting.name ?? '');
          courseId = uri.pathSegments.last;
        }
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(courseId: courseId),
        );

      case quizList:
        return MaterialPageRoute(builder: (_) => const QuizListScreen());

      case lesson:
        final lessonId = setting.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => LessonScreen(
            lessonId: lessonId ?? '',
          ),
        );

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case payment:
        final args = setting.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            courseId: args['courseId'] ?? '',
            courseName: args['courseName'] ?? '',
            price: args['price'] ?? 0.0,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found!'))),
        );
    }
  }
}
