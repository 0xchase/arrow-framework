import 'dart:ui';

import 'package:flutter/material.dart';

class CliView extends StatefulWidget {
  @override
  State<CliView> createState() => _CliViewState();
}

class _CliViewState extends State<CliView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
      height: 100,
      color: Colors.black,
      child: const TextField(
        maxLines: 1,
        cursorWidth: 10,
        cursorColor: Colors.white,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: "RobotoMono",
        ),
        decoration: InputDecoration(
          isDense: true,
          focusedBorder: InputBorder.none
        ),
      ),
    );
  }
}
