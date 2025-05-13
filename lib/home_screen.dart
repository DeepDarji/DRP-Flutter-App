import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'blockchain_service.dart';
import 'models.dart';

// Main screen for the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _driverIdController = TextEditingController();
  final _blockchainService = BlockchainService();
  String _errorMessage = '';
  bool _isLoading = false;
  DriverInfo? _driverInfo;
  VehicleInfo? _vehicleInfo;
  List<AccidentInfo>? _accidents;

  @override
  void dispose() {
    _driverIdController.dispose();
    _blockchainService.dispose();
    super.dispose();
  }

  // Fetch driver data when the button is pressed
  void _fetchDriverData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _driverInfo = null;
      _vehicleInfo = null;
      _accidents = null;
    });

    try {
      final driverId = int.tryParse(_driverIdController.text);
      if (driverId == null || driverId < 100000 || driverId > 999999) {
        throw Exception('Please enter a valid 6-digit driver ID');
      }

      final (driverInfo, vehicleInfo, accidents) =
      await _blockchainService.getDriverData(driverId);

      setState(() {
        _driverInfo = driverInfo;
        _vehicleInfo = vehicleInfo;
        _accidents = accidents;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade300, Colors.purple.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: ListView(
              children: [
                // App Title
                FadeInDown(
                  child: Text(
                    'Driver Reputation Passport',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                // Input field for driver ID
                FadeInUp(
                  child: _buildTextField(),
                ),
                const SizedBox(height: 16),
                // Fetch button
                FadeInUp(
                  delay: const Duration(milliseconds: 200),
                  child: _buildFetchButton(),
                ),
                const SizedBox(height: 16),
                // Error message
                if (_errorMessage.isNotEmpty)
                  FadeIn(
                    child: Text(
                      _errorMessage,
                      style: GoogleFonts.poppins(
                        color: Colors.redAccent,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                // Driver info display
                if (_driverInfo != null) ...[
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: _buildSectionTitle('Driver Information'),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildDriverInfoCard(),
                  ),
                ],
                // Vehicle info display
                if (_vehicleInfo != null && _vehicleInfo!.exists) ...[
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: _buildSectionTitle('Vehicle Information'),
                  ),
                  const SizedBox(height: 12),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildVehicleInfoCard(),
                  ),
                ],
                // Accident history display
                if (_accidents != null && _accidents!.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  FadeInUp(
                    child: _buildSectionTitle('Accident History'),
                  ),
                  const SizedBox(height: 12),
                  ..._accidents!.asMap().entries.map((entry) {
                    final index = entry.key + 1;
                    final accident = entry.value;
                    return FadeInUp(
                      delay: Duration(milliseconds: 100 * (index + 1)),
                      child: _buildAccidentInfoCard(index, accident),
                    );
                  }).toList(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build text field for driver ID input
  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _driverIdController,
        keyboardType: TextInputType.number,
        style: GoogleFonts.poppins(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Enter 6-digit Driver ID',
          labelStyle: GoogleFonts.poppins(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  // Build fetch button
  Widget _buildFetchButton() {
    return GestureDetector(
      onTap: _isLoading ? null : _fetchDriverData,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade600, Colors.purple.shade600],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: Center(
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
            'Fetch Driver Data',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  // Build section title
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  // Build driver info card
  Widget _buildDriverInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _neumorphicDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Driver image
          Center(
            child: _driverInfo!.imageUrl.isNotEmpty
                ? ClipOval(
              child: CachedNetworkImage(
                imageUrl: _driverInfo!.imageUrl,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.redAccent,
                  size: 50,
                ),
              ),
            )
                : const Icon(
              Icons.person,
              size: 120,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          // Driver details
          ...[
            'Name: ${_driverInfo!.name}',
            'DOB: ${_driverInfo!.dob}',
            'Mobile: ${_driverInfo!.mobile}',
            'Email: ${_driverInfo!.email}',
            'License: ${_driverInfo!.licenseNumber}',
            'Address: ${_driverInfo!.permanentAddress}',
            'Blood Group: ${_driverInfo!.bloodGroup}',
            'Vehicle Type: ${_driverInfo!.vehicleType}',
          ].map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build vehicle info card
  Widget _buildVehicleInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: _neumorphicDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...[
            'Company: ${_vehicleInfo!.company}',
            'Model: ${_vehicleInfo!.model}',
            'Registration: ${_vehicleInfo!.registrationNumber}',
            'PUC Dates: ${_vehicleInfo!.pucDates}',
            'Owner: ${_vehicleInfo!.ownerName}',
            'Insurance Provider: ${_vehicleInfo!.insuranceProvider}',
            'Policy Number: ${_vehicleInfo!.policyNumber}',
            'Policy Validity: ${_vehicleInfo!.policyValidity}',
            'Insurance Type: ${_vehicleInfo!.insuranceType}',
          ].map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build accident info card
  Widget _buildAccidentInfoCard(int index, AccidentInfo accident) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: _neumorphicDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Accident #$index',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          ...[
            'Date: ${accident.formattedDate}',
            'Location: ${accident.location}',
            'Description: ${accident.description}',
            'Cause: ${accident.cause}',
            'Case Status: ${accident.caseStatus}',
            'Claim Status: ${accident.claimStatus}',
            'FIR Number: ${accident.firNumber}',
          ].map(
                (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                item,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          if (accident.photoUrl.isNotEmpty) ...[
            const SizedBox(height: 12),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                    imageUrl: accident.photoUrl,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.redAccent,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ] else
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'No accident photo available',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  // Neumorphic decoration for cards
  BoxDecoration _neumorphicDecoration() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(4, 4),
        ),
        BoxShadow(
          color: Colors.white.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(-4, -4),
        ),
      ],
    );
  }
}