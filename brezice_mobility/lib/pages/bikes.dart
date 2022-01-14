import 'package:brezice_mobility/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:developer';


class Bikes extends StatefulWidget {
  @override
  State<Bikes> createState() => _BikesState();
}

//MAPBOX connection string
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

final _brezice = LatLng(45.904679796133316, 15.595750781442923);

class _BikesState extends State<Bikes> {
  Color appbar = Color(0xff4471a0);
  List<dynamic> _items = [];


  //Fetch data from json
  Future<void> _readJson() async {
    final String response = await rootBundle.loadString(  //here I load Json file as string
        'assets/data/izposojevalnice_koles.json');
    final data = await json.decode(response); //decoding Json string
    _items = data['bikes'];  //assigning json data to dynamic List
    print(_items[0]['lokacija']);
    print(_items[0]['opis_lokacije']);
    print(_items[0]['LAT']);
    print(_items[0]['LON']);
    /*setState(() {
      _items = data["parkings"];
    });*/

  }



  //function for building markers for mapbox
  List<Marker> _buildMarkers() {
    _readJson();
    final _markerList = <Marker>[];
    for (int i = 0; i < _items.length; i++) {
      _markerList.add(
          Marker(
            width: 24.0,
            height: 24.0,
            point: LatLng(_items[i]['LAT'], _items[i]['LON']),
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  log('Selected: ${_items[i]['Opis_lokacije']}');
                },
                child: Image.asset('assets/icons/bike_blue.png'),
              );
            },
          ),
      );
      }
    return _markerList;
  }

    @override
    Widget build(BuildContext context) {

      final _markers = _buildMarkers();

      return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text('Mobilnost v Brežicah'),
              Text(
                'Izposojevalnice koles',
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
                zoom: 15.5,
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