import 'package:ecomm_352/data/remote/helper/api_helper.dart';
import 'package:ecomm_352/data/remote/repositories/user_repo.dart';
import 'package:ecomm_352/ui/sign_up/bloc/user_bloc.dart';
import 'package:ecomm_352/ui/sign_up/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => UserBloc(userRepo: UserRepo(apiHelper: ApiHelper())),
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
      home: SignUpScreen(),
    );
  }
}
