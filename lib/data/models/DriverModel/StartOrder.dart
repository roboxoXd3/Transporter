import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

class StartOrder {
  String status;
  String message;

  StartOrder({this.status, this.message});

  StartOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

Future<StartOrder> starDriverOrder({String driverid , String oderid}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
      "driver": driverid,
      "order": oderid
});
  final response = await http.post('http://139.59.75.40:4040/app/tranporter-driver-start-order',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return StartOrder.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}