import 'dart:convert';
import 'package:http/http.dart' as http;


class DistictList {
  String status;
  List<DistictResult> result;

  DistictList({this.status, this.result});

  DistictList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = new List<DistictResult>();
      json['result'].forEach((v) {
        result.add(new DistictResult.fromJson(v));
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

class DistictResult {
  int active;
  String sId;
  String state;
  String name;
  String stateName;
  String createdDate;

  DistictResult(
      {this.active,
      this.sId,
      this.state,
      this.name,
      this.stateName,
      this.createdDate});

  DistictResult.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    sId = json['_id'];
    state = json['state'];
    name = json['name'];
    stateName = json['state_name'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['_id'] = this.sId;
    data['state'] = this.state;
    data['name'] = this.name;
    data['state_name'] = this.stateName;
    data['created_date'] = this.createdDate;
    return data;
  }
}

Future<DistictList> fetchDistrictListModel(String id) async {
 
 var body = jsonEncode({
    "id" : id
});
  final response = await http.post('http://139.59.75.40:4040/app/district-list',body: body);
      print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return DistictList.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}