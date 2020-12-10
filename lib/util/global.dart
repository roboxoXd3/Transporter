import 'package:Transporter/data/models/AuthModel/DriverVerifyModel.dart';
import 'package:Transporter/data/models/AuthModel/UserDataModel.dart';
import 'package:Transporter/data/models/AuthModel/VerifyModel.dart';
import 'package:Transporter/data/models/DriverModel/DriverOrderList.dart';
import 'package:Transporter/data/models/SettingModel.dart';
import 'package:Transporter/data/models/TransportorModel/TransporterSurvey.dart';
import 'package:Transporter/data/models/TransportorModel/TransportorOrderList.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Transporter/data/models/TransportorModel/VehicleList.dart';

class Global{
  static bool isLoading = false;
  static String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJtb2JpbGUiOiI4NDQyOTIyMzk5IiwiaWF0IjoxNjA0NDgyMjM2LCJleHAiOjE2MDQ2NjIyMzZ9.HyNbRsfIZJ32cn21SjTflAxjXJM73TbSSPCexL1lLTw';
  static UserDataModel userDataModel; 
  static LoginModel loginModel ;
  static DriverUserModel driverUserModel;
  static OrderListResult assignmentDetails ;
  static DriverOrderResult driverOrderResult;
  static SharedPreferences prefs;
  static VehicleListResult editvehicledata;
  static String signupno = '';
  static SettingModel settingModel = SettingModel();
  static SurveyProducts transporterSurveyList;
}