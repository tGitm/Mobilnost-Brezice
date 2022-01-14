import 'package:brezice_mobility/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:developer';


class Aed extends StatefulWidget {
  @override
  State<Aed> createState() => _AedState();
}

//MAPBOX connection string
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

LatLng _center = LatLng(45.904679796133316, 15.595750781442923);

class _AedState extends State<Aed> {
  Color appbar = Color(0xff4471a0);
  List<dynamic> _items = [];



    @override
    Widget build(BuildContext context) {
      double zoom = 11.2;
      //Fetch data from json
      Future<void> _readJson() async {
        final String response = await rootBundle.loadString(
            'assets/data/lokacije_defibrilatorjev.json');
        final data = await json.decode(response);
        _items = data['aeds'];
        print(_items[0]['opis']);
        print(_items[0]['latitude']);
        print(_items[0]['longitude']);
        /*setState(() {
      _items = data["parkings"];
    });*/

      }

      List<Marker> _buildMarkers() {
        final _markerList = <Marker>[];
        for (int i = 0; i < _items.length; i++) {
          _markerList.add(
            Marker(
              width: 24.0,
              height: 24.0,
              point: LatLng(_items[i]['latitude'], _items[i]['longitude']),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    zoom = 16;
                    _center = LatLng(_items[i]['latitude'], _items[i]['longitude']);
                    log('Selected: ${_items[i]['opis']}');
                  },
                  child: Image.asset('assets/icons/aed_green.png'),
                );
              },
            ),
          );
        }
        return _markerList;
      }

      _readJson();
      final _markers = _buildMarkers();

      return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text('Mobilnost v Brežicah'),
              Text(
                'Defibrilatorji',
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
          backgroundColor: appbar,
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: _center,
                zoom: 11.2,
                minZoom: 10,
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                  additionalOptions: {
                    'accessToken': MAPBOX_ACCESS_TOKEN,
                    'id': MAPBOX_STYLE
                  },
                ),
                MarkerLayerOptions(
                  markers: _markers,
                ),
              ],
            ),
          ]
        ),
      );
    }
  }