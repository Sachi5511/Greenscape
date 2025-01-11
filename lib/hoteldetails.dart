import 'package:flutter/material.dart';

class HotelDetailsPage extends StatefulWidget {
  const HotelDetailsPage({super.key});

  @override
  HotelDetailsPageState createState() => HotelDetailsPageState();
}

class HotelDetailsPageState extends State<HotelDetailsPage> {
  final _formKey = GlobalKey<FormState>();
  final _ownerNameController = TextEditingController();
  final _hotelNameController = TextEditingController();
  final _expectedAreaController = TextEditingController();
  final _existingAreaController = TextEditingController();
  bool _isNewHotel = false;

  @override
  void dispose() {
    _ownerNameController.dispose();
    _hotelNameController.dispose();
    _expectedAreaController.dispose();
    _existingAreaController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final ownerName = _ownerNameController.text.trim();
      final hotelName = _hotelNameController.text.trim();
      final area = _isNewHotel
          ? _expectedAreaController.text.trim()
          : _existingAreaController.text.trim();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Submitted: $ownerName, $hotelName, '
            '${_isNewHotel ? 'New Hotel' : 'Existing Hotel'}, Area: $area',
          ),
        ),
      );

      _ownerNameController.clear();
      _hotelNameController.clear();
      _expectedAreaController.clear();
      _existingAreaController.clear();
      setState(() {
        _isNewHotel = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Hotel Details'),
        centerTitle: true,
      ),
       body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Owner's Name Field
                TextFormField(
                  controller: _ownerNameController,
                  decoration: InputDecoration(
                    labelText: 'Owner\'s Name',
                    hintText: 'Enter the owner\'s name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.green[50],
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the owner\'s name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // Hotel Name Field
                TextFormField(
                  controller: _hotelNameController,
                  decoration: InputDecoration(
                    labelText: 'Hotel Name',
                    hintText: 'Enter the hotel name',
                    prefixIcon: const Icon(Icons.hotel),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    filled: true,
                    fillColor: Colors.green[50],
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter the hotel name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                // New Hotel Switch with Label
                Row(
                  children: [
                    const Text(
                      'Is this a new hotel?',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Switch(
                      value: _isNewHotel,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          _isNewHotel = value;
                        });
                      },
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      _isNewHotel ? 'Yes' : 'No',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: _isNewHotel ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Conditional Fields for New/Existing Hotel
                if (_isNewHotel)
                  TextFormField(
                    controller: _expectedAreaController,
                    decoration: InputDecoration(
                      labelText: 'Expected area for garden (sq.m)',
                      hintText: 'Enter the expected area',
                      prefixIcon: const Icon(Icons.landscape),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the expected area';
                      }
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                if (!_isNewHotel)
                  TextFormField(
                    controller: _existingAreaController,
                    decoration: InputDecoration(
                      labelText: 'Existing garden area (sq.m)',
                      hintText: 'Enter the existing area',
                      prefixIcon: const Icon(Icons.park),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      filled: true,
                      fillColor: Colors.green[50],
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter the existing area';
                      }
                      if (double.tryParse(value) == null ||
                          double.parse(value) <= 0) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                const SizedBox(height: 20.0),

                // Submit Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 24.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(fontSize: 18.0),
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