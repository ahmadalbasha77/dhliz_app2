import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../config/app_color.dart';
import '../controllers/main_controller.dart';
import '../widgets/src/custom_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _controller = MainController.to;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      builder: (controller) => CustomWidget(
        bottomNavigationBar: Container(
            decoration: BoxDecoration(color: AppColor.darkGray, boxShadow: [
              BoxShadow(
                offset: Offset(0, -6),
                spreadRadius: -13,
                blurRadius: 27,
                color: Color.fromRGBO(0, 0, 0, 0.4),
              )
            ]),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: GNav(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 10.h, bottom: 10.h),
                duration: const Duration(milliseconds: 100),
                gap: 5,
                backgroundColor: AppColor.darkGray,
                color: Colors.black26,
                tabs: [
                  GButton(
                    icon: Icons.home_filled,
                  ),
                  GButton(
                    icon: Icons.compare_arrows,
                  ),
                  GButton(
                    icon: Icons.notifications,
                  ),
                  GButton(
                    icon: Icons.account_circle,
                  ),
                ],
                selectedIndex: _controller.selectedIndex.value,
                onTabChange: (index) {
                  _controller.selectedIndex.value = index;
                  _controller.update();
                })),
        child: _controller.tabs.elementAt(_controller.selectedIndex.value),
      ),
    );
  }
}
