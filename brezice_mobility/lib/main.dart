import 'package:flutter/material.dart';
import 'package:brezice_mobility/pages/parkings.dart';
import 'package:brezice_mobility/pages/about.dart';
import 'package:get/get.dart';


void main() => runApp(
    MaterialApp(
    initialRoute: '/home',
    routes: {
      '/home': (context) => Home(),
      '/about': (context) => About(),
    },

));