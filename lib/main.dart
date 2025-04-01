import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:forensic/pages/add.dart';
import 'package:forensic/pages/base.dart';
import 'package:forensic/pages/details.dart';
import 'package:forensic/pages/home.dart';
import 'package:forensic/pages/login.dart';
import 'package:forensic/pages/records.dart';
import 'package:forensic/pages/reg.dart';
import 'package:forensic/pages/settings.dart';
import 'firebase_options.dart';
import 'package:forensic/pages/teeth.dart';
import 'package:forensic/pages/test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'data':(context)=>Data(),
        'grid':(context)=>MyGrid(),
        'about':(context)=>About(),
        'land':(context)=>LandingPage(),
        'login':(context)=>LoginPage(),
        'home':(context)=>HomePage(),
        'rec':(context)=>Records(),
        'reg':(context)=>RegisterPage(),
        'pro':(context)=>ProfileWidget(),
        'det':(context)=>RegistrationDetailsPage(),
      },
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Color(0xFFA7D3DE),
      ),
    );
  }
}
