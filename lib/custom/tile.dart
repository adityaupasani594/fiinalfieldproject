import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/base.dart';

class DrawerTile extends StatelessWidget {
  const DrawerTile({
    super.key,
    required this.title,
    required this.route
  });

  final String title;
  final String route;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minTileHeight: 75,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      tileColor: Colors.grey.shade200,
      title: Text(
        title,
        style: GoogleFonts.karla(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }
}
