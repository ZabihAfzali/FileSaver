import 'package:filesaver/screens/AddPicturesToAlbum.dart';
import 'package:filesaver/screens/contacts_main_screens.dart';
import 'package:filesaver/screens/password_screen.dart';
import 'package:filesaver/screens/settings_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'screens/face_id.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  AppCustomizationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final LocalAuthentication _localAuth = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            checkBiometricType();
            final isAuthenticatd = await authenticate();

            if(isAuthenticatd) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomeScreen()),
              );
            } else {
              final snackbar = SnackBar(content: Text('Auth Failed'));
              ScaffoldMessenger.of(context).showSnackBar(snackbar);
            }
          },
          child: const Text('Authenticate'),
        ),
      ),
    );
  }

  //Check if biometric auth is available
  Future<bool> hasBiometrics() async {
    try {
      return await _localAuth.canCheckBiometrics;
    } on PlatformException catch (e) {
      return false;
    }
  }

//Check type of biometric auth available (Eg - Face ID, fingerprint)
  Future<void> checkBiometricType() async {
    final availableBiometrics = await _localAuth.getAvailableBiometrics();
    if(availableBiometrics.contains(BiometricType.face)){
      print('Face id is available');
    }
    print('Available biometrics: $availableBiometrics');
  }

  //Authenticate using biometric
  Future<bool> authenticate() async {
    final hasBiometric = await hasBiometrics();
    final availableBiometrics = await _localAuth.getAvailableBiometrics();

    if(hasBiometric) {
      return await _localAuth.authenticate(
        localizedReason: "Scan fingerprint to authenticate",
        options: const AuthenticationOptions(
          //Shows error dialog for system-related issues
          useErrorDialogs: true,
          //If true, auth dialog is show when app open from background
          stickyAuth: true,
          //Prevent non-biometric auth like such as pin, passcode.
          biometricOnly: false,
        ),
      );
    } else {
      return false;
    }
  }

}


