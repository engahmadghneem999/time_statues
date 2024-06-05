import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class PickingPosMap extends StatefulWidget {
  const PickingPosMap({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<PickingPosMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(21.5303919, 39.1608216),
    zoom: 14.999,
  );

  List<Marker> markers = [];
  LatLng? pickedLocation;

  void _onMapTapped(LatLng latLng) {
    setState(() {
      markers.clear();
      markers.add(Marker(
        markerId: MarkerId('picked-location'),
        position: latLng,
      ));
      pickedLocation = latLng;
    });
  }

  void _confirmLocation() {
    if (pickedLocation != null) {
      Navigator.pop(context, pickedLocation);
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        title: 'No location picked',
        desc: 'Please tap on the map to pick a location.',
        btnOkOnPress: () {},
      )..show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _confirmLocation,
          ),
        ],
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: markers.toSet(),
        onTap: _onMapTapped,
      ),
    );
  }
}
