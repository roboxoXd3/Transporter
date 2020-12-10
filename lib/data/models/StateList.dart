import 'dart:convert';
import 'package:http/http.dart' as http;


class StateList {
  String status;
  List<Result> result;

  StateList({this.status, this.result});

  StateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int active;
  String sId;
  String name;
  String createdDate;

  Result({this.active, this.sId, this.name, this.createdDate});

  Result.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    sId = json['_id'];
    name = json['name'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['created_date'] = this.createdDate;
    return data;
  }
}

Future<StateList> fetchStateListModel() async {
 
  final response = await http.post('http://139.59.75.40:4040/app/state-list');
       print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
   

    return StateList.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}