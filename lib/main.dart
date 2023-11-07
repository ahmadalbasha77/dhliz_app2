import 'package:dhliz_app/config/binding.dart';
import 'package:dhliz_app/controllers/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/shared_prefs_client.dart';
import 'config/translation.dart';
import 'view/auth/splash_screen.dart';

void main() async {
  await sharedPrefsClient.init();
  // بعدين
  // WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized.
  // await Firebase.initializeApp(); // Initialize Firebase.

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppController _controller = AppController.to;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: BindingQ(),
        translations: Translation(),
        locale: Locale(sharedPrefsClient.language),
        fallbackLocale: const Locale('en'),
        home: SplashScreen(),
      ),
    );
  }
}
