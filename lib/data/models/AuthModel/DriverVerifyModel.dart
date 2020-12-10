import 'dart:convert';
import 'package:http/http.dart' as http;


class DriverUserModel {
  String status;
  String message;
  String token;
  Result result;

  DriverUserModel({this.status, this.message, this.token, this.result});

  DriverUserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
  String userType;
  int active;
  String sId;
  String firstName;
  String lastName;
  String village;
  String postOffice;
  String thana;
  String state;
  String district;
  String pincode;
  String document;
  String mobile;
  String createdDate;
  String profileImage;
  Transpor transpor;

  Result(
      {this.userType,
      this.active,
      this.sId,
      this.firstName,
      this.lastName,
      this.village,
      this.postOffice,
      this.thana,
      this.state,
      this.district,
      this.pincode,
      this.document,
      this.mobile,
      this.createdDate,
      this.profileImage,
      this.transpor});

  Result.fromJson(Map<String, dynamic> json) {
    userType = json['user_type'];
    active = json['active'];
    sId = json['_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    village = json['village'];
    postOffice = json['post_office'];
    thana = json['thana'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    document = json['document'];
    mobile = json['mobile'];
    createdDate = json['created_date'];
    profileImage = json['profile_image'];
    transpor = json['transpor'] != null
        ? new Transpor.fromJson(json['transpor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_type'] = this.userType;
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['village'] = this.village;
    data['post_office'] = this.postOffice;
    data['thana'] = this.thana;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['document'] = this.document;
    data['mobile'] = this.mobile;
    data['created_date'] = this.createdDate;
    data['profile_image'] = this.profileImage;
    if (this.transpor != null) {
      data['transpor'] = this.transpor.toJson();
    }
    return data;
  }
}

class Transpor {
  Position position;
  int active;
  String sId;
  String state;
  String district;
  String name;
  String pincode;
  String orgType;
  String orgOtherType;
  String regNumber;
  String gstNumber;
  String bankName;
  String accountNumber;
  String ifsc;
  String createdDate;
  int iV;

  Transpor(
      {this.position,
      this.active,
      this.sId,
      this.state,
      this.district,
      this.name,
      this.pincode,
      this.orgType,
      this.orgOtherType,
      this.regNumber,
      this.gstNumber,
      this.bankName,
      this.accountNumber,
      this.ifsc,
      this.createdDate,
      this.iV});

  Transpor.fromJson(Map<String, dynamic> json) {
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    active = json['active'];
    sId = json['_id'];
    state = json['state'];
    district = json['district'];
    name = json['name'];
    pincode = json['pincode'];
    orgType = json['org_type'];
    orgOtherType = json['org_other_type'];
    regNumber = json['reg_number'];
    gstNumber = json['gst_number'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    ifsc = json['ifsc'];
    createdDate = json['created_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['state'] = this.state;
    data['district'] = this.district;
    data['name'] = this.name;
    data['pincode'] = this.pincode;
    data['org_type'] = this.orgType;
    data['org_other_type'] = this.orgOtherType;
    data['reg_number'] = this.regNumber;
    data['gst_number'] = this.gstNumber;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['ifsc'] = this.ifsc;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Position {
  String type;
  List<int> coordinates;

  Position({this.type, this.coordinates});

  Position.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}

Future<DriverUserModel> driverloginModel({
  String mobileNo,
  String otp,
}) async {
 
 var body = jsonEncode({
    "mobile": mobileNo,
    "otp" : otp
});
  final response = await http.post('http://139.59.75.40:4040/app/verify-driver',body: body);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DriverUserModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}