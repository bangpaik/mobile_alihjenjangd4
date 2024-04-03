import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageGoogleMap extends StatefulWidget {
  const PageGoogleMap({super.key});

  @override
  State<PageGoogleMap> createState() => _PageGoogleMapState();
}

class _PageGoogleMapState extends State<PageGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Google Maps'),
      ),
      body: GoogleMap(
        myLocationEnabled: true,
        initialCameraPosition: const CameraPosition(target: LatLng(-0.626439,100.117958),
          zoom: 16
        ),
        mapType: MapType.normal,
        markers: {
          const Marker(markerId: MarkerId("Pariaman"),
              position: LatLng(-0.626439, 100.117958),
            infoWindow: InfoWindow(
              title: 'Kota Pariaman',
              snippet: 'Pariaman, Sumatera Barat'
            )
          )
        },
      )
    );
  }
}
