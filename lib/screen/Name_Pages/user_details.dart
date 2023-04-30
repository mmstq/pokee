import 'package:flutter/material.dart';
import 'package:pokee/screen/auth/phone_screen.dart';
import 'package:pokee/utils.dart';

class SaveDetails extends StatefulWidget {
  final UserField field;

  const SaveDetails({Key? key, required this.field}) : super(key: key);

  @override
  State<SaveDetails> createState() => _SaveDetailsState();
}

class _SaveDetailsState extends State<SaveDetails> {
  final TextEditingController _controller = TextEditingController();
  bool isTap = false;

  @override
  void initState() {
    _controller.addListener(() {
      final isTap = _controller.text.length > 2;
      setState(() => this.isTap = isTap);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Enter your ${getField(widget.field)}",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
            const SizedBox(height: 24),
            SizedBox(
              width: 220,
              child: TextFormField(
                controller: _controller,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(focusColor: Colors.orange),
              ),
            ),
            const SizedBox(height: 32),
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
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => getNextPage(widget.field)));
                      }
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
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getField(UserField field) {
    switch (field) {
      case UserField.userName:
        return 'username';
      case UserField.firstName:
        return 'first name';
      case UserField.lastName:
        return 'last name';
    }
  }

  Widget getNextPage(UserField field) {
    switch (field) {
      case UserField.firstName:
        userDetails['first_name'] = _controller.text;
        return const SaveDetails(field: UserField.lastName);
      case UserField.lastName:
        userDetails['last_name'] = _controller.text;
        return const SaveDetails(field: UserField.userName);
      case UserField.userName:
        userDetails['user_name'] = _controller.text;
        return const PhoneScreen(
          userExists: false,
        );
    }
  }
}
