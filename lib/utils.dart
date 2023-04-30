import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

enum UserField { firstName, lastName, userName }

const privacy = "By continuing, you agree to Pokee's Terms & condition "
    "and\nconfirm you have read Pokee's Privacy Policy.";

final Map<String, String> userDetails = {};

const defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: TextStyle(
    fontSize: 22,
    color: Colors.grey,
  ),
  decoration: BoxDecoration(),
);

final cursor = Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      width: 56,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ],
);
final preFilledWidget = Column(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      width: 56,
      height: 3,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ],
);
