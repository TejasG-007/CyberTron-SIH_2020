import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:safty_first/services/auth.dart';


class View extends StatefulWidget {

  @override
  _ViewState createState() => _ViewState();

}

class _ViewState extends State<View> {
  final AuthService _auth = AuthService();
  final DBRef = FirebaseDatabase.instance.reference();
  Completer<GoogleMapController>_controller = Completer();
  static const LatLng _center = const LatLng(20.5937,78.9629);
  final Set<Marker>_markers= {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  double lat,lan;
  String _currentlocation = "";

  void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      lat = position.latitude;
      lan = position.longitude;
      _currentlocation = "${position.latitude},${position.longitude}";
    });
  }

  static final CameraPosition _position1 = CameraPosition(
      bearing: 1.272,
      target: LatLng(20.5937,78.9629),
      tilt:30,
      zoom:11.0
  );
  Future<void> _goToPosition1()async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_position1));
  }

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }
  _OnCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;

  }
  _onMapTypeButtonPress(){
    setState(() {
      _currentMapType = _currentMapType == MapType.normal ?
      MapType.satellite
          : MapType.normal;
    });
  }
  _onAddMarkerButtonPressed(){
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(_lastMapPosition.toString()),
        position: _lastMapPosition,
        infoWindow: InfoWindow(
            title: "Tejas ",
            snippet: "TejasG007"
        ),
        icon : BitmapDescriptor.defaultMarker,
      ),);
    });
  }

  //=========================DataSender=======================================

  void writeData() async {
    dynamic result = await _auth.signInAnon();
    String user_id = result.uid;
    //print(result);
    DBRef.child('report/$user_id').set({
      'latitude':lat,
      'longitude':lan,
      'title':'',
      'description':'',
    });
  }
void  _pressedsos(BuildContext context){
    var alertDialog = AlertDialog(
      title: Text("You have Pressed SOS button !!!",style: TextStyle(color: Colors.red),),
      content: Text(" OK \n\nYour Request have been sent\n"),
    );
    showDialog(context: context,
        builder: (BuildContext context){
        return alertDialog;
        }
    );
}




  Widget button (Function function,IconData icon){
    return FloatingActionButton(
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: Colors.blue,
      child: Icon(
        icon,
        size: 36.0,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(

      title: Text("$_currentlocation"),
    ),
      body: Stack(
        children: <Widget>[

          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(20.5937,78.9629),
              zoom: 11.0,),
            mapType: _currentMapType ,
            markers: _markers,

            onCameraMove: _OnCameraMove,
          ),
          Container(
              child: Row(
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text('SOS',style: TextStyle(color: Colors.white),),

                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(110.0)),
                    onPressed:(){
                      _pressedsos(context);
                      writeData();
                    },
                  )
                ],
              )
          ),
          Container(
            child: SizedBox(
              height: 20,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right:10 ,left : 40 ,top: 60),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  button(_onMapTypeButtonPress,Icons.map),
                  SizedBox(height: 16.0,),
                  button(_onAddMarkerButtonPressed,Icons.add_location),
                  //SizedBox(height: 16.0,),
                  SizedBox(height: 16.0,),
                  button(_goToPosition1,Icons.location_searching),
                  SizedBox(height: 16.0,),
                  button(_getCurrentLocation,Icons.my_location),

                ],
              ),
            ),

          )
        ],

      ),

    );
  }


}
