import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:pokee/homepage.dart';
import 'package:pokee/screen/api/api.dart';
import 'package:pokee/utils.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool userExists;

  const VerificationScreen(
      {super.key, required this.phoneNumber, required this.userExists});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _otpFieldController = TextEditingController();

  var _verificationID = '';
  Timer? timer;
  int time = 60;

  @override
  void initState() {
    _verifyPhone(widget.phoneNumber);
    _startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
                child: Text(
              'Enter the 6-digit OTP',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 32,),
            Pinput(
              length: 6,
              keyboardType: TextInputType.phone,
              pinAnimationType: PinAnimationType.slide,
              showCursor: true,
              preFilledWidget: preFilledWidget,
              defaultPinTheme: defaultPinTheme,
              autofocus: true,
              cursor: cursor,
              closeKeyboardWhenCompleted: false,
              controller: _otpFieldController,
              onCompleted: (pin) async {
                try {
                  final userCredential = await auth
                      .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationID, smsCode: pin));
                  if (userCredential.user != null) {
                    await uploadUserDetails(userCredential.user!.uid, widget.phoneNumber);
                  }
                } catch (e) {
                  FocusScope.of(context).unfocus();
                  _scaffoldKey.currentState?.showBottomSheet((context) =>
                      const SnackBar(content: Text('Invalid OTP')));
                }
              },
            ),
            const SizedBox(height:24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Didn't get the code? ",
                    style: TextStyle(color: Colors.grey)),
                GestureDetector(
                    onTap: time == 0
                        ? () => _verifyPhone(widget.phoneNumber)
                        : null,
                    child: Text(
                      'Resend',
                      style: TextStyle(
                          color: time == 0
                              ? Colors.deepOrangeAccent
                              : Colors.black),
                    ))
              ],
            ),
            const SizedBox(height: 24),
            if(time>0)Text(
              '$time seconds',
              style:
              const TextStyle(color: Colors.deepOrangeAccent, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }

  _verifyPhone(String phoneNumber) async {
    if(timer != null && !timer!.isActive){
      _startTimer();
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91 $phoneNumber',
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userCredentials = await FirebaseAuth.instance
              .signInWithCredential(credential);
          if (userCredentials.user != null) {
            await uploadUserDetails(userCredentials.user!.uid, phoneNumber);
          }
        },
        verificationFailed: (FirebaseException e) {
          log('Error: $e');
        },
        codeSent: (String verificationID, resendToken) {
          setState(() {
            _verificationID = verificationID;
          });
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationID = verificationID;
          });
        });
  }

  void _startTimer() {
    time = 60;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (time > 0) {
          time--;
        }
      });
    });
  }

  Future<void> uploadUserDetails(String uid, String phone)async{
    if(!widget.userExists){
      final api = Api();
      userDetails['id']= uid;
      userDetails['phone_number']= phone;
      await api.postUser(userDetails).then((value) {
        if(value.statusCode==200){
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const HomePage()),
                  (route) => false);
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unknown error ${value.statusCode}')));
        }
      });
      return;
    }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false);

    }
  }

  @override
  void dispose() {
    timer!.cancel();
    _otpFieldController.dispose();
    super.dispose();
  }
}
