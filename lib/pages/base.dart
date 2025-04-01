import 'package:flutter/material.dart';
import 'package:forensic/pages/post.dart';
import 'package:forensic/pages/records.dart';
import 'package:forensic/pages/settings.dart';
import 'package:forensic/pages/teeth.dart';
import 'package:google_fonts/google_fonts.dart';

import '../custom/tile.dart';
import 'add.dart';
import 'login.dart';

int i = 0;

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  List<bool> active = [true, false, false, false, false];

  Widget whichBody(){
    return  _screens[i];
  }

  int _selectedIndex = 1;

  final List<Widget> _screens = [
    Data(),
    Records(),
    Post(),
    ProfileWidget(),
    About(),
  ];


  final List<String> titles = [
    "Add Data",
    "Records",
    "Post-mortem Images",
    "Profile",
    "About Us"
  ];

  @override
  Widget build(BuildContext context) {
    final spaceHeight = MediaQuery.of(context).size.height * 0.02;

    void setActive(int index) {
      setState(() {
        for (int i = 0; i < active.length; i++) {
          active[i] = i == index;
        }
      });
      Navigator.pop(context);
    }
    return Scaffold(
      bottomNavigationBar: Container(
        height: 70,
        color: Colors.indigo,
        child: Center(
          child: Text(
            'Forensodont', style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold
          ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        elevation: 0, // Remove default shadow
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        title: Text(
          titles[i],
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: SafeArea(child: _screens[i]),
    );
  }
}
