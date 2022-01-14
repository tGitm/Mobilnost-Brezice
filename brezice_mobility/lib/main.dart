import 'package:flutter/material.dart';
import 'package:brezice_mobility/pages/parkings.dart';
import 'package:brezice_mobility/pages/about.dart';
import 'package:brezice_mobility/pages/bikes.dart';
import 'package:brezice_mobility/pages/charges.dart';
import 'package:brezice_mobility/pages/speed.dart';
import 'package:brezice_mobility/pages/aed.dart';
import 'package:get/get.dart';


void main() => runApp(
    MaterialApp(
    initialRoute: '/parkings',
    routes: {
      '/parkings': (context) => Home(),
      '/bikes': (context) => Bikes(),
      '/charges': (context) => Charges(),
      '/aed': (context) => Aed(),
      '/speeds': (context) => Speed(),
      '/about': (context) => About(),
    },

));