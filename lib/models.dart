// Models to represent data structures from the Solidity contract

// Represents DriverInfo struct from the smart contract
class DriverInfo {
  final String name;
  final String dob;
  final String mobile;
  final String email;
  final String licenseNumber;
  final String permanentAddress;
  final String bloodGroup;
  final String vehicleType;
  final String imageUrl;
  final bool exists;

  DriverInfo({
    required this.name,
    required this.dob,
    required this.mobile,
    required this.email,
    required this.licenseNumber,
    required this.permanentAddress,
    required this.bloodGroup,
    required this.vehicleType,
    required this.imageUrl,
    required this.exists,
  });

  // Factory method to create DriverInfo from contract data
  factory DriverInfo.fromContract(List<dynamic> data) {
    return DriverInfo(
      name: data[0] as String,
      dob: data[1] as String,
      mobile: data[2] as String,
      email: data[3] as String,
      licenseNumber: data[4] as String,
      permanentAddress: data[5] as String,
      bloodGroup: data[6] as String,
      vehicleType: data[7] as String,
      imageUrl: data[8] as String,
      exists: data[9] as bool,
    );
  }
}

// Represents VehicleInfo struct from the smart contract
class VehicleInfo {
  final String company;
  final String model;
  final String registrationNumber;
  final String pucDates;
  final String ownerName;
  final String insuranceProvider;
  final String policyNumber;
  final String policyValidity;
  final String insuranceType;
  final bool exists;

  VehicleInfo({
    required this.company,
    required this.model,
    required this.registrationNumber,
    required this.pucDates,
    required this.ownerName,
    required this.insuranceProvider,
    required this.policyNumber,
    required this.policyValidity,
    required this.insuranceType,
    required this.exists,
  });

  // Factory method to create VehicleInfo from contract data
  factory VehicleInfo.fromContract(List<dynamic> data) {
    return VehicleInfo(
      company: data[0] as String,
      model: data[1] as String,
      registrationNumber: data[2] as String,
      pucDates: data[3] as String,
      ownerName: data[4] as String,
      insuranceProvider: data[5] as String,
      policyNumber: data[6] as String,
      policyValidity: data[7] as String,
      insuranceType: data[8] as String,
      exists: data[9] as bool,
    );
  }
}

// Represents AccidentInfo struct from the smart contract
class AccidentInfo {
  final int dateTime; // Unix timestamp
  final String location;
  final String description;
  final String cause;
  final String caseStatus;
  final String claimStatus;
  final String photoUrl;
  final String firNumber;
  final bool exists;

  AccidentInfo({
    required this.dateTime,
    required this.location,
    required this.description,
    required this.cause,
    required this.caseStatus,
    required this.claimStatus,
    required this.photoUrl,
    required this.firNumber,
    required this.exists,
  });

  // Factory method to create AccidentInfo from contract data
  factory AccidentInfo.fromContract(List<dynamic> data) {
    return AccidentInfo(
      dateTime: (data[0] as BigInt).toInt(),
      location: data[1] as String,
      description: data[2] as String,
      cause: data[3] as String,
      caseStatus: data[4] as String,
      claimStatus: data[5] as String,
      photoUrl: data[6] as String,
      firNumber: data[7] as String,
      exists: data[8] as bool,
    );
  }

  // Convert Unix timestamp to readable date
  String get formattedDate {
    final date = DateTime.fromMillisecondsSinceEpoch(dateTime * 1000);
    return '${date.day}/${date.month}/${date.year}';
  }
}