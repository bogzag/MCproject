import 'package:flutter/material.dart';

class InfoModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Material(
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                Text(
                  "Initial requirement",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Text(
                  "Develop  a  Matlab  script  to make  use  of  theErlang's  B  formula  for  calculations  on  a single cell network: ",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "a.  Calculation  of  the blocking probability for a given  traffic  intensity  andaknown number of channels;",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "b.  Calculation  of  the  number  of  channels  required  for  a  given  traffic  intensity  and acertainmaximum blocking probabilityrequired;",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "c.  Calculation  of  the  maximum  traffic  intensity  that  can  be supportedby  a  network with a known number of channels and a maximumprobability of blocking.The  program  must  have  a  user-friendly  interface  for  entering the input  data by  the keyboard,  display  the  limits  between  which  they  can acceptvalues,  and  prevent  values from being enteredoutsidethe limits. ",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Limits:  number  of  channels:  between1  and  256, blockingprobability:  between  0.01% and 2%, traffic intensity: between 0.001 and 100 Erlang.",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Text("Bogza Gabriel", textAlign: TextAlign.center),
                Text("Florea Alexandru", textAlign: TextAlign.center),
                Text("Calapod Teodora", textAlign: TextAlign.center),
                Text("Profesor: Comsa Ciprian", textAlign: TextAlign.center),
                MaterialButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
