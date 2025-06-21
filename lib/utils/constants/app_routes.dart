import 'package:ecomm_352/ui/cart/cart_page.dart';
import 'package:ecomm_352/ui/dashboard/home_page.dart';
import 'package:ecomm_352/ui/product_detail/product_detail_page.dart';
import 'package:ecomm_352/ui/sign_up/signup_page.dart';
import 'package:ecomm_352/ui/splash/splash_screen.dart';
import 'package:flutter/cupertino.dart';

class AppRoutes {

  static const String HOMEPAGE = "/home";
  static const String SPLASHPAGE = "/";
  static const String SIGNUPPAGE = "/signUp";
  static const String DETAILPAGE = "/detail-page";
  static const String CARTPAGE = "/cart-page";

  static Map<String, Widget Function(BuildContext)> mRoutes() => {
    SPLASHPAGE : (_) => SplashScreen(),
    SIGNUPPAGE : (_) => SignUpScreen(),
    HOMEPAGE : (_) => HomeScreen(),
    DETAILPAGE : (_) => ProductDetailScreen(),
    CARTPAGE : (_) => CartScreen(),
  };

}