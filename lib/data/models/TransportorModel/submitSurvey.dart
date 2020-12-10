import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;


class SubmtiSurevy {
  String status;
  String token;
  String message;

  SubmtiSurevy({this.status, this.token, this.message});

  SubmtiSurevy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    data['message'] = this.message;
    return data;
  }
}

Future<SubmtiSurevy> submitSurevy({String surveyid,String userid , String fullname,
                               String address,String village , String postOffice , String thana , String country ,
                               String state , String distict , String pincode, String mobile , String gender , 
                               String productid , String qntity , String image , String lal , String long}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    {
    "surveys" : surveyid,
    "user": userid,
    "full_name": fullname,
    "address": address,
    "village": village,
    "post_office": postOffice,
    "thana": thana,
    "country": country,
    "state": state,
    "district": distict,
    "pincode": pincode,
    "mobile": mobile,
    "form_data": {"Gender": gender, "Color": "Red"},
    "product": productid,
    "qty": qntity,
    "image":  "data:image/png;base64, $image",
    "lat": lal,
    "lng": long
}
});
  final response = await http.post('http://139.59.75.40:4040/app/transporter-order-list',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return SubmtiSurevy.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}