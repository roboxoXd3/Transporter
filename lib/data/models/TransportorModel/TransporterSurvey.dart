import 'dart:convert';
import 'package:http/http.dart' as http;

class TransporterSurveyList {
  String status;
  List<SurveyProducts> products;
  String token;

  TransporterSurveyList({this.status, this.products, this.token});

  TransporterSurveyList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = new List<SurveyProducts>();
      json['products'].forEach((v) {
        products.add(new SurveyProducts.fromJson(v));
      });
    }
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['token'] = this.token;
    return data;
  }
}

class SurveyProducts {
  int active;
  int qty;
  String sId;
  String name;
  String parentGroup;
  String childGroup;
  String brand;
  String unit;
  String unitValue;
  String vendor;
  String manufacturingPrice;
  String sellingPriceOrg;
  String sellingPrice;
  String startingStock;
  String gstPercentage;
  String batchCode;
  String image;
  String createdDate;
  int iV;

  SurveyProducts(
      {this.active,
      this.qty,
      this.sId,
      this.name,
      this.parentGroup,
      this.childGroup,
      this.brand,
      this.unit,
      this.unitValue,
      this.vendor,
      this.manufacturingPrice,
      this.sellingPriceOrg,
      this.sellingPrice,
      this.startingStock,
      this.gstPercentage,
      this.batchCode,
      this.image,
      this.createdDate,
      this.iV});

  SurveyProducts.fromJson(Map<String, dynamic> json) {
    active = json['active'];
    qty = json['qty'];
    sId = json['_id'];
    name = json['name'];
    parentGroup = json['parent_group'];
    childGroup = json['child_group'];
    brand = json['brand'];
    unit = json['unit'];
    unitValue = json['unit_value'];
    vendor = json['vendor'];
    manufacturingPrice = json['manufacturing_price'];
    sellingPriceOrg = json['selling_price_org'];
    sellingPrice = json['selling_price'];
    startingStock = json['starting_stock'];
    gstPercentage = json['gst_percentage'];
    batchCode = json['batch_code'];
    image = json['image'];
    createdDate = json['created_date'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active'] = this.active;
    data['qty'] = this.qty;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['parent_group'] = this.parentGroup;
    data['child_group'] = this.childGroup;
    data['brand'] = this.brand;
    data['unit'] = this.unit;
    data['unit_value'] = this.unitValue;
    data['vendor'] = this.vendor;
    data['manufacturing_price'] = this.manufacturingPrice;
    data['selling_price_org'] = this.sellingPriceOrg;
    data['selling_price'] = this.sellingPrice;
    data['starting_stock'] = this.startingStock;
    data['gst_percentage'] = this.gstPercentage;
    data['batch_code'] = this.batchCode;
    data['image'] = this.image;
    data['created_date'] = this.createdDate;
    data['__v'] = this.iV;
    return data;
  }
}


Future<TransporterSurveyList> transPorterSurveyList() async {
 
  final response = await http.post('http://139.59.75.40:4040/app/transporter-surevy-list');
    print(response.body);
  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON
    print(response.body);

    return TransporterSurveyList.fromJson(json.decode(response.body)) ;
    // print("Status OK");
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}