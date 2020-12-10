import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

class UpdateTransportorProfile {
  String status;
  String message;
  Data data;
  String token;

  UpdateTransportorProfile({this.status, this.message, this.data, this.token});

  UpdateTransportorProfile.fromJson(Map<String, dynamic> json) {
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

  Data(
      {this.active,
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
      this.profileImage});

  Data.fromJson(Map<String, dynamic> json) {
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    return data;
  }
}

Future<UpdateTransportorProfile> updatedriverProfile({String fname,String lastname ,
 String email , String gender, String dob , String fathername , String address , String village, 
 String postoffice , String thana , String state , String district , String pincode , String occupation,
 String document , String mobile , String profileImage,String id}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "first_name": fname,
    "last_name": lastname,
    "email": email,
    "gender": gender,
    "dob": dob,
    "father_name": fathername,
    "address1": address,
    "village": village,
    "post_office": postoffice,
    "thana": thana,
    "state": state,
    "district": district,
    "pincode": pincode,
    "occupation": occupation,
    "document": document,
    "mobile": mobile,
    "profile_image": "data:image/png;base64,  iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
    "id": id
});
print(body);
  final response = await http.post('http://139.59.75.40:4040/app/update-profile',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return UpdateTransportorProfile.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}