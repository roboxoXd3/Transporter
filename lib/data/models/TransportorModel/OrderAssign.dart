import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;


class TransportorOrderAssign {
  String status;
  String message;
  String token;

  TransportorOrderAssign({this.status, this.message, this.token});

  TransportorOrderAssign.fromJson(Map<String, dynamic> json) {
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

Future<TransportorOrderAssign> assignOrderModel({String orderid,String driverid,String vehicelid}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "order": orderid,
    "driver": driverid,
    "vehicle": vehicelid
});
  final response = await http.post('http://139.59.75.40:4040/app/transporter-assign-driver',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TransportorOrderAssign.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}