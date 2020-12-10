import 'dart:async';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapsScreen extends StatefulWidget {
  MapsScreen({Key key}) : super(key: key);

  @override
  _MapsScreenState createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
 
  TextEditingController _otpFieldController = TextEditingController();
  PermissionHandler _permission;
  // Object for PolylinePoints
  PolylinePoints polylinePoints;
  // List of coordinates to join
  List<LatLng> polylineCoordinates = [];
  // Map storing polylines created by connecting
  // two points
  Map<PolylineId, Polyline> polylines = {};
  BitmapDescriptor arrivalLocationIcon;
  BitmapDescriptor deliveryIcon;
  BitmapDescriptor startingLocationIcon;
  Set<Marker> _markers = {};
  GoogleMapController mapController;
  //GoogleMapController mapController;
  LatLng _startingLocationPosition = LatLng(0.0, 0.0);
  LatLng _arrivalLocationPosition = LatLng(0.0, 0.0);
  LatLng _deliveryPosition = LatLng(0.0, 0.0);
//CameraPosition initialLocation;
   CameraPosition initialLocation = CameraPosition(target: LatLng(0.0, 0.0));
  @override
  void initState() {
    super.initState();
    setPermissions();
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5,size: Size(100, 100)), 'assets/images/truck.png',)
        .then((onValue) {
      deliveryIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5,size: Size(20, 20)), 'assets/images/icons/TRUCK.png')
        .then((onValue) {
      arrivalLocationIcon = onValue;
    });
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(devicePixelRatio: 2.5,size: Size(20, 20)), 'assets/images/icons/TRUCK.png')
        .then((onValue) {
      startingLocationIcon = onValue;
    });
   initData();
  }

  void setPermissions() async{
   Map<PermissionGroup, PermissionStatus> permissions = 
   await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }
  initData() async{
   // List<Placemark> deliveryPlacemark = await Geolocator().placemarkFromAddress('Tilaknagar,Mumbai');
    _deliveryPosition = LatLng(Global.assignmentDetails.endingPosition.coordinates[0].toDouble(),
        Global.assignmentDetails.endingPosition.coordinates[1].toDouble());
    //List<Placemark> startingPlacemark = await Geolocator().placemarkFromAddress('Chembur,Mumbai');
    _startingLocationPosition =  LatLng(Global.assignmentDetails.startingPosition.coordinates[0].toDouble(),
        Global.assignmentDetails.startingPosition.coordinates[0].toDouble());
    //List<Placemark> arrivalPlacemark = await Geolocator().placemarkFromAddress('Ghatkoper,Mumbai');
    _arrivalLocationPosition =  LatLng(Global.assignmentDetails.position.coordinates[0].toDouble(),
        Global.assignmentDetails.position.coordinates[0].toDouble());
       mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _startingLocationPosition, zoom: 14),
          ),
     );
        _markers.add(Marker(
            markerId: MarkerId('arrival'),
            position: _arrivalLocationPosition,
             infoWindow: InfoWindow(
    title: 'Destination',
    snippet: 'adassad',
  ),
            icon: BitmapDescriptor.defaultMarker));
        _markers.add(Marker(
            markerId: MarkerId('starting'),
            position: _startingLocationPosition,
             infoWindow: InfoWindow(
    title: 'Destination',
    snippet: 'zsczcxzc',
  ),
      icon: BitmapDescriptor.defaultMarker));
        _markers.add(Marker(
            markerId: MarkerId('delivery'),
            position: _deliveryPosition,
            icon: deliveryIcon));
   

     setState(() {
       
     });
     _createPolylines(Position(
       latitude: Global.assignmentDetails.startingPosition.coordinates[0].toDouble(),
       longitude: Global.assignmentDetails.startingPosition.coordinates[1].toDouble()),
       Position(
       latitude: Global.assignmentDetails.endingPosition.coordinates[0].toDouble(),
       longitude: Global.assignmentDetails.endingPosition.coordinates[1].toDouble())
       );
        await updateCameraLocation(
       LatLng(Global.assignmentDetails.startingPosition.coordinates[0].toDouble(),
            Global.assignmentDetails.startingPosition.coordinates[1].toDouble()),
        LatLng(Global.assignmentDetails.endingPosition.coordinates[0].toDouble(),
            Global.assignmentDetails.endingPosition.coordinates[1].toDouble()),
        mapController);
  } 

  
  Future<void> updateCameraLocation(
    LatLng source,
    LatLng destination,
    GoogleMapController mapController,
  ) async {
    if (mapController == null) return;

    LatLngBounds bounds;

    if (source.latitude > destination.latitude &&
        source.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: source);
    } else if (source.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(source.latitude, destination.longitude),
          northeast: LatLng(destination.latitude, source.longitude));
    } else if (source.latitude > destination.latitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitude, source.longitude),
          northeast: LatLng(source.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: source, northeast: destination);
    }

    CameraUpdate cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 150);
   setState(() {
       
     });
    return checkCameraLocation(cameraUpdate, mapController);
  }

  Future<void> checkCameraLocation(
      CameraUpdate cameraUpdate, GoogleMapController mapController) async {
    mapController.animateCamera(cameraUpdate);
    LatLngBounds l1 = await mapController.getVisibleRegion();
    LatLngBounds l2 = await mapController.getVisibleRegion();
    
    if (l1.southwest.latitude == -90 || l2.southwest.latitude == -90) {
      return checkCameraLocation(cameraUpdate, mapController);
    }
    
    setState(() {});
  }
  
   _createPolylines(Position start, Position destination) async {
  // Initializing PolylinePoints
  polylinePoints = PolylinePoints();

  // Generating the list of coordinates to be used for
  // drawing the polylines
  PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
    'AIzaSyDeG4wkHz2fjzttTvepLQZC_Dx0_GEupo4', // Google Maps API Key 
    PointLatLng(start.latitude, start.longitude),
    PointLatLng(destination.latitude, destination.longitude),
    travelMode: TravelMode.transit,
  ).catchError((onError){
    print(onError);
  });

  // Adding the coordinates to the list
  if (result.points.isNotEmpty) {
    result.points.forEach((PointLatLng point) {
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    });
  }

  // Defining an ID
  PolylineId id = PolylineId('poly');

  // Initializing Polyline
  Polyline polyline = Polyline(
    polylineId: id,
    color: Colors.red,
    points: polylineCoordinates,
    width: 3,
  );

  // Adding the polyline to the map
  polylines[id] = polyline;
  setState(() {});
}


  Future<void> _launched;

  String _phone = Global.assignmentDetails.driver.mobile;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: Text('Maps',style: TextStyle(
              fontFamily: 'Arial',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22
            ),),
            backgroundColor: AppColors.primaryColor,
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              width: double.infinity,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                  Stack(
                    children: [
                      Container(
                      height: SizeConfig.safeBlockVertical * 90,
                      child: GoogleMap(
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      scrollGesturesEnabled: true,
                      myLocationButtonEnabled: true,
                      mapType: MapType.normal,
                      markers: _markers,
                      polylines: Set<Polyline>.of(polylines.values),
                      initialCameraPosition: initialLocation,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
           ),
          ), 
          Positioned(
            bottom: 15,
            right: 15,
            left: 15,
           child: Container(
             decoration: BoxDecoration(
               color: AppColors.whiteColor,
               borderRadius: BorderRadius.circular(15)
             ),
             child: Padding(
               padding: const EdgeInsets.all(12.0),
               child: Column(
                 children: [
                   Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      //  Image.asset('assets/images/icons/TRUCK.png',height: 45,width: 45,),
                      //  SizedBox(width: 10,),
                      //  Expanded(
                      //           child: Text('${Global.assignmentDetails.driver.}',style: TextStyle(
                      //                        fontFamily: 'Arial',
                      //                        fontWeight: FontWeight.w500,
                      //                        fontSize: 20,
                      //                        color: AppColors.darkColor
                      //         ),),
                      //  ),
                       Container(
                         padding: EdgeInsets.all(2),
                         decoration: BoxDecoration(
                           shape: BoxShape.circle,
                           color: Colors.black
                         ),
                         child: Icon(Icons.person,size: 25,color: AppColors.whiteColor,)),
                       SizedBox(width: 10,),
                       Expanded(
                                child: Text('   ${Global.assignmentDetails.driver.firstName} ${Global.assignmentDetails.driver.lastName}',style: TextStyle(
                                             fontFamily: 'Arial',
                                             fontWeight: FontWeight.w500,
                                             fontSize: 20,
                                             color: AppColors.darkColor
                              ),),
                       ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                                        _launched = _makePhoneCall('tel:$_phone');
                                      });
                          },
                          child: Image.asset('assets/images/icons/call-icon.png',height: 35,width: 35,)),
                     ],
                   ),
                  //   Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //    children: [
                  //      Container(
                  //        padding: EdgeInsets.all(2),
                  //        decoration: BoxDecoration(
                  //          shape: BoxShape.circle,
                  //          color: Colors.black
                  //        ),
                  //        child: Icon(Icons.person,size: 25,color: AppColors.whiteColor,)),
                  //      SizedBox(width: 10,),
                  //      Expanded(
                  //               child: Text('   ${Global.assignmentDetails.driver.firstName} ${Global.assignmentDetails.driver.lastName}',style: TextStyle(
                  //                            fontFamily: 'Arial',
                  //                            fontWeight: FontWeight.w500,
                  //                            fontSize: 20,
                  //                            color: AppColors.darkColor
                  //             ),),
                  //      ),
                  //    ],
                  //  ),
                   Padding(
                     padding: const EdgeInsets.only(top : 10.0),
                     child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Image.asset('assets/images/icons/call-icon.png',height: 30,width: 30,),
                         SizedBox(width: 10,),
                         Expanded(
                                  child: Text('   ${Global.assignmentDetails.driver.mobile}',style: TextStyle(
                                               fontFamily: 'Arial',
                                               fontWeight: FontWeight.w500,
                                               fontSize: 20,
                                               color: AppColors.darkColor
                                ),),
                         ),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.only(top : 5.0),
                     child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                        Icon(Icons.location_on,color: Colors.red,),
                         SizedBox(width: 10,),
                         Expanded(
                                  child: Text('    ${Global.assignmentDetails.driver.address}',style: TextStyle(
                                               fontFamily: 'Arial',
                                               fontWeight: FontWeight.w500,
                                               fontSize: 20,
                                               color: Colors.green[300]
                                ),),
                         ),
                         Image.asset('assets/images/icons/help-icon.png',height: 35,width: 35,),
                       ],
                     ),
                   ),
                 ],
               ),
             ),
           ),
          )
                    ],
                  ),
                        ]))));})))
    );
  }
}