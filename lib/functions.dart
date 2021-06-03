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
  return k;
}

erl(n, a) {
  u = 1;

  for (i = 1; i <= n; i++) u += pow(a, i) / fak(i);
  var number = (((pow(a, n) / fak(n)) / u) * 100);
  if (number.isNaN) {
    print(number);
  }
  return ((pow(a, n) / fak(n)) / u) * 100;
}

calculateIntensity(channelNr, blockProbability) {
  var channelsNumber = channelNr;

  List<double> anotherAlist =
      List<double>.generate(20000, (int index) => index * 0.01);

  double pozji = 0;
  var pp2 = (blockProbability * 100);

  anotherAlist.forEach((element) {
    var comp2 = (erl(channelsNumber, element));

    if (comp2.round() == pp2.round()) {
      pozji = element;
    }
  });

  return pozji;
}

calculateChannelsNumber(intensity, probability) {
  var listA = List<int>.generate(130, (i) => i + 1);

  double distance = 10.00;
  int distanceElement;
  listA.forEach((element) {
    double calc = erl(element, intensity);

    if ((calc - (probability * 100)).abs() < distance) {
      distance = (calc - (probability * 100));
      distanceElement = element;
    }

    return element;
  });
  return distanceElement;
}
