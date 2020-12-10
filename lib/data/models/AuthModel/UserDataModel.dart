class UserDataModel {
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

  UserDataModel(
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

  UserDataModel.fromJson(Map<String, dynamic> json) {
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