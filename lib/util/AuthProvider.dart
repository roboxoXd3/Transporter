import 'dart:convert';
import 'package:Transporter/data/models/AuthModel/DriverVerifyModel.dart';
import 'package:Transporter/data/models/AuthModel/VerifyModel.dart';
import 'package:Transporter/util/global.dart';

class AuthProvider {
  LoginModel _transporterloginModel;
  DriverUserModel _driverUserModel;
  String _token;

  ////Set data 
  Future setuserType({String key = 'userType',String value}){
   return Global.prefs.setString(key, value);
  }
  Future settoken({String key = 'token',String value}){
   return Global.prefs.setString(key, value);
  }

  Future settransportorData ({String key = 'transportor' , LoginModel user}){
    if (user!=null) {
      this._transporterloginModel = user;
      String userJson = json.encode(_transporterloginModel.toJson());
      
      setuserType(value: 'transportor');
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }


  Future setDriverData ({String key = 'driver' , DriverUserModel user}){
    if (user!=null) {
      this._driverUserModel = user;
      String userJson = json.encode(_driverUserModel.toJson());
      
      setuserType(value: 'driver');
      return Global.prefs.setString(key, userJson);
    }
    return Global.prefs.setString(key, null);
  }
  ///get data 
  String getUserType({String key = 'userType'}){
    print(Global.prefs.getString(key));
    if (Global.prefs.getString(key) != null) {
      return Global.prefs.getString(key);
    }
    return null;
  }
    String gettoken({String key = 'token'}){
    print(Global.prefs.getString(key));
    if (Global.prefs.getString(key) != null) {
      return Global.prefs.getString(key);
    }
    return null;
  }
   LoginModel gettransportorData ({String key = 'transportor'}){
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _transporterloginModel = LoginModel.fromJson(userObj);
      
      return _transporterloginModel;
    }
    return null;
  }
   
 DriverUserModel getDriverData ({String key = 'driver'}){
    String userJson = Global.prefs.getString(key);
    if (userJson != null) {
      Map userObj = json.decode(userJson);
      _driverUserModel = DriverUserModel.fromJson(userObj);
      return _driverUserModel;
    }
    return null;
  }

  //Delete Sp 
  Future deleteUserType ({String key = 'userType'}){
     return Global.prefs.setString(key, null);
  }
  Future deletetoken({String key = 'token'}){
     return Global.prefs.setString(key, null);
  }
  Future deletetransportorData ({String key = 'transportor'}){
    return Global.prefs.setString(key, null);
  }
  Future deletedriverData ({String key = 'driver'}){
    return Global.prefs.setString(key, null);
  }
}