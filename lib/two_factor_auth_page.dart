import 'package:auth_otp/auth_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:otp/otp.dart';
import 'package:project/core/helpers/show_snack_bar.dart';

class TwoFactorAuthPage extends StatefulWidget {
  const TwoFactorAuthPage({super.key});

  @override
  TwoFactorAuthPageState createState() => TwoFactorAuthPageState();
}

class TwoFactorAuthPageState extends State<TwoFactorAuthPage> {
  late String secretKey;
  late TextEditingController codeController;
  late bool isVerified;

  @override
  void initState() async {
    super.initState();
    codeController = TextEditingController();
    await initSecretKey();
  }

  @override
  dispose() {
    codeController.dispose();
    super.dispose();
  }

  Future<void> initSecretKey() async {
    final FlutterSecureStorage storage = const FlutterSecureStorage();
    String ketName = 'secretKey';
    final storedSecretKey = await storage.read(key: ketName);
    if (storedSecretKey == null) {
      final newSecretKey = AuthOTP.createSecret();
      await storage.write(key: ketName, value: newSecretKey);
      setState(() {
        secretKey = newSecretKey;
      });
    } else {
      setState(() {
        secretKey = storedSecretKey;
      });
    }
  }

  void verifyCode() {
    String enteredCode = codeController.text.trim();
    final generatedCode = OTP.generateTOTPCodeString(
      secretKey,
      DateTime.now().millisecondsSinceEpoch,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
    if (enteredCode == generatedCode) {
      showSnackBar(context, text: 'Code verified successfully.');
    } else {
      showSnackBar(context, text: 'Invalid code. Please try again.');
    }
    setState(() {
      isVerified = enteredCode == generatedCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Two-Factor Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '1. Open Google Authenticator\n'
              '2. Tap "+" → "Enter a setup key"\n'
              '3. Enter the Account Name and Secret Key shown below\n'
              'Your secret key: $secretKey'
              '\n'
              '4. Tap "Add"',
            ),
            SizedBox(height: 24),
            Text('Please enter the 6-digit code shown in the app.'),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: 'Enter code',
                hintStyle: TextStyle(fontSize: 13),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: verifyCode,
                child: Text('Verify Code'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
