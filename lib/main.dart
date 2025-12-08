import 'package:e_learning_application/bloc/auth/auth_bloc.dart';
import 'package:e_learning_application/bloc/font/font_bloc.dart';
import 'package:e_learning_application/bloc/font/font_state.dart';
import 'package:e_learning_application/core/theme/app_theme.dart';
import 'package:e_learning_application/routes/app_routes.dart';
import 'package:e_learning_application/routes/route_pages.dart';
import 'package:e_learning_application/services.dart/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await StorageService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FontBloc>(create: (context) => FontBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ],
      child: BlocBuilder<FontBloc, FontState>(
        builder: (context, fontState) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Learning App',
            theme: AppTheme.getLightTheme(fontState),
            themeMode: ThemeMode.light,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.onGenerateRoute,
            getPages: AppPages.pages,
          );
        },
      ),
    );
  }
}
