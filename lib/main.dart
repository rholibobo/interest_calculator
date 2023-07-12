// ignore_for_file: prefer_const_constructors, prefer_final_fields, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Interest Calculator App",
    home: SIForm(),
    theme: ThemeData(
      // brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.indigo,
      accentColor: Colors.indigoAccent,
      // backgroundColor: Colors.black,
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

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text("Simple Interest Calculator")),
        body: Container(
          margin: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(children: <Widget>[
            getImageAsset(),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Principal",
                    labelStyle: textStyle,
                    hintText: "Enter Principal e.g 12000",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    labelStyle: textStyle,
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
                        child: TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      decoration: InputDecoration(
                          labelText: "Time",
                          labelStyle: textStyle,
                          hintText: "Time in years",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    )),
                    Container(
                      width: _minimumPadding * 5,
                    ),
                    Expanded(
                        child: DropdownButton<String>(
                      value: _currencies[0],
                      items: _currencies.map((String valueItem) {
                        return DropdownMenuItem<String>(
                          value: valueItem,
                          child: Text(valueItem),
                        );
                      }).toList(),
                      onChanged: (value) => {},
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
                      child: Text("Calculate", style: textStyle,),
                      onPressed: () {},
                    )),
                    Expanded(
                        child: ElevatedButton(
                      child: Text("Reset", style: textStyle,),
                      onPressed: () {},
                    ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text("Todo Text", style: textStyle,),
            )
          ]),
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
}
