import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapForm extends StatefulWidget {
  const MapForm({ Key? key }) : super(key: key);

  @override
  State<MapForm> createState() => _MapFormState();
}

class _MapFormState extends State<MapForm> {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(41.441392, 2.186303),
        zoom: 13.0,
      ),
      layers: [
        TileLayerOptions(
        urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
        subdomains: ['a', 'b', 'c'],
        attributionBuilder: (_) {
          return Text("© OpenStreetMap contributors");
        },
      ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: latLng.LatLng(41.441392, 2.186303),
              builder: (ctx) => 
              Container(
                child: FlutterLogo(),
              )
            )
          ]
        )
      ],
    );
  }
}