import 'dart:math';

double u;
double i;
double j;
double k;
double w;

fak(i) // Get factorial of i
{
  k = 1;
  for (j = 1; j <= i; j++) k *= j;
  // print(k);
  return k;
}

// functionfactorialIterative(number)
// {if (number < 0) return;
// var total = 1;
// for (var n = number; n > 1; n--) {
//   total  = total * n;
// }
// return total;
// }

// pow(k, i) // Compute k power i
// {
//   w = 1;
//   for (j = 1; j <= i; j++) w *= k;
//   return w;
// }

erl(n, a) {
  u = 1;
  // print("HEI" +fak(i).toString());
  for (i = 1; i <= n; i++) u += pow(a, i) / fak(i);
  var number = (((pow(a, n) / fak(n)) / u) * 100);
  if (number.isNaN) {
    print(number);
  }
  return ((pow(a, n) / fak(n)) / u) * 100;
}

calculateIntensity(channelNr, blockProbability){

  var channelsNumber = channelNr;
  // var blockProbability = 0.0198;
  // var anotherAlist = List<double>.generate(20, (i) => i + 0.01);
  List<double> anotherAlist = List<double>.generate(20000, (int index) => index * 0.1);
  // print(anotherAlist);
  // print(anotherAlist);

  double pozji = 0;
  var pp2 = (blockProbability * 100);
  double distance = 2000.00;
  int distanceElement;

    anotherAlist.forEach((element) {

      var comp2 = (erl(channelsNumber, element));
      // print(comp2 - (blockProbability*100));

      // if ((comp2 - (blockProbability * 100)).abs() < distance) {
      //   distance = (comp2 - (blockProbability * 100));
      //   pozji = element;
      //   print(element);
      // }

      if (comp2.round() == pp2.round()) {
        print("AICI");
        print(comp2);
        print(pp2);
        pozji = element;
        print(pozji);
      }
    });

  return pozji;
  }







calculateChannelsNumber2(intensity, probability) {
  var listA = List<int>.generate(130, (i) => i + 1);
  var channelsNumber;
  double distance = 10.00;
  int distanceElement;
  listA.forEach((element) {
    double calc = erl(element, intensity);

    if ((calc - (probability * 100)).abs() < distance) {
      distance = (calc - (probability * 100));
      distanceElement = element;
    }

    // if(calc.round() == (probability*100).round()){
    //   print("ALOOO" + (element).toString());
    //   print(calc);
    //   print(probability*100);
    //   channelsNumber = element;
    // }

    // if (calc.round() == (probability*100).round){
    //   print("else if $element");
    // }

    print("TEEST");
    print(calc);
    print(probability * 100);

    return element;
    channelsNumber = element;
  });
  return distanceElement;
}


