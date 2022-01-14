import 'package:brezice_mobility/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:developer';


class Charges extends StatefulWidget {
  @override
  State<Charges> createState() => _ChargesState();
}

//MAPBOX connection string
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

final _brezice = LatLng(45.904679796133316, 15.595750781442923);

class _ChargesState extends State<Charges> {
  Color appbar = Color(0xff4471a0);
  List<dynamic> _items = [];

  @override
  Widget build(BuildContext context) {
    //Fetch data from json
    Future<void> _readJson() async {
      final String response = await rootBundle.loadString(
          'assets/data/elektricne_polnilnice.json');
      final data = await json.decode(response);
      _items = data['chargers'];
      /*setState(() {
      _items = data["parkings"];
    });*/
    }

    List<Marker> _buildMarkers() {
      _readJson();
      final _markerList = <Marker>[];
      for (int i = 0; i < _items.length; i++) {
        _markerList.add(
          Marker(
            width: 28.0,
            height: 28.0,
            point: LatLng(_items[i]['latitude'], _items[i]['longitude']),
            builder: (_) {
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        height: 260,
                        color:  Colors.grey[100],
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                child: Text(
                                  'Podatki o polnilnici',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text('Lokacija: ${_items[i]['naslov']}'),
                              Text('Opis: ${_items[i]['opis']}'),
                              Text('Št. vtičnic: ${_items[i]['vticnicaSt']}'),
                              Text('Vrsta vtičnice: ${_items[i]['vrstaVticnice']}'),
                              Text('Nazivna moč: ${_items[i]['nazivnaMoc']}'),
                              Text('Cena: ${_items[i]['cena']}'),
                              ElevatedButton(
                                child: const Text('Skrij'),
                                style: ElevatedButton.styleFrom(
                                  primary: appbar,
                                  textStyle: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
                                ),
                                onPressed: () => Navigator.pop(context),
                              )
                            ],
                          ),
                        ),

                      );
                    },
                  );
                  log('Selected: ${_items[i]['opis_lokacije']}');
                },
                child: Image.asset('assets/icons/chargers_green.png'),
              );
            },
          ),
        );
      }
      return _markerList;
    }
    final _markers = _buildMarkers();

    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('Mobilnost v Brežicah'),
            Text(
              'Električne polnilnice',
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