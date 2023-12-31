// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable, no_leading_underscores_for_local_identifiers, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      primaryColor: Colors.indigo,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.indigo,
        accentColor: Colors.indigoAccent,
        brightness: Brightness.dark,
      ),
    ),
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
  var _currencies = ["naira", "pound", "dollar", "others"];
  final _minimumPadding = 5.0;

  var _formKey = GlobalKey<FormState>();

  var _currentItemSelected = "";
  String displayResult = "";

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Simple Interest Calculator"),
          backgroundColor: Colors.indigo,
        ),
        body: Form(
          key: _formKey,
          child: Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: ListView(children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: principalController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter Prinicipal amount";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Principal",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.yellow,
                        ),
                        hintText: "Enter Principal e.g 12000",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: roiController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a ROI value";
                      }
                    },
                    decoration: InputDecoration(
                        labelText: "Rate of Interest",
                        labelStyle: textStyle,
                        errorStyle: TextStyle(
                          fontSize: 15.0,
                          color: Colors.yellow,
                        ),
                        hintText: "Enter Rate e.g 1%",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter time";
                            }
                          },
                          style: textStyle,
                          controller: timeController,
                          decoration: InputDecoration(
                              labelText: "Time",
                              labelStyle: textStyle,
                              errorStyle: TextStyle(
                                fontSize: 15.0,
                                color: Colors.yellow,
                              ),
                              hintText: "Time in years",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        )),
                        Container(
                          width: _minimumPadding * 5,
                        ),
                        Expanded(
                            child: DropdownButton<String>(
                          items: _currencies.map((String valueItem) {
                            return DropdownMenuItem<String>(
                              value: valueItem,
                              child: Text(valueItem),
                            );
                          }).toList(),
                          value: _currentItemSelected,
                          onChanged: (newValueSelected) {
                            onDropDownSelectedItem(newValueSelected!);
                          },
                        ))
                      ],
                    )),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumPadding, bottom: _minimumPadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              foregroundColor: Colors.black),
                          child: Text("Calculate", textScaleFactor: 1.3),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState!.validate()) {
                                displayResult = calculateSimpleInterest();
                              }
                            });
                          },
                        )),
                        Expanded(
                            child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white),
                          child: Text(
                            "Reset",
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ))
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.all(_minimumPadding * 2),
                  child: Text(
                    displayResult,
                    style: textStyle,
                  ),
                )
              ])),
        ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/money.png');
    Image image = Image(image: assetImage, width: 250.0, height: 250.0);

    return Container(
      margin: EdgeInsets.all(_minimumPadding * 10),
      child: image,
    );
  }

  void onDropDownSelectedItem(String newValueSelected) {
    setState(() {
      _currentItemSelected = newValueSelected;
    });
  }

  String calculateSimpleInterest() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double time = double.parse(timeController.text);

    double totalAmount = principal + (principal * roi * time);
    String result =
        'After $time years, your investment will be worth $totalAmount $_currentItemSelected ';
    return result;
  }

  void _reset() {
    principalController.text = "";
    roiController.text = "";
    timeController.text = "";
    displayResult = "";

    _currentItemSelected = _currencies[0];
  }
}
