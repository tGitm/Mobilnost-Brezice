import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:developer';


class Speed extends StatefulWidget {
  @override
  State<Speed> createState() => _SpeedState();
}

//MAPBOX connection string
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

final _brezice = LatLng(45.904679796133316, 15.595750781442923);

class _SpeedState extends State<Speed> {
  Color appbar = Color(0xff4471a0);
  List<dynamic> _items = [];

  //Fetch data from json
  Future<void> _readJson() async {
    final String response = await rootBundle.loadString(
        'assets/data/merilniki_hitrosti.json');
    final data = await json.decode(response);
    _items = data['parkings'];
    print(_items[0]['opis']);
    print(_items[0]['proizvajalec']);
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
                  log('Selected: ${_items[i]['opis']}');
                },
                child: Image.asset('assets/icons/speed_blue.png'),
              );
            },
          ),
      );
      }
    return _markerList;
  }

    @override
    Widget build(BuildContext context) {
      _readJson();
      final _markers = _buildMarkers();

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text('Mobilnost v Brežicah'),
              Text(
                'Prikazovalniki hitrosti',
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
                center: _brezice,
                zoom: 22.0,
                minZoom: 13,
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