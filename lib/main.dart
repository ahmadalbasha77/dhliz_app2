import 'package:dhliz_app/config/app_color.dart';
import 'package:dhliz_app/config/binding.dart';
import 'package:dhliz_app/config/messaging_config.dart';
import 'package:dhliz_app/controllers/app_controller.dart';
import 'package:dhliz_app/view/auth/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'config/shared_prefs_client.dart';
import 'config/translation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPrefsClient.init();

  await Firebase.initializeApp();
  MessagingConfig.init();
  FirebaseMessagingConfig.onMessage();

  runApp(const MyApp());
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
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
              centerTitle: true),
          colorScheme: ColorScheme.fromSeed(
              primary: AppColor.primaryColorScreen,
              seedColor: Colors.white,
              secondary: AppColor.primaryColorScreen),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
              color: AppColor.primaryColorScreen),
          useMaterial3: false,
        ),
        initialBinding: BindingQ(),
        translations: Translation(),
        locale: Locale(sharedPrefsClient.language),
        fallbackLocale: const Locale('en'),
        home: const SplashScreen(),
      ),
    );
  }
}
