import 'package:flutter/material.dart';
import 'package:movies_app/modules/layout/layout.dart';
import 'package:movies_app/modules/layout/pages/edite_profile/widgets/edite_profile.dart';
import 'package:movies_app/modules/login/pages/forget_password.dart';
import 'package:movies_app/modules/login/pages/login_view.dart';
import 'package:movies_app/modules/login/pages/register_view.dart';
import 'package:movies_app/modules/onborarding/on_boarding_screen.dart';
import 'package:movies_app/modules/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/theme/app_theme_manager.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final bool isFirstTime = prefs.getBool('firstTime') ?? true;

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppThemeManager.lightTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstTime
          ? OnBoardingScreen.routeName
          : SplashView.routeName,
      routes: {
        SplashView.routeName: (context) => const SplashView(),
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        LoginView.routeName: (context) => const LoginView(),
        RegisterView.routeName: (context) => const RegisterView(),
        ForgetPassword.routeName: (context) => const ForgetPassword(),
        Layout.routeName: (context) => const Layout(),
        EditeProfile.routeName: (context) => const EditeProfile(),
      },
    );
  }
}
