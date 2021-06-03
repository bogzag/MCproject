import 'package:flutter/material.dart';
import 'package:mc_project/calculate_block_percent.dart';
import 'package:mc_project/calculate_intensity.dart';

import 'calculare_channels_number.dart';
import 'info_modal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Erlang B calculator"),
        actions: [
          IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return InfoModal();
                    });
              })
        ],
      ),
      body: Column(
        children: [
          DefaultTabController(
              length: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 52,
                    child: TabBar(
                      labelColor: Colors.blue,
                      indicatorColor: Colors.blue,
                      tabs: [
                        Tab(
                          text: "Blocking",
                          icon: Icon(Icons.block),
                        ),
                        Tab(text: "Channels", icon: Icon(Icons.timeline)),
                        Tab(
                            text: "Intensity",
                            icon: Icon(Icons.stacked_bar_chart)),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    child: TabBarView(
                      children: [
                        CalculateBlockPercent(),
                        CalculateChannelsNumber(),
                        CalculateIntensity(),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
      // body: CalculateBlockPercent(),
    );
  }
}
