import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'functions.dart';

class CalculateBlockPercent extends StatefulWidget {
  @override
  _CalculateBlockPercentState createState() => _CalculateBlockPercentState();
}

class _CalculateBlockPercentState extends State<CalculateBlockPercent>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final _formChannels = GlobalKey<FormState>();
  final _formIntensity = GlobalKey<FormState>();
  final channelsNumberController = TextEditingController();
  final intensityController = TextEditingController();
  bool validator = false;
  var blocking = " ";

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
              child: Text("Channels number"),
            ),
            Form(
              key: _formChannels,
              child: TextFormField(
                controller: channelsNumberController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (value) {
                  if (value.isEmpty) {
                    validator = false;
                  }
                  if (channelsNumberController.text.isEmpty) {
                    validator = false;
                  }
                  if (channelsNumberController.text.isNotEmpty &&
                      value.isNotEmpty) {
                    validator = true;
                  }

                  if (value.isNotEmpty &&
                      intensityController.text.isNotEmpty &&
                      double.parse(value) <= 256 &&
                      double.parse(value) >= 1 &&
                      double.parse(intensityController.text) >= 0.001 &&
                      double.parse(intensityController.text) <= 100) {
                    blocking = erl(int.parse(value),
                            double.parse(intensityController.text))
                        .toString();
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
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Trafic intensity"),
            ),
            Form(
              key: _formIntensity,
              child: TextFormField(
                controller: intensityController,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.deny(new RegExp('[\\-|\\,]')),
                  FilteringTextInputFormatter.allow(RegExp(r'(^\-?\d*\.?\d*)')),
                ],
                onChanged: (value) {
                  if (value.isEmpty) {
                    validator = false;
                  }
                  if (intensityController.text.isEmpty) {
                    validator = false;
                  }
                  if (intensityController.text.isNotEmpty && value.isNotEmpty) {
                    validator = true;
                  }
                  if (value.isNotEmpty &&
                      channelsNumberController.text.isNotEmpty &&
                      double.parse(channelsNumberController.text) <= 256 &&
                      double.parse(channelsNumberController.text) >= 1 &&
                      double.parse(value) >= 0.001 &&
                      double.parse(value) <= 100) {
                    blocking = erl(int.parse(channelsNumberController.text),
                            double.parse(value))
                        .toString();
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
                  "Blocking: " + blocking + "%",
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
