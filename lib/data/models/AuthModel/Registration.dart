import 'dart:convert';
import 'package:http/http.dart' as http;

// {
//     "status": "error",
//     "message": "Phone number alreday in use."
// }

class Registration {
  String status;
  String message;
  Data data;
  int oTP;

  Registration({this.status, this.message, this.data, this.oTP});

  Registration.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    oTP = json['OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['OTP'] = this.oTP;
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
  String village;
  String postOffice;
  String thana;
  String state;
  String district;
  String pincode;
  String document;
  String documentImage;
  String mobile;
  String userType;
  String master;
  String masterName;
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
      this.village,
      this.postOffice,
      this.thana,
      this.state,
      this.district,
      this.pincode,
      this.document,
      this.documentImage,
      this.mobile,
      this.userType,
      this.master,
      this.masterName,
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
    village = json['village'];
    postOffice = json['post_office'];
    thana = json['thana'];
    state = json['state'];
    district = json['district'];
    pincode = json['pincode'];
    document = json['document'];
    documentImage = json['document_image'];
    mobile = json['mobile'];
    userType = json['user_type'];
    master = json['master'];
    masterName = json['master_name'];
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
    data['village'] = this.village;
    data['post_office'] = this.postOffice;
    data['thana'] = this.thana;
    data['state'] = this.state;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['document'] = this.document;
    data['document_image'] = this.documentImage;
    data['mobile'] = this.mobile;
    data['user_type'] = this.userType;
    data['master'] = this.master;
    data['master_name'] = this.masterName;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}

Future<Registration> resgistrationModel({
  String transporter,
  String fname,String lname,String email,String gender,String dob,String fathername,String address,
  String village,String postoffice,String thana,String country,String state,String distict,String pincode,
  String occupation,String document,String mobile,String docimage
}) async {
 
 var body = jsonEncode({
    "transporter": transporter,
    "first_name": fname,
    "last_name": lname,
    "email": email,
    "gender": gender,
    "dob": dob,
    "father_name": fathername,
    "address1": address,
    "village": village,
    "post_office": postoffice,
    "thana": thana,
    "country": country,
    "state": state,
    "district": distict,
    "pincode": pincode,
    "occupation": occupation,
    "document": document,
    "mobile": mobile,
    "document_image": "data:image/png;base64, $docimage"
});
  final response = await http.post('http://139.59.75.40:4040/app/transporter-register',body: body);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return Registration.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}