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
      child: Padding (
        padding: EdgeInsets.zero,
         child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountEmail: Text('Developed by: Tim Rus'),
            currentAccountPicture: Image.asset('assets/images/logotip_brezice.png'),
            decoration: BoxDecoration(
              color: Colors.grey,
             ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
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
            leading: Icon(Icons.person),
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
            leading: Icon(Icons.share),
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
            leading: Icon(Icons.notifications),
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
            leading: Icon(Icons.settings),
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
        ],
      ),
      ),
    );
  }
}