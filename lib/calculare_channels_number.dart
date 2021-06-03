import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'functions.dart';

class CalculateChannelsNumber extends StatefulWidget {
  @override
  _CalculateChannelsNumberState createState() =>
      _CalculateChannelsNumberState();
}

class _CalculateChannelsNumberState extends State<CalculateChannelsNumber>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _formProbability = GlobalKey<FormState>();
  final _formIntensity2 = GlobalKey<FormState>();
  final probabilityController = TextEditingController();
  final intensityController2 = TextEditingController();
  bool validator = false;
  var channels = " ";

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 290,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Blocking probability %"),
            ),
            Form(
              key: _formProbability,
              child: TextFormField(
                controller: probabilityController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\,]')),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty &&
                      intensityController2.text.isNotEmpty &&
                      double.parse(value) <= 2 &&
                      double.parse(value) > 0.01 &&
                      double.parse(intensityController2.text) > 0.001 &&
                      double.parse(intensityController2.text) <= 100) {
                    channels = calculateChannelsNumber(
                            double.parse(intensityController2.text),
                            (double.parse(value.toString()) / 100))
                        .toString();
                  }
                  setState(() {});
                },
                validator: (value) {
                  if (value.isEmpty) {
                    validator = false;
                  }

                  if (value.isNotEmpty &&
                      (double.parse(value) < 0.01 || double.parse(value) > 2)) {
                    validator = false;
                    return "Probability must be between 0.01 and 2";
                  }

                  return null;
                },
                keyboardType: TextInputType.number,
                obscureText: false,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "Enter the probability",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Trafic intensity"),
            ),
            Form(
              key: _formIntensity2,
              child: TextFormField(
                controller: intensityController2,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\,]')),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty &&
                      probabilityController.text.isNotEmpty &&
                      double.parse(probabilityController.text) <= 2 &&
                      double.parse(probabilityController.text) >= 0.01 &&
                      double.parse(value) >= 0.001 &&
                      double.parse(value) <= 100) {
                    channels = calculateChannelsNumber(
                      double.parse(value.toString()),
                      (double.parse(probabilityController.text) / 100),
                    ).toString();
                  }

                  setState(() {});
                },
                validator: (value) {
                  if (value.isEmpty) {
                    validator = false;
                  }
                  if (value.isNotEmpty &&
                      (double.parse(value) < 0.001 ||
                          double.parse(value) > 100)) {
                    validator = false;
                    return "Intensity must be between 0.001 and 100";
                  }
                  if (value.isNotEmpty &&
                      (double.parse(value) > 0.001 ||
                          double.parse(value) < 100)) {
                    validator = true;
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                obscureText: false,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter the trafic intensity",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Text(
                  "Channels number: " + channels,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
