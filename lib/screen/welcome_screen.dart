import 'package:flutter/material.dart';
import 'package:pokee/screen/Name_Pages/user_details.dart';
import 'package:pokee/screen/auth/phone_screen.dart';
import 'package:pokee/utils.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
              Colors.orangeAccent,
              Colors.orange.shade800,
            ])),
        child: Column(
          children: [
            const Spacer(),
            const Center(
              child: Text(
                'pokee',
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
            ),
            const Spacer(),
            customButton(
                text: 'CREATE ACCOUNT',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const SaveDetails(
                            field: UserField.firstName,
                          )));
                }),
            SizedBox(
              height: mq.height * .01,
            ),
            customButton(
                text: 'SIGN IN',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const PhoneScreen(
                            userExists: true,
                          )));
                }),
            SizedBox(height: mq.height * .07),
            const Text(
              privacy,
              style: TextStyle(color: Colors.white, fontSize: 10),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: mq.height * .06)
          ],
        ),
      ),
    );
  }

  Widget customButton({required String text, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(18)),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            )),
      ),
    );
  }
}
