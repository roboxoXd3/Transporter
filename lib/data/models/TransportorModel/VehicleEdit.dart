import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;


class Updatevehicle {
  String status;
  String message;
  String token;

  Updatevehicle({this.status, this.message, this.token});

  Updatevehicle.fromJson(Map<String, dynamic> json) {
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

Future<Updatevehicle> editVehicleModel({String id ,String name,String number,String rcNo,String rcImage,String pucImage,String vDataImage}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "id": id,
    "name": name,
    "number": number,
    "rc_number": rcNo,
    "rc_data": "data:image/png;base64, $rcImage",
    "poluction_data": "data:image/png;base64, $pucImage",
    "v_data": "data:image/png;base64, $vDataImage"
   });
  print(body);
  final response = await http.post('http://139.59.75.40:4040/app/update-vehicle',body: body,headers: header);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return Updatevehicle.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}