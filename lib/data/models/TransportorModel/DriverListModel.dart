import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

class DriverListModel {
  String status;
  String token;
  List<DriverResult> result;

  DriverListModel({this.status, this.token, this.result});

  DriverListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    if (json['result'] != null) {
      result = new List<DriverResult>();
      json['result'].forEach((v) {
        result.add(new DriverResult.fromJson(v));
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

class DriverResult {
  int active;
  int otp;
  int verified;
  int deleted;
  String sId;
  String firstName;
  String lastName;
  String email;
  String mobile;
  String userType;
  String state;
  String district;
  String pincode;
  String master;
  String masterName;
  String address;
  String village;
  String postOffice;
  String thana;
  String licenceNumber;
  String document;
  String documentImage;
  String profileImage;
  String createdDate;
  int iV;

  DriverResult(
      {this.active,
      this.otp,
      this.verified,
      this.deleted,
      this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.mobile,
      this.userType,
      this.state,
      this.district,
      this.pincode,
      this.master,
      this.masterName,
      this.address,
      this.village,
      this.postOffice,
      this.thana,
      this.licenceNumber,
      this.document,
      this.documentImage,
      this.profileImage,
      this.createdDate,
      this.iV});

  DriverResult.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    otp = json['otp'];
    verified = json['verified'];
    deleted = json['deleted'];
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    mobile = json['mobile'];
    userType = json['user_type'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    master = json['master'];
    masterName = json['master_name'];
    address = json['address'];
    village = json['village'];
    postOffice = json['post_office'];
    thana = json['thana'];
    licenceNumber = json['licence_number'];
    document = json['document'];
    documentImage = json['document_image'];
    profileImage = json['profile_image'];
    createdDate = json['created_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['otp'] = this.otp;
    data['verified'] = this.verified;
    data['deleted'] = this.deleted;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['user_type'] = this.userType;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['master'] = this.master;
    data['master_name'] = this.masterName;
    data['address'] = this.address;
    data['village'] = this.village;
    data['post_office'] = this.postOffice;
    data['thana'] = this.thana;
    data['licence_number'] = this.licenceNumber;
    data['document'] = this.document;
    data['document_image'] = this.documentImage;
    data['profile_image'] = this.profileImage;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}

Future<DriverListModel> fetchDriverList() async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "id": "5f89cce7b188c83dd6eb2000"
    //"id" : Global.loginModel.result.sId
});
  final response = await http.post('http://139.59.75.40:4040/app/get-driver-list',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DriverListModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}