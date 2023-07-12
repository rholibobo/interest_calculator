// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Simple Interest Calculator App",
    home: SIForm(),
  ));
}

class SIForm extends StatefulWidget {
  const SIForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  // var _currencies = ["naira", "pound", "dollar", "others"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Simple Interest Calculator")),
        body: Container(
          child: Column(children: <Widget>[]),
        ));
  }
}
