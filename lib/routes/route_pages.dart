import 'package:e_learning_application/main_screen.dart';
import 'package:e_learning_application/routes/app_routes.dart';
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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onboarding, page: () => const OnboardingScreen()),
    GetPage(name: AppRoutes.login, page: () => const LoginScreen()),
    GetPage(name: AppRoutes.register, page: () => const RegisterScreen()),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(
        initialIndex: Get.arguments is Map<String, dynamic>
            ? Get.arguments['initialIndex'] as int?
            : null,
      ),
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(
      name: AppRoutes.courseList,
      page: () => CourseListScreen(
        categoryId: Get.arguments?['category'] as String?,
        categoryName: Get.arguments?['categoryName'] as String?,
      ),
    ),

    GetPage(
      name: '/course/:id',
      page: () => CourseDetailScreen(courseId: Get.parameters['id'] ?? ''),
    ),

    GetPage(name: AppRoutes.quizList, page: () => const QuizListScreen()),

    GetPage(
      name: AppRoutes.lesson,
      page: () => LessonScreen(lessonId: Get.parameters['id'] ?? ''),
    ),

    GetPage(
      name: AppRoutes.payment,
      page: () => PaymentScreen(
        courseId: Get.arguments['courseId'] as String,
        courseName: Get.arguments['courseName'] as String,
        price: Get.arguments['price'] as double,
      ),
    ),
    
    GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
    GetPage(name: AppRoutes.teacherHome, page: () => const TeacherHomeScreen()),
  ];
}
