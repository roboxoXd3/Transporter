import 'dart:collection';

import 'package:Transporter/data/models/TransportorModel/DriverListModel.dart';
import 'package:Transporter/data/models/TransportorModel/OrderAssign.dart';
import 'package:Transporter/data/models/TransportorModel/TransportorOrderList.dart';
import 'package:Transporter/data/models/TransportorModel/VehicleList.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AssignOrderScreen extends StatefulWidget {
  AssignOrderScreen({Key key}) : super(key: key);

  @override
  _AssignOrderScreenState createState() => _AssignOrderScreenState();
}

class _AssignOrderScreenState extends State<AssignOrderScreen> {


  VehicleListModel vehicleListModel = VehicleListModel();
  VehicleListResult vehicleListResult = VehicleListResult();
  List<VehicleListResult> vehicleList = [];
  List<DriverResult> driverlist = [];
  
  String vehicleid = '';
  String driverid = '';
   @override
   void initState() { 
     super.initState();
      initData();
   }
   initData(){
     setState(() {
        Global.isLoading = true;
      });
     fetchVehicleList().then((value) {
       setState(() {
        Global.isLoading = false;
      });
        if (value.status == 'success') {
          if (value.token.isNotEmpty) {
            setState(() {
           
            Global.accessToken = value.token;
          });
          }
           setState(() {
             vehicleListModel = value;
             
             vehicleList = value.result;
           });
        }
     });
     fetchDriverList().then((value) {
       setState(() {
        Global.isLoading = false;
      });
        if (value.status == 'success') {
          if (value.token.isNotEmpty) {
            setState(() {
            Global.accessToken = value.token;
            });
          }
           setState(() {
             driverlist = value.result;
           });
        }
     });
   }
  
  assignOrderMethod(){
    assignOrderModel(
      orderid: Global.assignmentDetails.sId,
      vehicelid: vehicleid,
      driverid: driverid
    ).then((value) {
      if (value.status == 'success') {
        if (value.token.isNotEmpty) {
          Global.accessToken = value.token;
        }
        setState(() {
          _showSuccessDialog();
        });
      }
    });
  }

  Future<void> _showSuccessDialog({String message = ''}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Driver Assigned'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The driver has been assigned the Order'),
              Text(message)
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
     DateTime now = DateFormat("yyyy-MM-dd").parse(Global.assignmentDetails.createdDate);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
        
          appBar: AppBar(
            
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: Text('Assign Order',style: TextStyle(
              fontFamily: 'Shruti',
              color: Colors.white,
              fontSize: 22
            ),),
            backgroundColor: Colors.indigo[900],
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
              width: double.infinity,
             // height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                         Row(
                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                           children: [
                                               Row(
                                             children: [
                                               Text('Order ID :',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16
                                               ),),
                                               Text(Global.assignmentDetails.orderNumber,
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Text('Order Date : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(DateFormat.yMd().format(now),
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                           ),
                                           ],
                                         ),
                                         Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Text('Product Name : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               
                                               Expanded(
                                                    child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: Global.assignmentDetails.products.length,
                                                     //snapshot.data.result[index].products
                                                    itemBuilder: (BuildContext context , insideindex){
                                                      return Text('$insideindex ${Global.assignmentDetails.products[insideindex].product.name}',
                                                      style: TextStyle(
                                                   fontSize: 16
                                                 ),
                                                      );
                                                    },
                                                   ),
                                               )
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Text('Transporter Name : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(Global.assignmentDetails.transporter.name,
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Text('Hub Name :',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(Global.assignmentDetails.hub.name,
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                           ),
                                          
                                           
                                        ],
                                      ),
                                    ),
                                  ),
                                           Padding(
                       padding: const EdgeInsets.only(top : 20.0),
                       child: new DropdownButtonFormField<VehicleListResult>(
                                 isDense: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.black
                                      ) 
                                    ),
                                 ),
                                 style: TextStyle(
                                           fontFamily: 'Arial',
                                           fontWeight: FontWeight.w500,
                                           fontSize: 18,
                                           color: AppColors.darkColor
                                         ),
                                 hint: Text('Select Vehile',style: TextStyle(
                                           fontFamily: 'Arial',
                                           fontWeight: FontWeight.w500,
                                           fontSize: 18,
                                           color: AppColors.darkColor
                                         ),),                                    
                                          validator: (value) =>
                                                   value == null
                                                       ? 'Feild Required'
                                                       : null,
                                 items: vehicleList.map<DropdownMenuItem<VehicleListResult>>((VehicleListResult value) {
                                       return new DropdownMenuItem<VehicleListResult>(
      
                                          value: value,
                                          child: new Text(value.name),
                                            );
                                           }).toList(),
                                           onChanged: (val) {
                                             print(val.sId);
                                             setState(() {
                                               vehicleid = val.sId;
                                             });
                                           },
                                         ),
                 ),
                  Padding(
                       padding: const EdgeInsets.only(top : 20.0),
                       child: new DropdownButtonFormField<DriverResult>(
                                 isDense: true,
                                 decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                        color: Colors.black
                                      ) 
                                    ),
                                 ),
                                 style: TextStyle(
                                           fontFamily: 'Arial',
                                           fontWeight: FontWeight.w500,
                                           fontSize: 18,
                                           color: AppColors.darkColor
                                         ),
                                 hint: Text('Select Driver',style: TextStyle(
                                           fontFamily: 'Arial',
                                           fontWeight: FontWeight.w500,
                                           fontSize: 18,
                                           color: AppColors.darkColor
                                         ),),                                    
                                          validator: (value) =>
                                                   value == null
                                                       ? 'Feild Required'
                                                       : null,
                                 items: driverlist.map<DropdownMenuItem<DriverResult>>((DriverResult value) {
                                       return new DropdownMenuItem<DriverResult>(      
                                          value: value,
                                          child: new Text('${value.firstName} ${value.lastName}'),
                                            );
                                           }).toList(),
                                           onChanged: (val) {
                                             print(val.sId);
                                             setState(() {
                                               driverid = val.sId;
                                             });
                                           },
                                         ),
                 ),
                            ],
                          ),
                          
                 Padding(
                   padding: const EdgeInsets.only(bottom : 20.0,top: 40),
                   child: Container(
                     width: double.infinity,
                     child: RaisedButton(
                          shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(10)
                                                       ),
                                                       color: AppColors.primaryColor,
                                                       child: Padding(
                                                         padding: const EdgeInsets.all(5.0),
                                                         child: Text('Assign',
                                                           style: TextStyle(
                                                             fontWeight: FontWeight.w600,
                                                             fontSize: 20,
                                                             color: AppColors.whiteColor
                                                           ),
                                                         ),
                                                       ),
                                                       onPressed: (){
                                                         assignOrderMethod();
                                                       }),
                   ),
                 ),
                        ]))));})))
    );
  }
}