import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokee/screen/auth/verification_screen.dart';

class PhoneScreen extends StatefulWidget {
  final bool userExists;
  const PhoneScreen({Key? key, required this.userExists}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  late TextEditingController _controller;
  bool isTap = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      final isTap = _controller.text.length ==10;
      setState(() => this.isTap = isTap);
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your phone number',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 300,
                child: TextFormField(
                  autofocus: true,
                  maxLength: 10,
                  controller: _controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      prefix: const Text('+91 |   ',style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),),
                      ),
                ),
              ),
              SizedBox(height: mq.height * .02),
              const Text(
                'We will send you a verification code',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 280,
                child: MaterialButton(
                  height: 60,
                  minWidth: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24)),
                  disabledColor: Colors.grey,
                  color: Colors.orange,
                  onPressed: isTap
                      ? () => setState(() {
                            isTap = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => VerificationScreen(
                                      userExists: widget.userExists,
                                        phoneNumber: _controller.text)));
                          })
                      : null,
                  child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
