import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

class DeleteDriverModel {
  String status;
  String message;
  String token;

  DeleteDriverModel({this.status, this.message, this.token});

  DeleteDriverModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    return data;
  }
}

Future<DeleteDriverModel> deleteDriverModel(String id) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "id": id
    //"id" : Global.loginModel.result.sId
});
  final response = await http.post('http://139.59.75.40:4040/app/delete-driver',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DeleteDriverModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

Future<DeleteDriverModel> deleteVehicleModel(String id) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "id": id
    //"id" : Global.loginModel.result.sId
});
  final response = await http.post('http://139.59.75.40:4040/app/delete-vehicle',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DeleteDriverModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}