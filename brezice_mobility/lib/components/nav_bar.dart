import 'package:flutter/material.dart';
import 'package:brezice_mobility/pages/parkings.dart';
import 'package:brezice_mobility/pages/about.dart';
import 'package:brezice_mobility/pages/bikes.dart';
import 'package:brezice_mobility/pages/charges.dart';
import 'package:brezice_mobility/pages/speed.dart';
import 'package:brezice_mobility/pages/aed.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                ),
                child: Container(
                  child: Image.asset(
                    'assets/images/logotip.png',
                    height: 100,
                    width: 200,
                  ),

                ),
            ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text('Parkirna mesta'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
          ),
              ListTile(
                leading: Icon(Icons.battery_charging_full),
                title: Text('Električne polnilnice'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Charges(),
                    ),
                  );
                },
              ),
          ListTile(
            leading: Icon(Icons.directions_bike ),
            title: Text('Izposojevalnice koles'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Bikes(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bolt),
            title: Text('Defibrilatorji'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Aed(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.speed ),
            title: Text('Prikazovalniki hitrosti'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Speed(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books ),
            title: Text('O projektu'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
            },
          ),
        ],
    ),
    );
  }
}