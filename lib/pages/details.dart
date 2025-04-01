import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../custom/mytextfield.dart';

class RegistrationDetailsPage extends StatefulWidget {
  @override
  _RegistrationDetailsPageState createState() => _RegistrationDetailsPageState();
}

class _RegistrationDetailsPageState extends State<RegistrationDetailsPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController registrationNumberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? selectedGender;
  String? selectedState;

  final List<String> genders = ["Male", "Female", "Other"];
  final List<String> indianStates = [
    "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat",
    "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh",
    "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan",
    "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal"
  ];

  Future<void> _submitData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user logged in")),
      );
      return;
    }
    try {
      await FirebaseFirestore.instance.collection('user_details').doc(user.email).set({
        'full_name': fullNameController.text.trim(),
        'gender': selectedGender,
        'registration_number': registrationNumberController.text.trim(),
        'address': addressController.text.trim(),
        'state_of_practice': selectedState,
        'email': user.email,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Details submitted successfully!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 70,
                ),
                Text('Forensodont', style: GoogleFonts.nunito(fontSize: 30)),
                Text('Registration Details'),
                const SizedBox(height: 50),
                CustomTextField(
                  hintText: "Full Name",
                  controller: fullNameController,
                  prefixIcon: Icons.person,
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: Text("Select Gender"),
                  value: selectedGender,
                  items: genders.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "Registration Number",
                  controller: registrationNumberController,
                  prefixIcon: Icons.badge,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "Address of Practice",
                  controller: addressController,
                  prefixIcon: Icons.location_on,
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  hint: Text("Select State of Practice"),
                  value: selectedState,
                  items: indianStates.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedState = newValue;
                    });
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 8,
                      shadowColor: Colors.blue.withOpacity(0.3),
                    ),
                    onPressed: () {
                      _submitData();
                      Navigator.pushNamed(context, 'home');
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
