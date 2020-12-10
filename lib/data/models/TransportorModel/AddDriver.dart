import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

// {
//     "status": "error",
//     "message": "Mobile is already in use."
// }

class AddDriverModel {
  String status;
  String message;
  Data data;
  String token;

  AddDriverModel({this.status, this.message, this.data, this.token});

  AddDriverModel.fromJson(Map<String, dynamic> json) {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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

Future<AddDriverModel> addDriverModel({String fname,String lname,
String mobileNo,String email,String gender,String dob,String fathername , String address,
String village,String postoffice,String thana,String country, String statename, String districtname,
String pincode , String occupation ,String doucment , String licenceno , String documentimage , String profileimage}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "id": "5f89cce7b188c83dd6eb2000",
    "first_name": fname,
    "last_name": lname,
    "email": email,
    "gender": gender,
    "dob": dob,
    "father_name": fathername,
    "address": address,
    "village": village,
    "post_office": postoffice,
    "thana": thana,
    "country": country,
    "state_name": statename,
    "district_name": districtname,
    "pincode": pincode,
    "occupation": occupation,
    "document": doucment,
    "mobile": mobileNo,
    "licence_number": licenceno,
     "document_image_data": "data:image/png;base64, $documentimage",
    "image_data": "data:image/png;base64, $profileimage"
});
print(body);
  final response = await http.post('http://139.59.75.40:4040/app/add-driver',body: body,headers: header);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return AddDriverModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}