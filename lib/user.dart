// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:green_scape_new/hoteldetails.dart';

class UserPage extends StatelessWidget {
  final String name;

  const UserPage({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Welcome, $name'),
        centerTitle: true,
        elevation: 4.0,
      ),
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[100]!, Colors.green[300]!],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header with icon
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.local_florist,
                        color: Colors.green,
                        size: 60.0,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'GreenScape Hospitality',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[800],
                        ),
                      ),
                    ],
                  ),
                ),
                // Buttons with shadows and decorations
                _buildActionButton(
                  context,
                  label: 'Enter your hotel details',
                  icon: Icons.hotel,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HotelDetailsPage()),
                    );
                  },
                ),
                _buildActionButton(
                  context,
                  label: 'Plant selection',
                  icon: Icons.eco,
                  onPressed: () {
                   
                  },
                ),
                _buildActionButton(
                  context,
                  label: 'Design your hotel environment',
                  icon: Icons.design_services,
                  onPressed: () {
                    
                  },
                ),
                _buildActionButton(
                  context,
                  label: 'See your cost prediction',
                  icon: Icons.calculate,
                  onPressed: () {
                    
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[700],
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 8.0,
          shadowColor: Colors.greenAccent,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.0, color: Colors.white),
            const SizedBox(width: 12.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
