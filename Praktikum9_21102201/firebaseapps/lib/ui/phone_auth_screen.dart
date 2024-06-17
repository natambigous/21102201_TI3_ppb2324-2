import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pertemuan_9/ui/home_screen.dart';

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _otpVisibility = false;
  User? _user;
  String _verificationId = "";
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _loginWithPhone() async {
    _auth.verifyPhoneNumber(
      phoneNumber: "+62" + _phoneController.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        setState(() {
          _otpVisibility = true;
          _verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void _verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationId,
      smsCode: _otpController.text,
    );

    await _auth.signInWithCredential(credential).then((value) {
      setState(() {
        _user = FirebaseAuth.instance.currentUser;
      });
    }).whenComplete(() {
      if (_user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Berhasil Login')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Gagal')),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: 'Masukkan nomor telepon anda',
                prefix: Padding(padding: EdgeInsets.all(4), child: Text('+62')),
              ),
              keyboardType: TextInputType.phone,
            ),
            Visibility(
              child: TextField(
                controller: _otpController,
                decoration: InputDecoration(
                  hintText: 'OTP',
                  prefix: Padding(padding: EdgeInsets.all(4), child: Text('')),
                ),
                keyboardType: TextInputType.number,
              ),
              visible: _otpVisibility,
            ),
            SizedBox(height: 10),
            MaterialButton(
              color: const Color(0xff3D4DE0),
              onPressed: () {
                if (_otpVisibility) {
                  _verifyOTP();
                } else {
                  _loginWithPhone();
                }
              },
              child: Text(
                _otpVisibility ? "Verify" : "Login",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
