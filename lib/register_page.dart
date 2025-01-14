import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart'; // Ensure you have this file and the HomeScreen implemented

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _nicController = TextEditingController();
  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _registerUser() async {
    final name = _nameController.text.trim();
    final contact = _contactController.text.trim();
    final nic = _nicController.text.trim();
    final address = _addressController.text.trim();
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      // Create a new user
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      // Add user details to Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'contact': contact,
        'nic': nic,
        'address': address,
        'email': username,
        'createdAt': DateTime.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );

      // Navigate to HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'An error occurred')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _nicController.dispose();
    _addressController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Register'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Icon(Icons.person_add, size: 100.0, color: Colors.green[700]),
                const SizedBox(height: 20.0),
                TextField(
                  controller: _nameController,
                  decoration: _inputDecoration('Name', Icons.person),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _contactController,
                  decoration: _inputDecoration('Contact', Icons.phone),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _nicController,
                  decoration: _inputDecoration('NIC', Icons.badge),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _addressController,
                  decoration: _inputDecoration('Personal Address', Icons.home),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _usernameController,
                  decoration: _inputDecoration('Email', Icons.email),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: _inputDecoration('Password', Icons.lock),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: _inputDecoration('Re-enter Password', Icons.lock),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text('Sign up'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hint,
      prefixIcon: Icon(icon, color: Colors.green[700]),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0),
        borderSide: BorderSide.none,
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
    );
  }
}
