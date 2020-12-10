import 'dart:async';
import 'dart:ui';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/theme.dart';
import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:io' show Platform;

import 'package:url_launcher/url_launcher.dart';

class TOrderTrack extends StatefulWidget {
  TOrderTrack({Key key}) : super(key: key);

  @override
  _TOrderTrackState createState() => _TOrderTrackState();
}

class _TOrderTrackState extends State<TOrderTrack> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController _otpFieldController = TextEditingController();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  
  AnimationController _loadingController;
  Animation<double> _loadingAnimation;

  @override
  void initState() {
    super.initState();
    _loadingController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _loadingAnimation =
        Tween<double>(begin: SizeConfig.safeBlockHorizontal*72, end: 5.0).animate(_loadingController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              print("Completed");
              openMaps();
            }
          });
  }
  openMaps() async{
    Platform platform = Platform();
    String origin="Chembur, Mumbai";  // lat,long like 123.34,68.56
String destination="Ghatkopar ,  Mumbai";
if (Platform.isAndroid) {
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              "https://www.google.com/maps/dir/?api=1&origin=" +
                  origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate"),
          package: 'com.google.android.apps.maps');
      intent.launch();
    }
    else {
        String url = "https://www.google.com/maps/dir/?api=1&origin=" + origin + "&destination=" + destination + "&travelmode=driving&dir_action=navigate";
        if (await canLaunch(url)) {
              await launch(url);
       } else {
            throw 'Could not launch $url';
       }
    }
  }
 
    _displayDialog(BuildContext context) async {
      final _formKey = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            title: Text(' '),
            content: Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              height: 115,
              width: double.infinity,
              color: AppColors.primaryColor,
              child: Form(
                  key: _formKey,
                  child: Column(
                  children: [
                    TextFormField(
                      controller: _otpFieldController,
                      textInputAction: TextInputAction.go,
                      keyboardType: TextInputType.numberWithOptions(),
                      style: TextStyle(
                                      fontFamily: 'Arial',
                                      color: AppColors.whiteColor,
                                      fontSize: 22
                                    ),
                      validator: (val){
                        if (val.trim().isEmpty) {
                          return 'Please enter the otp';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "OTP",
                        labelStyle: TextStyle(
                                         fontFamily: 'Shruti',
                                         fontWeight: FontWeight.w600,
                                         fontSize: 20,
                                         color: AppColors.textFeildcolor
                                       ),
                                       border: InputBorder.none,
                        ),
                    ),
                    Container(child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('CANCEL',
                style: TextStyle(
                                       fontFamily: 'Shruti',
                                       fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: Colors.pink[800]
                                     ),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('CONFIRM',
                style: TextStyle(
                                       fontFamily: 'Shruti',
                                       fontWeight: FontWeight.w600,
                                       fontSize: 17,
                                       color: Colors.pink[800]
                                     ),
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.of(context).pop();
                 
                  }
                },
              )
            ],
          );
        });
  }
 

  
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            actionsIconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            iconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            title: Text('Order Details',style: TextStyle(
              fontFamily: 'Shruti',
              color: AppColors.whiteColor,
              fontSize: 22
            ),),
            backgroundColor: AppColors.primaryColor,
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
              IconButton(icon: Icon(Icons.refresh), onPressed: (){}),
            ],
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            //padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: SizeConfig.safeBlockVertical*63,
                  child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
           ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('₹ 0',style: TextStyle(
                      fontSize: 22,
                      color: AppColors.whiteColor
                     ),),
                     Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: AnimatedBuilder(animation: _loadingAnimation,
                       builder: (context,child){
                         return Container(
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 55,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(40)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                  onTap: (){
                                  _loadingController.forward();
                                        },
                                     child: Padding(
                                      padding: const EdgeInsets.only(right : 20.0),
                                      child: Text('Start',style: TextStyle(
                                        fontFamily: 'Shruti',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18
                                      ),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: _loadingAnimation.value,
                              bottom: 5,
                               child: Container(
                                decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(40)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left : 8.0,right: 8.0),
                                child: Icon(Icons.forward_sharp,color: AppColors.whiteColor,size: 40,),
                              ),
                              ))
                          ],
                        ),
                      );
                       })
                     ),
                      Padding(
                          padding: EdgeInsets.only(top: 10),
                                           child: Container(
                                             width: double.infinity,
                                             height: 50,
                                             child: RaisedButton(
                                               shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(10)
                                               ),
                                               color: Colors.white,
                                               child: Text('DELIVERED',
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 22,
                                                   color: AppColors.darkColor
                                                 ),
                                               ),
                                               onPressed: (){
                                                 _displayDialog(context);
                                               }),
                                           ),
                                           )
                                        ],
                           ),
                      ), 
              ],
            ),
          
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Card(
                color: Colors.orange[300],
                child: Column(
                  children: [
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Container(
                                height: 15,
                                width: 15,
                                margin: EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  shape: BoxShape.circle
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('23,Shreehari tower,Mira park',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Arial'
                                  ),),
                                  Text('Pin : 363625',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Arial'
                                  ),),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Padding(
                                 padding: const EdgeInsets.only(top : 8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.call),
                                    Text('  123456789',
                                    style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Arial'
                                          ),)
                                  ],
                                ),
                              ),
                               Padding(
                                 padding: const EdgeInsets.only(top : 8.0),
                                 child: Row(
                                  children: [
                                    Icon(Icons.person),
                                    Text('   username',
                                    style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Arial'
                                          ),)
                                  ],
                              ),
                            ),
                             Padding(
                                 padding: const EdgeInsets.only(top : 8.0),
                                 child: Row(
                                  children: [
                                    Icon(Icons.assignment),
                                    Text('   2020-03-14',
                                    style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Arial'
                                          ),)
                                  ],
                              ),
                            ),
                            ],
                          ),
                        )
                  ],
                ),
              ) ),
          ],
        ),

                        ]))));})))
    );
  }
}