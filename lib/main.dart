import 'package:ecomm_352/data/remote/helper/api_helper.dart';
import 'package:ecomm_352/data/remote/repositories/cart_repo.dart';
import 'package:ecomm_352/data/remote/repositories/product_repo.dart';
import 'package:ecomm_352/data/remote/repositories/user_repo.dart';
import 'package:ecomm_352/ui/dashboard/bloc/product/product_bloc.dart';
import 'package:ecomm_352/ui/product_detail/bloc/cart_bloc.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_bloc.dart';
import 'package:ecomm_352/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc(userRepo: UserRepo(apiHelper: ApiHelper())),),
        BlocProvider(create: (context) => ProductBloc(productRepo: ProductRepo(apiHelper: ApiHelper())),),
        BlocProvider(create: (context) => CartBloc(cartRepo: CartRepo(apiHelper: ApiHelper())),),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: AppRoutes.SPLASHPAGE,
      routes: AppRoutes.mRoutes(),
    );
  }
}
