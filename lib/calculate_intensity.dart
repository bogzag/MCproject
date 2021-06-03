import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'functions.dart';

class CalculateIntensity extends StatefulWidget {
  @override
  _CalculateIntensityState createState() => _CalculateIntensityState();
}

class _CalculateIntensityState extends State<CalculateIntensity>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _formProbability = GlobalKey<FormState>();
  final _formChannels = GlobalKey<FormState>();
  final probabilityController = TextEditingController();
  final channelsController = TextEditingController();
  bool validator = false;
  String calculatorError = "";
  var intensity = " ";

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
                onFieldSubmitted: (value) {
                  calculatorError = "";
                  if (value.isNotEmpty &&
                      channelsController.text.isNotEmpty &&
                      double.parse(value) <= 2 &&
                      double.parse(value) >= 0.01 &&
                      double.parse(channelsController.text) >= 1 &&
                      double.parse(channelsController.text) <= 256) {
                    try {
                      intensity = calculateIntensity(
                              int.parse(channelsController.text),
                              (double.parse(value.toString()) / 100))
                          .toString();
                    } catch (err) {
                      intensity = "";
                      calculatorError =
                          "Sorry, over the calculator computation power";
                    }
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
              child: Text("Channels number"),
            ),
            Form(
              key: _formChannels,
              child: TextFormField(
                controller: channelsController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\,]')),
                ],
                onFieldSubmitted: (value) {
                  calculatorError = "";
                  if (value.isNotEmpty &&
                      probabilityController.text.isNotEmpty &&
                      double.parse(probabilityController.text) <= 2 &&
                      double.parse(probabilityController.text) >= 0.01 &&
                      double.parse(value) >= 1 &&
                      double.parse(value) <= 256) {
                    try {
                      intensity = calculateIntensity(
                              (int.parse(value)),
                              (double.parse(
                                      probabilityController.text.toString()) /
                                  100))
                          .toString();
                    } catch (err) {
                      intensity = "";
                      calculatorError =
                          "Sorry, over the calculator computation power";
                    }
                  }

                  setState(() {});
                },
                validator: (value) {
                  if (value.isEmpty) {
                    validator = false;
                  }
                  if (value.isNotEmpty &&
                      (int.parse(value) < 1 || int.parse(value) > 256)) {
                    validator = false;
                    return "Channels no. must be between 1 and 256";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                obscureText: false,
                autovalidateMode: AutovalidateMode.always,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    hintText: "Enter the channels number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      if (calculatorError == "")
                        Text(
                          "Trafic Intensity: " + intensity,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      Text(calculatorError),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
