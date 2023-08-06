import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_app/auth_screen/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      builder: (context, child){
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Stream App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SignInScreen(),
        );
      },
    );
  }
}
