# Driver Reputation Passport Flutter App

A Flutter application that interacts with a Solidity smart contract (`DriverReputationPassport`) deployed on a Ganache blockchain. This app allows users to fetch and display driver information, vehicle details, and accident history by entering a 6-digit driver ID. Designed as a learning tool for students to explore Flutter and Ethereum blockchain integration.

## Features
- **Driver Data Retrieval**: Fetch driver information, vehicle details, and accident history from the blockchain using a 6-digit driver ID.
- **User-Friendly UI**: Clean interface with input fields, buttons, and card-based data display.
- **Blockchain Integration**: Connects to a Ganache blockchain using the `web3dart` package.
- **Error Handling**: Displays meaningful error messages for invalid inputs or blockchain issues.
- **Modular Code**: Organized into separate files for UI, models, and blockchain services.

## Project Structure
The app is organized for modularity and clarity:
```
lib/
├── main.dart               # Entry point, sets up MaterialApp
├── home_screen.dart        # Main UI with input field and data display
├── blockchain_service.dart # Blockchain interaction logic (connects to Ganache)
├── models.dart             # Dart models for DriverInfo, VehicleInfo, AccidentInfo
```

## Learning Outcomes
This project is designed to teach students:
- **Flutter Basics**: Building UI with `StatelessWidget`, `StatefulWidget`, `TextField`, `ElevatedButton`, and `Card`.
- **State Management**: Using `setState` to update the UI dynamically.
- **Blockchain Integration**: Interacting with Ethereum using `web3dart` to call smart contract functions.
- **Data Modeling**: Creating Dart classes to mirror Solidity structs.
- **Error Handling**: Implementing try-catch blocks and user feedback.
- **Modular Design**: Organizing code into separate files for maintainability.

## Troubleshooting
- **Error: Undefined name 'EthereumAddress'**:
    - Ensure `web3dart: ^2.7.2` is in `pubspec.yaml`. If using `^3.0.0`, check import paths (e.g., `package:web3dart/web3dart.dart`).
    - Run `flutter clean && flutter pub get`.
- **Ganache Connection Issues**:
    - Verify Ganache is running at `HTTP://127.0.0.1:12121`.
    - Check the contract address in `blockchain_service.dart`.
- **No Data Displayed**:
    - Confirm the contract has data for the entered driver ID.
    - Use Remix to inspect the contract state.

Built with ❤️ for learning Flutter and blockchain development.