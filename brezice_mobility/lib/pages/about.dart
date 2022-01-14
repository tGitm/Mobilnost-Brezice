import 'package:brezice_mobility/components/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

const MAPBOX_ACCESS_TOKEN = 'pk.eyJ1IjoibWl0aTIxIiwiYSI6ImNreHVhZGtmZDFwaTUycHA0OXpjdnNhZHUifQ.yloT8ZiWAk-_yZp7MOQWEA';
const MAPBOX_STYLE = 'mapbox/light-v10';

final _brezice = LatLng(45.904679796133316, 15.595750781442923);

class _AboutState extends State<About> {
  Color appbar = Color(0xff4471a0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text('Mobilnost v Brežicah'),
            Text(
              'O projektu',
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
              ],
            ),
          Padding(
          padding:  EdgeInsets.fromLTRB(20, 105, 20, 0),
          child:
            Center(
              child:
              ListView(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: appbar,
                      ),
                      width: 100, height: 445,
                      child: Container(
                        child:
                          Padding(
                            padding:  EdgeInsets.all(20),
                            child:
                            Text("""Ideja za projekt je nastala pri predmetu multimedijske tehnologije na Fakulteti za računalništvo in informatiko Ljubljana. Pri predmetu smo morali izdelati aplikacijo zvizualizacijo
    s pomočjo odprtokodnih podatki iz portala OPSI. Ker za najino domačo občino (občino Brežice), še ni bilo plaforme, ki bi prikazovala vse podatko mobilnosti na enem mestu,
    sva se odločila za izdelavo spletne aplikacije z viualizacijo podatkov o mobilnosti.  Vizualizirala sva naslednje primere:
    parkirna mesta, izposojevalnice koles, električne polnilnice, merilce hitrosti ter dodala še podatke o defibrilatorjih.
    Nekaj podatkov sva dopolnila s pomočjo različnih orodij (aplikacije PlugShare, google Earth, merilce hitrosti pa sva morala ročno pridobiti iz zemljevida proizvajalcev in občine).
    Podatke sva predstavila na moderen ininteraktiven način, prijazen uporabnikom. Sedaj bo lahko vsak, ki bo te podatke potreboval, našel vse na enem mestu in bo tako  informiran o sami Občini Brežice in tem kar ponuja z vidika mobilnosti.""",
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.white)),
                          ),
                      ),
                    ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
