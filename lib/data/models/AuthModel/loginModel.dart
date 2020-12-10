import 'dart:convert';
import 'package:http/http.dart' as http;

// {
//     "status": "error",
//     "message": "Account is inactive"
// }
class GetOtpModel {
  String status;
  int oTP;
  String message;

  GetOtpModel({this.status, this.oTP, this.message});

  GetOtpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    oTP = json['OTP'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['OTP'] = this.oTP;
    data['message'] = this.message;
    return data;
  }
}
Future<GetOtpModel> fetchOtpModel({
  String mobileNo
}) async {
 
 var body = jsonEncode({
    "mobile": mobileNo
});
  final response = await http.post('http://139.59.75.40:4040/app/transporter-login',body: body);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return GetOtpModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
//8010265036

Future<GetOtpModel> fetchDriverOtpModel({
  String mobileNo
}) async {
 
 var body = jsonEncode({
    "mobile": mobileNo
});
  final response = await http.post('http://139.59.75.40:4040/app/driver-login',body: body);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return GetOtpModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}