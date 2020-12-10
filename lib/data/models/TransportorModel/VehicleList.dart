import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;


class VehicleListModel {
  String status;
  String token;
  List<VehicleListResult> result;

  VehicleListModel({this.status, this.token, this.result});

  VehicleListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    if (json['result'] != null) {
      result = new List<VehicleListResult>();
      json['result'].forEach((v) {
        result.add(new VehicleListResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['token'] = this.token;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VehicleListResult {
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

  VehicleListResult(
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

  VehicleListResult.fromJson(Map<String, dynamic> json) {
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


Future<VehicleListModel> fetchVehicleList() async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 var body = jsonEncode({
    //"id": "5f67664ae6c5ac2c5c9f4576"
    "id" : Global.loginModel.result.sId
});
  final response = await http.post('http://139.59.75.40:4040/app/vehicle-list',body: body,headers: header);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return VehicleListModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}