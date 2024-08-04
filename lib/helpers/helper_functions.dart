/*
* These are some helpful functions used across  the app
* */
import 'package:intl/intl.dart';

//convert string to double
double convertStringToDouble(String string) {
  double? value = double.tryParse(string);
  return value ?? 0;
}

//format double amounts into grams
String formatAmount(double amount) {
  final format = NumberFormat('.0#', 'en_US');
  return format.format(amount);
}
