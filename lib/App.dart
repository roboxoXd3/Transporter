import 'package:Transporter/data/models/SettingModel.dart';
import 'package:Transporter/screens/AddEmployee/AddEmployee.dart';
import 'package:Transporter/screens/AddEmployee/AddEmployeeDetails.dart';
import 'package:Transporter/screens/Contact.dart';
import 'package:Transporter/screens/Driver/editProfile.dart';
import 'package:Transporter/screens/Faq.dart';
import 'package:Transporter/screens/GroceryDelivery/OrderDetails.dart';
import 'package:Transporter/screens/History/History.dart';
import 'package:Transporter/screens/HomeScreens/DriverHomeScreen.dart';
import 'package:Transporter/screens/HomeScreens/HomeSreen.dart';
import 'package:Transporter/screens/Maps/MapsScreen.dart';
import 'package:Transporter/screens/TermsPrivacy.dart';
import 'package:Transporter/screens/Transporter/AssignScreen.dart';
import 'package:Transporter/screens/Transporter/OrderTrack.dart';
import 'package:Transporter/screens/Transporter/TContact.dart';
import 'package:Transporter/screens/Transporter/TFaq.dart';
import 'package:Transporter/screens/Transporter/THistory.dart';
import 'package:Transporter/screens/Transporter/Tabout.dart';
import 'package:Transporter/screens/Transporter/Tsurvey.dart';
import 'package:Transporter/screens/Transporter/TtermsPrivacy.dart';
import 'package:Transporter/screens/Transporter/TupdateProfile.dart';
import 'package:Transporter/screens/Transporter/VehicleEdit.dart';
import 'package:Transporter/screens/Transporter/submitSurveyPage.dart';
import 'package:Transporter/screens/UpdateProfile/UpdateProfile.dart';
import 'package:Transporter/screens/VehicleList/AddVehicle.dart';
import 'package:Transporter/screens/VehicleList/Vehiclelist.dart';
import 'package:Transporter/screens/about.dart';
import 'package:Transporter/screens/auth/Login.dart';
import 'package:Transporter/screens/auth/Signup.dart';
import 'package:Transporter/screens/auth/SignupDetails.dart';
import 'package:Transporter/screens/surevey.dart';
import 'package:Transporter/util/AuthProvider.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/GroceryDelivery/Grocerydetails.dart';


class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  AuthProvider authProvider = AuthProvider();
  Widget _defaultHome = Login();
  String userType = '';

  @override
  void initState() {
    super.initState();
    initdata();
    SharedPreferences.getInstance().then((value) { 
      Global.prefs = value;
      checkUserType();
      });
  }
  initdata(){
    fetchSettingModel().then((value) {
      if (value.status == 'success') {
        Global.settingModel = value;
      }
    });
  }
  void checkUserType(){
   if (authProvider.getUserType() != null) {
     userType = authProvider.getUserType();
   }
   if (userType != null) {
     if (userType == 'driver') {
       Global.driverUserModel = authProvider.getDriverData();
       Global.accessToken = authProvider.gettoken();
       setState(() => _defaultHome = DriverHomeScreen());
     } else if(userType == 'transportor'){
       Global.loginModel = authProvider.gettransportorData();
       Global.accessToken = authProvider.gettoken();
       setState(() => _defaultHome = HomeScreen());
     }
   }
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:  appTheme(),
      routes: <String,WidgetBuilder>{
        'login' : (BuildContext context) => Login(),
        'signup' : (BuildContext context) => Signup(),
        'signupdetails' : (BuildContext context) => SignupDetails(),
        'grocerydetails': (BuildContext context) => GroceryDetails(),
        'orderdetails': (BuildContext context) => OrderDetails(),
        'vehiclelist': (BuildContext context) => VehicleList(),
        'addvehicle': (BuildContext context) => AddVehicle(),
        'addemployee': (BuildContext context) => AddEmployee(),
        'addemployeedetails': (BuildContext context) => AddEmployeeDetails(),
        'mapsscreen': (BuildContext context) => MapsScreen(),
        'updateprofile': (BuildContext context) => UpdateProfile(),
        'homescreen' : (BuildContext context) => HomeScreen(),
        'historylist': (BuildContext context) => HistoryList(),
        'survey': (BuildContext context) => Survey(),
        'about': (BuildContext context) => About(),
        'contact': (BuildContext context) => Contact(),
        'termsprivacy': (BuildContext context) => TermsPrivacy(),
        'driverHomescreen': (BuildContext context) => DriverHomeScreen(),
        'faq': (BuildContext context) => FaQ(),
        'AssignOrderScreen' : (BuildContext context) => AssignOrderScreen(),
        //Transporter 
        'TSurvey': (BuildContext context) => TSurvey(),
        'TAbout' : (BuildContext context) => TAbout(),
        'TContact': (BuildContext context) => TContact(),
        'TTermsPrivacy': (BuildContext context) => TTermsPrivacy(),
        'TFaQ': (BuildContext context) => TFaQ(),
        'TOrderTrack' : (BuildContext context) => TOrderTrack(),
        'THistoryList': (BuildContext context) => THistoryList(),
        'VehicleUpdate' : (BuildContext context) => VehicleUpdate(),
        //Driver 
        'editdriverprofile' : (BuildContext context) => EditDriverProfile(),
        'edittransportorprofile' : (BuildContext context) => EditTransportorProfile(),
        'submitsurveyform' : (BuildContext context) => SubmitSurveyForm(),
      },
      home: _defaultHome,
    );
  }
}