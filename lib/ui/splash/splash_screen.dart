import 'dart:async';
import 'package:ecomm_352/ui/dashboard/home_page.dart';
import 'package:ecomm_352/ui/sign_up/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constants/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async{

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString("token");
      print("token: $token");

      String nextPageName = AppRoutes.SIGNUPPAGE;

      if(token!=null){
        nextPageName = AppRoutes.HOMEPAGE;
      }

      Navigator.pushReplacementNamed(context, nextPageName);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.asset(
              'assets/images/apnamall_logo.png',
              height: size.height * 0.25,
              fit: BoxFit.contain,
            ),*/
            // const CircularProgressIndicator(
            //   color: Color(0xffe78bbc),
            //   strokeWidth: 2.5,
            // ),
          ],
        ),
      ),
    );
  }
}
