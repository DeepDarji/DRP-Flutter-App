import 'package:flutter/material.dart';
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
      appBar: AppBar(
        title: const Text('Driver Reputation Passport'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input field for driver ID
              TextField(
                controller: _driverIdController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Enter 6-digit Driver ID',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              // Fetch button
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchDriverData,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Fetch Driver Data'),
              ),
              const SizedBox(height: 16),
              // Error message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(color: Colors.red),
                ),
              // Driver info display
              if (_driverInfo != null) ...[
                const Text(
                  'Driver Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoCard([
                  'Name: ${_driverInfo!.name}',
                  'DOB: ${_driverInfo!.dob}',
                  'Mobile: ${_driverInfo!.mobile}',
                  'Email: ${_driverInfo!.email}',
                  'License: ${_driverInfo!.licenseNumber}',
                  'Address: ${_driverInfo!.permanentAddress}',
                  'Blood Group: ${_driverInfo!.bloodGroup}',
                  'Vehicle Type: ${_driverInfo!.vehicleType}',
                ]),
              ],
              // Vehicle info display
              if (_vehicleInfo != null && _vehicleInfo!.exists) ...[
                const SizedBox(height: 16),
                const Text(
                  'Vehicle Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoCard([
                  'Company: ${_vehicleInfo!.company}',
                  'Model: ${_vehicleInfo!.model}',
                  'Registration: ${_vehicleInfo!.registrationNumber}',
                  'PUC Dates: ${_vehicleInfo!.pucDates}',
                  'Owner: ${_vehicleInfo!.ownerName}',
                  'Insurance Provider: ${_vehicleInfo!.insuranceProvider}',
                  'Policy Number: ${_vehicleInfo!.policyNumber}',
                  'Policy Validity: ${_vehicleInfo!.policyValidity}',
                  'Insurance Type: ${_vehicleInfo!.insuranceType}',
                ]),
              ],
              // Accident history display
              if (_accidents != null && _accidents!.isNotEmpty) ...[
                const SizedBox(height: 16),
                const Text(
                  'Accident History',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._accidents!.asMap().entries.map((entry) {
                  final index = entry.key + 1;
                  final accident = entry.value;
                  return _buildInfoCard([
                    'Accident #$index',
                    'Date: ${accident.formattedDate}',
                    'Location: ${accident.location}',
                    'Description: ${accident.description}',
                    'Cause: ${accident.cause}',
                    'Case Status: ${accident.caseStatus}',
                    'Claim Status: ${accident.claimStatus}',
                    'FIR Number: ${accident.firNumber}',
                  ]);
                }).toList(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build a card for displaying information
  Widget _buildInfoCard(List<String> items) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items
              .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(item),
          ))
              .toList(),
        ),
      ),
    );
  }
}