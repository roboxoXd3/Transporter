import 'dart:convert';
import 'package:Transporter/util/global.dart';
import 'package:http/http.dart' as http;

//OrderListResult
class TransportorOrderList {
  String status;
  String token;
  List<OrderListResult > result;

  TransportorOrderList({this.status, this.token, this.result});

  TransportorOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    if (json['result'] != null) {
      result = new List<OrderListResult >();
      json['result'].forEach((v) {
        result.add(new OrderListResult .fromJson(v));
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

class OrderListResult  {
  Position position;
  Position startingPosition;
  Position endingPosition;
  int box;
  int deleted;
  int status;
  int hubOtp;
  String sId;
  String orderNumber;
  List<Products> products;
  Transporter transporter;
  Hub hub;
  String driverAssignDate;
  String createdDate;
  int iV;
  String product;
  Driver driver;
  String vehicle;

  OrderListResult (
      {this.position,
      this.startingPosition,
      this.endingPosition,
      this.box,
      this.deleted,
      this.status,
      this.hubOtp,
      this.sId,
      this.orderNumber,
      this.products,
      this.transporter,
      this.hub,
      this.driverAssignDate,
      this.createdDate,
      this.iV,
      this.product,
      this.driver,
      this.vehicle});

  OrderListResult .fromJson(Map<String, dynamic> json) {
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    startingPosition = json['starting_position'] != null
        ? new Position.fromJson(json['starting_position'])
        : null;
    endingPosition = json['ending_position'] != null
        ? new Position.fromJson(json['ending_position'])
        : null;
    box = json['box'];
    deleted = json['deleted'];
    status = json['status'];
    hubOtp = json['hub_otp'];
    sId = json['_id'];
    orderNumber = json['order_number'];
    if (json['products'] != null) {
      products = new List<Products>();
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    transporter = json['transporter'] != null
        ? new Transporter.fromJson(json['transporter'])
        : null;
    hub = json['hub'] != null ? new Hub.fromJson(json['hub']) : null;
    driverAssignDate = json['driver_assign_date'];
    createdDate = json['created_date'];
    iV = json['__v'];
    product = json['product'];
    driver =
        json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.position != null) {
      data['position'] = this.position.toJson();
    }
    if (this.startingPosition != null) {
      data['starting_position'] = this.startingPosition.toJson();
    }
    if (this.endingPosition != null) {
      data['ending_position'] = this.endingPosition.toJson();
    }
    data['box'] = this.box;
    data['deleted'] = this.deleted;
    data['status'] = this.status;
    data['hub_otp'] = this.hubOtp;
    data['_id'] = this.sId;
    data['order_number'] = this.orderNumber;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    if (this.transporter != null) {
      data['transporter'] = this.transporter.toJson();
    }
    if (this.hub != null) {
      data['hub'] = this.hub.toJson();
    }
    data['driver_assign_date'] = this.driverAssignDate;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    data['product'] = this.product;
    if (this.driver != null) {
      data['driver'] = this.driver.toJson();
    }
    data['vehicle'] = this.vehicle;
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

class Products {
  String sId;
  Product product;
  int box;

  Products({this.sId, this.product, this.box});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    product =
        json['product'] != null ? new Product.fromJson(json['product']) : null;
    box = json['box'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    if (this.product != null) {
      data['product'] = this.product.toJson();
    }
    data['box'] = this.box;
    return data;
  }
}

class Product {
  String sId;
  String name;

  Product({this.sId, this.name});

  Product.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Transporter {
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

  Transporter(
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

  Transporter.fromJson(Map<String, dynamic> json) {
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

class Hub {
  Position position;
  int active;
  String sId;
  String state;
  String district;
  String name;
  String pincode;
  String address1;
  String address2;
  String createdDate;
  int iV;

  Hub(
      {this.position,
      this.active,
      this.sId,
      this.state,
      this.district,
      this.name,
      this.pincode,
      this.address1,
      this.address2,
      this.createdDate,
      this.iV});

  Hub.fromJson(Map<String, dynamic> json) {
    position = json['position'] != null
        ? new Position.fromJson(json['position'])
        : null;
    active = json['active'];
    sId = json['_id'];
    state = json['state'];
    district = json['district'];
    name = json['name'];
    pincode = json['pincode'];
    address1 = json['address1'];
    address2 = json['address2'];
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
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}

class Driver {
  int active;
  Null otp;
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

  Driver(
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

  Driver.fromJson(Map<String, dynamic> json) {
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

Future<TransportorOrderList> transPorterOrderList({String transporterid}) async {
 
 var header = {
   'authorization' : Global.accessToken
 };
 print(header);
 var body = jsonEncode({
    "transporter": "5f89cce7b188c83dd6eb2000"
   //"transporter" : Global.loginModel.result.sId
});
  final response = await http.post('http://139.59.75.40:4040/app/transporter-order-list',body: body,headers: header);
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TransportorOrderList.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}