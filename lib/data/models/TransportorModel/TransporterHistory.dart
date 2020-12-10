


// class TransportorHistory {
//   String status;
//   String token;
//   List<Result> result;

//   TransportorHistory({this.status, this.token, this.result});

//   TransportorHistory.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     token = json['token'];
//     if (json['result'] != null) {
//       result = new List<Result>();
//       json['result'].forEach((v) {
//         result.add(new Result.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['token'] = this.token;
//     if (this.result != null) {
//       data['result'] = this.result.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Result {
//   Position position;
//   Position startingPosition;
//   Position endingPosition;
//   int box;
//   int deleted;
//   int status;
//   int hubOtp;
//   String sId;
//   String orderNumber;
//   String product;
//   Transporter transporter;
//   Hub hub;
//   String driverAssignDate;
//   String createdDate;
//   int iV;
//   Driver driver;
//   String vehicle;
//   List<Null> products;

//   Result(
//       {this.position,
//       this.startingPosition,
//       this.endingPosition,
//       this.box,
//       this.deleted,
//       this.status,
//       this.hubOtp,
//       this.sId,
//       this.orderNumber,
//       this.product,
//       this.transporter,
//       this.hub,
//       this.driverAssignDate,
//       this.createdDate,
//       this.iV,
//       this.driver,
//       this.vehicle,
//       this.products});

//   Result.fromJson(Map<String, dynamic> json) {
//     position = json['position'] != null
//         ? new Position.fromJson(json['position'])
//         : null;
//     startingPosition = json['starting_position'] != null
//         ? new Position.fromJson(json['starting_position'])
//         : null;
//     endingPosition = json['ending_position'] != null
//         ? new Position.fromJson(json['ending_position'])
//         : null;
//     box = json['box'];
//     deleted = json['deleted'];
//     status = json['status'];
//     hubOtp = json['hub_otp'];
//     sId = json['_id'];
//     orderNumber = json['order_number'];
//     product = json['product'];
//     transporter = json['transporter'] != null
//         ? new Transporter.fromJson(json['transporter'])
//         : null;
//     hub = json['hub'] != null ? new Hub.fromJson(json['hub']) : null;
//     driverAssignDate = json['driver_assign_date'];
//     createdDate = json['created_date'];
//     iV = json['__v'];
//     driver =
//         json['driver'] != null ? new Driver.fromJson(json['driver']) : null;
//     vehicle = json['vehicle'];
//     if (json['products'] != null) {
//       products = new List<Null>();
//       json['products'].forEach((v) {
//         products.add(new Null.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.position != null) {
//       data['position'] = this.position.toJson();
//     }
//     if (this.startingPosition != null) {
//       data['starting_position'] = this.startingPosition.toJson();
//     }
//     if (this.endingPosition != null) {
//       data['ending_position'] = this.endingPosition.toJson();
//     }
//     data['box'] = this.box;
//     data['deleted'] = this.deleted;
//     data['status'] = this.status;
//     data['hub_otp'] = this.hubOtp;
//     data['_id'] = this.sId;
//     data['order_number'] = this.orderNumber;
//     data['product'] = this.product;
//     if (this.transporter != null) {
//       data['transporter'] = this.transporter.toJson();
//     }
//     if (this.hub != null) {
//       data['hub'] = this.hub.toJson();
//     }
//     data['driver_assign_date'] = this.driverAssignDate;
//     data['created_date'] = this.createdDate;
//     data['__v'] = this.iV;
//     if (this.driver != null) {
//       data['driver'] = this.driver.toJson();
//     }
//     data['vehicle'] = this.vehicle;
//     if (this.products != null) {
//       data['products'] = this.products.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Position {
//   String type;
//   List<int> coordinates;

//   Position({this.type, this.coordinates});

//   Position.fromJson(Map<String, dynamic> json) {
//     type = json['type'];
//     coordinates = json['coordinates'].cast<int>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['type'] = this.type;
//     data['coordinates'] = this.coordinates;
//     return data;
//   }
// }

// class Transporter {
//   Position position;
//   int active;
//   String sId;
//   String state;
//   String district;
//   String name;
//   String pincode;
//   String orgType;
//   String orgOtherType;
//   String regNumber;
//   String gstNumber;
//   String bankName;
//   String accountNumber;
//   String ifsc;
//   String createdDate;
//   int iV;

//   Transporter(
//       {this.position,
//       this.active,
//       this.sId,
//       this.state,
//       this.district,
//       this.name,
//       this.pincode,
//       this.orgType,
//       this.orgOtherType,
//       this.regNumber,
//       this.gstNumber,
//       this.bankName,
//       this.accountNumber,
//       this.ifsc,
//       this.createdDate,
//       this.iV});

//   Transporter.fromJson(Map<String, dynamic> json) {
//     position = json['position'] != null
//         ? new Position.fromJson(json['position'])
//         : null;
//     active = json['active'];
//     sId = json['_id'];
//     state = json['state'];
//     district = json['district'];
//     name = json['name'];
//     pincode = json['pincode'];
//     orgType = json['org_type'];
//     orgOtherType = json['org_other_type'];
//     regNumber = json['reg_number'];
//     gstNumber = json['gst_number'];
//     bankName = json['bank_name'];
//     accountNumber = json['account_number'];
//     ifsc = json['ifsc'];
//     createdDate = json['created_date'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.position != null) {
//       data['position'] = this.position.toJson();
//     }
//     data['active'] = this.active;
//     data['_id'] = this.sId;
//     data['state'] = this.state;
//     data['district'] = this.district;
//     data['name'] = this.name;
//     data['pincode'] = this.pincode;
//     data['org_type'] = this.orgType;
//     data['org_other_type'] = this.orgOtherType;
//     data['reg_number'] = this.regNumber;
//     data['gst_number'] = this.gstNumber;
//     data['bank_name'] = this.bankName;
//     data['account_number'] = this.accountNumber;
//     data['ifsc'] = this.ifsc;
//     data['created_date'] = this.createdDate;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Hub {
//   Position position;
//   int active;
//   String sId;
//   String state;
//   String district;
//   String name;
//   String pincode;
//   String address1;
//   String address2;
//   String createdDate;
//   int iV;

//   Hub(
//       {this.position,
//       this.active,
//       this.sId,
//       this.state,
//       this.district,
//       this.name,
//       this.pincode,
//       this.address1,
//       this.address2,
//       this.createdDate,
//       this.iV});

//   Hub.fromJson(Map<String, dynamic> json) {
//     position = json['position'] != null
//         ? new Position.fromJson(json['position'])
//         : null;
//     active = json['active'];
//     sId = json['_id'];
//     state = json['state'];
//     district = json['district'];
//     name = json['name'];
//     pincode = json['pincode'];
//     address1 = json['address1'];
//     address2 = json['address2'];
//     createdDate = json['created_date'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.position != null) {
//       data['position'] = this.position.toJson();
//     }
//     data['active'] = this.active;
//     data['_id'] = this.sId;
//     data['state'] = this.state;
//     data['district'] = this.district;
//     data['name'] = this.name;
//     data['pincode'] = this.pincode;
//     data['address1'] = this.address1;
//     data['address2'] = this.address2;
//     data['created_date'] = this.createdDate;
//     data['__v'] = this.iV;
//     return data;
//   }
// }

// class Driver {
//   int active;
//   Null otp;
//   int verified;
//   int deleted;
//   String sId;
//   String firstName;
//   String lastName;
//   String email;
//   String mobile;
//   String userType;
//   String state;
//   String district;
//   String pincode;
//   String master;
//   String masterName;
//   String address;
//   String village;
//   String postOffice;
//   String thana;
//   String licenceNumber;
//   String document;
//   String documentImage;
//   String profileImage;
//   String createdDate;
//   int iV;

//   Driver(
//       {this.active,
//       this.otp,
//       this.verified,
//       this.deleted,
//       this.sId,
//       this.firstName,
//       this.lastName,
//       this.email,
//       this.mobile,
//       this.userType,
//       this.state,
//       this.district,
//       this.pincode,
//       this.master,
//       this.masterName,
//       this.address,
//       this.village,
//       this.postOffice,
//       this.thana,
//       this.licenceNumber,
//       this.document,
//       this.documentImage,
//       this.profileImage,
//       this.createdDate,
//       this.iV});

//   Driver.fromJson(Map<String, dynamic> json) {
//     active = json['active'];
//     otp = json['otp'];
//     verified = json['verified'];
//     deleted = json['deleted'];
//     sId = json['_id'];
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     email = json['email'];
//     mobile = json['mobile'];
//     userType = json['user_type'];
//     state = json['state'];
//     district = json['district'];
//     pincode = json['pincode'];
//     master = json['master'];
//     masterName = json['master_name'];
//     address = json['address'];
//     village = json['village'];
//     postOffice = json['post_office'];
//     thana = json['thana'];
//     licenceNumber = json['licence_number'];
//     document = json['document'];
//     documentImage = json['document_image'];
//     profileImage = json['profile_image'];
//     createdDate = json['created_date'];
//     iV = json['__v'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['active'] = this.active;
//     data['otp'] = this.otp;
//     data['verified'] = this.verified;
//     data['deleted'] = this.deleted;
//     data['_id'] = this.sId;
//     data['first_name'] = this.firstName;
//     data['last_name'] = this.lastName;
//     data['email'] = this.email;
//     data['mobile'] = this.mobile;
//     data['user_type'] = this.userType;
//     data['state'] = this.state;
//     data['district'] = this.district;
//     data['pincode'] = this.pincode;
//     data['master'] = this.master;
//     data['master_name'] = this.masterName;
//     data['address'] = this.address;
//     data['village'] = this.village;
//     data['post_office'] = this.postOffice;
//     data['thana'] = this.thana;
//     data['licence_number'] = this.licenceNumber;
//     data['document'] = this.document;
//     data['document_image'] = this.documentImage;
//     data['profile_image'] = this.profileImage;
//     data['created_date'] = this.createdDate;
//     data['__v'] = this.iV;
//     return data;
//   }
// }