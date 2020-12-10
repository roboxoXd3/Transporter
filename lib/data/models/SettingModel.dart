
import 'dart:convert';
import 'package:http/http.dart' as http;

class SettingModel {
  String status;
  List<Data> data;

  SettingModel({this.status, this.data});

  SettingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String sId;
  String name;
  String value;

  Data({this.sId, this.name, this.value});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}

Future<SettingModel> fetchSettingModel() async {
 
  final response = await http.post('http://139.59.75.40:4040/app/settings');
       print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
   

    return SettingModel.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}