import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('user_details').doc(user.email).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    showModalBottomSheet(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Choose from Gallery'),
            onTap: () async {
              await picker.pickImage(source: ImageSource.gallery);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Take a Photo'),
            onTap: () async {
              await picker.pickImage(source: ImageSource.camera);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, 'pro');
          }, icon: Icon(Icons.person))
        ],
        leading: IconButton(onPressed: (){Navigator.pushNamed(context,'home');}, icon: Icon(Icons.arrow_back)),
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
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 50),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => _pickImage(context),
                          child: const CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.camera_alt, color: Colors.white70, size: 35),
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildInfoTile(Icons.person, 'Name', userData?['full_name'] ?? 'Loading...'),
                        _buildInfoTile(Icons.email, 'Email', _auth.currentUser?.email ?? 'Loading...'),
                        _buildInfoTile(Icons.person, 'Gender', userData?['gender'] ?? 'Loading...'),
                        _buildInfoTile(Icons.confirmation_number, 'Registration Number', userData?['registration_number'] ?? 'Loading...'),
                        _buildInfoTile(Icons.location_city, 'Address of Practice', userData?['address'] ?? 'Loading...'),
                        _buildInfoTile(Icons.map, 'State of Practice', userData?['state_of_practice'] ?? 'Loading...'),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await _auth.signOut();
                            Navigator.pushReplacementNamed(context, 'land');
                          },
                          icon: const Icon(Icons.logout, color: Colors.white),
                          label: const Text('Logout'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
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

  Widget _buildInfoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 28),
          const SizedBox(width: 16),
          Text(
            '$label:',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
