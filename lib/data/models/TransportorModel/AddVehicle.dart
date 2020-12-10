import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

class AddVehicleModel {
  String status;
  String message;
  Data data;
  String token;

  AddVehicleModel({this.status, this.message, this.data, this.token});

  AddVehicleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class Data {
  int active;
  String transporter;
  int deleted;
  String sId;
  String name;
  String number;
  String rcNumber;
  String rcImage;
  String vImage;
  String poluctionImage;
  int iV;

  Data(
      {this.active,
      this.transporter,
      this.deleted,
      this.sId,
      this.name,
      this.number,
      this.rcNumber,
      this.rcImage,
      this.vImage,
      this.poluctionImage,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    transporter = json['transporter'];
    deleted = json['deleted'];
    sId = json['_id'];
    name = json['name'];
    number = json['number'];
    rcNumber = json['rc_number'];
    rcImage = json['rc_image'];
    vImage = json['v_image'];
    poluctionImage = json['poluction_image'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['transporter'] = this.transporter;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['number'] = this.number;
    data['rc_number'] = this.rcNumber;
    data['rc_image'] = this.rcImage;
    data['v_image'] = this.vImage;
    data['poluction_image'] = this.poluctionImage;
    data['__v'] = this.iV;
    return data;
  }
}

Future<AddVehicleModel> addVehicleModel({String name,String number,String rcNo,String rcImage,String pucImage,String vDataImage}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 var body = jsonEncode({
    "id": Global.loginModel.result.sId,
    "name": name,
    "number": number,
    "rc_number": rcNo,
    "rc_data": "data:image/png;base64, $rcImage",
    "poluction_data": "data:image/png;base64, $pucImage",
    "v_data": "data:image/png;base64, $vDataImage"
   });
  final response = await http.post('http://139.59.75.40:4040/app/add-vehicle',body: body,headers: header);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return AddVehicleModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}