import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:brezice_mobility/components/size_config.dart';
import 'package:brezice_mobility/components/nav_bar.dart';
import 'dart:async';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

//MAPBOX connection string
const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

final _brezice = LatLng(45.904679796133316, 15.595750781442923);

class _HomeState extends State<Home> {
  Color appbar = Color(0xff4471a0);
  List<dynamic> _items = [];



    @override
    Widget build(BuildContext context) {
      //Fetch data from json
      Future<void> _readJson() async {
        final String response = await rootBundle.loadString(
            'assets/data/lokacije_parkirnih_mest.json');
        final data = await json.decode(response);
        _items = data['parkings'];
        print(_items[0]['lokacija_parkirisca']);
        print(_items[0]['opis_lokacije']);
        print(_items[0]['LAT']);
        print(_items[0]['LON']);
        /*setState(() {
      _items = data["parkings"];
    });*/

      }


      /// project bottom sheet
      showBottomSheet(Text lokacija, Text opis_loacije, Text parkirni_prostori, Text prostori_za_invalide, Text parkirni_rezim) {
        Get.bottomSheet(
          Container(
            padding: EdgeInsets.only(top: 4),
            height: SizeConfig.screenHeight * 0.35,
            width: SizeConfig.screenWidth,
            color: Colors.white,
            child: Column(children: [
              Container(
                height: 6,
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]
                ),
              ),
              Spacer(),
              //here I'll add close button
              /*_buildBottomSheetButton(  // čene pa damo task completed gumb še zravn
                  label: "Task Completed",
                  onTap: () {
                    _taskController.markTaskCompleted(task.id);
                    Get.back();
                  },
                  clr: primaryClr),*/
              SizedBox(
                height: 20,
              ),
            ]),
          ),
        );
      }

      List<Marker> _buildMarkers() {
        _readJson();
        final _markerList = <Marker>[];
        for (int i = 0; i < _items.length; i++) {
          _markerList.add(
            Marker(
              width: 28.0,
              height: 28.0,
              point: LatLng(_items[i]['LAT'], _items[i]['LON']),
              builder: (_) {
                return GestureDetector(
                  onTap: () {
                    showBottomSheet(
                      Text('Lokacija: ${_items[i]['lokacija_parkirisca']}'),
                      Text('Opis: ${_items[i]['opis_lokacije']}'),
                      Text('Št. mest: ${_items[i]['parkirni_prostori']}'),
                      Text('Mesta invalidi: ${_items[i]['parkirni_prostori_za_invalide']}'),
                      Text('Režim: ${_items[i]['parkirni_rezim']}'),
                    );
                    log('Selected: ${_items[i]['opis_lokacije']}');
                  },
                  child: Image.asset('assets/icons/parking_blue.png'),
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
                'Parkirna mesta',
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