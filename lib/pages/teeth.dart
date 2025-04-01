import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'about');
              },
              icon: Icon(Icons.message)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, 'pro');
              },
              icon: Icon(Icons.person))
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // Remove default shadow
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.indigo],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'Forensodont',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bger.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Center(
              child: SingleChildScrollView(
                child: SelectableText(
                  'The Government Dental College and Hospital, Mumbai, a premier institution dedicated to advanced dental education and patient care, has collaborated with the innovative and esteemed Vivekanand Education Society’s Institute of Technology to develop \'Forensodont,\' a specialized app designed to assist doctors and forensic experts in identifying individuals through dental records.\n\n'
                      'It allows the user to upload post-mortem images, while doctors provide antemortem dental radiographs and other details. This app securely stores this data and utilizes deep learning to compare images, streamlining the identification process.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
