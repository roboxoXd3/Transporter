import 'dart:convert';
import 'package:http/http.dart' as http;

class TransporterList {
  String status;
  Result result;

  TransporterList({this.status, this.result});

  TransporterList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Result {
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

  Result(
      {this.active,
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

  Result.fromJson(Map<String, dynamic> json) {
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

Future<TransporterList> fetchTransporterListModel() async {
 
  final response = await http.post('http://139.59.75.40:4040/app/transporter-list');
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TransporterList.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}
