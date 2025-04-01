import 'package:flutter/material.dart';
import 'package:forensic/custom/tile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../custom/button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        onPageChanged: (index) {
          if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }
        },
        children: [
          Container(
            color: Colors.blue.shade200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png'),
                  Text(
                    'Forensodont',
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    )),
                  Center(
                    child: Text(
                      'An Initiative under GDC & VESIT\n                Collaboration',
                      style: GoogleFonts.nunito(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ),
                  SizedBox(
                    height: 75,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, 'login');
                  }, child: Container(
                    width: 180,
                    height: 50,
                    child: Center(
                      child: Text('I have an Account',style: GoogleFonts.nunito(
                        fontSize: 20
                      ),)
                    ),
                  )),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(onPressed: (){
                    Navigator.pushNamed(context, 'reg');
                  }, child: Container(
                    height: 50,
                    width: 180,
                    child: Center(
                      child: Text(
                        'Create an Account',
                        style: GoogleFonts.nunito(
                          fontSize: 20
                        )
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  Future<void> _launchForm() async {
    final Uri url = Uri.parse('https://docs.google.com/forms/d/e/1FAIpQLSfJaH1y9roscRcZRfP_m_xgTEJ3POmgYXSn1fQV2TpV0d4y4w/viewform'); // Replace with your URL
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchSheet() async {
    final Uri url = Uri.parse('https://docs.google.com/spreadsheets/d/1aC87BfHUvI3dUHcY9DJUcumyBl9HT0I4K5rO48HpAcA/edit?gid=2123889636#gid=2123889636'); // Replace with your URL
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){Navigator.pushNamed(context, 'about');}, icon: Icon(Icons.message)),
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'pro');
          }, icon: Icon(Icons.person))
        ],
        leading: IconButton(onPressed: (){Navigator.pushNamed(context,'land');}, icon: Icon(Icons.arrow_back)),
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

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //denatl examination
              //records
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  BeautifulButton(text: '     Dental   \nExamination', onPressed: () {
                    Navigator.pushNamed(context, 'data');
                  },),
                  BeautifulButton(text: '  Patient\n Records', onPressed: () {
                    _launchSheet();
                  },)
                ],
              ),
              SizedBox(
                height: 60,
              ),
              //extract records
              //Forensic matching
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  BeautifulButton(text: ' Extract \nRecords', onPressed: () {
                    Navigator.pushNamed(context, 'rec');
                  },),
                  BeautifulButton(text: ' Forensic\n Matching', onPressed: () {
                    Navigator.pushNamed(context, 'add');
                  },)
                ],
              ),
              SizedBox(
                height: 60,
              ),
              //dummy1a
              //dummy2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:[
                  BeautifulButton(text: 'Feedback', onPressed: () {
                    Navigator.pushNamed(context, 'sel');
                  },),
                  BeautifulButton(text: 'Antemortem', onPressed: () {
                    Navigator.pushNamed(context, 'grid');
                  },)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
