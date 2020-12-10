import 'dart:ui';
import 'package:Transporter/data/models/TransportorModel/DeleteDriver.dart';
import 'package:Transporter/data/models/TransportorModel/DriverListModel.dart';
import 'package:Transporter/screens/AddEmployee/AddEmployeeDetails.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class AddEmployee extends StatefulWidget {
  AddEmployee({Key key}) : super(key: key);

  @override
  _AddEmployeeState createState() => _AddEmployeeState();
}

class _AddEmployeeState extends State<AddEmployee> {

     DriverListModel driverListModel = DriverListModel();

   @override
   void initState() { 
     super.initState();
      initData();
   }
   initData(){
     setState(() {
        Global.isLoading = true;
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
             driverListModel = value;
           });
        }
     });
   }


  _getRequests()async{
    initData();
  }
  deleteDriver(String id){
    setState(() {
        Global.isLoading = true;
      });
    deleteDriverModel(id).then((value) {
      setState(() {
        Global.isLoading = false;
      });
      if (value.status == 'success') {
        Toast.show(value.message, context);
        if (value.token.isNotEmpty) {
          setState(() {
            Global.accessToken = value.token;
          });
        }
      } else {
          Toast.show(value.message, context);
      }
    });  
  }
  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Colors.indigo[900],
            icon: Icon(Icons.add,size: 30,color: AppColors.whiteColor,),
            onPressed: (){
              //AddEmployeeDetails
               Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new AddEmployeeDetails()),)
        .then((val)=>val?_getRequests():null);
             
            },
             label: Text('Add Driver',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.whiteColor,
                                                  ),
                                                  ),),
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: Text('Driver',style: TextStyle(
              fontFamily: 'Arial',
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 22
            ),),
            backgroundColor: Colors.indigo[900],
            
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(12, 12, 12, 0),
              width: double.infinity,
              height: SizeConfig.screenHeight,
              child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                      Container(
                            height: SizeConfig.safeBlockVertical*90,
                            child: driverListModel.result.length == 0 ? Center(
                          child: Text('No data',style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.darkColor,
                                                  )),
                        ) :  ListView.builder(
                              itemCount: driverListModel.result.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,index){
                                      return Container(
                                         padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                                         child: Dismissible(
                                          key: ValueKey(driverListModel.result[index].sId),
                                            background: Container(
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(20),
                                                 color: Colors.red,
                                              ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left : 15.0),
                                                  child: Icon(Icons.cancel),
                                                ),
                                              ],
                                            ),
                                            ),
                                            secondaryBackground: Container(
                                         
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                               color: Colors.yellow,
                                            ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(right : 15.0),
                                                child: Icon(Icons.edit,color: Colors.black,),
                                              ),
                                            ],
                                          ),
                                          ),
                                            confirmDismiss: (DismissDirection direction) async {
  if (direction == DismissDirection.startToEnd) {
     return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm"),
        content: const Text("Are you sure you wish to delete this Driver?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("DELETE")
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
        ],
      );
    },
  );}
   return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Edit"),
        content: const Text("Do you want to edit the Driver?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () { 
              Navigator.of(context).pop(false);
        //                                      print('Editcalled');
        //                                      Global.editvehicledata = vehicleListModel.result[index];
        //      Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new VehicleUpdate()),)
        // .then((val)=>val?_getRequests():null);
                                           
              },
            child: const Text("Edit")
          ),
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("CANCEL"),
          ),
        ],
      );
    },
  );
},
                                            onDismissed: (direction) {
                                              // Remove the dismissed item from the list
                                              deleteDriver(driverListModel.result[index].sId);
                                              driverListModel.result.removeAt(index);
                                              
                                              },
                                            child: Container(
                                           
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              color: Colors.green
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                ClipRRect(
                                                  borderRadius: BorderRadius.circular(50),
                                                  child: Container(
                                                    color: AppColors.whiteColor,
                                                    child: Image.network('https://leadslive.io/wp-content/uploads/2017/05/Miniclip-8-Ball-Pool-Avatar-11.png',
                                                    height: 50,
                                                    width: 50,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 10,),
                                                Container(
                                                  width: 0.5,
                                                  height: 75,
                                                  color: AppColors.whiteColor,
                                                  child: Text(' '),
                                                ),
                                                SizedBox(width: 10,),
                                                Expanded(
                                                   child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Text('Name : ${driverListModel.result[index].firstName} ${driverListModel.result[index].lastName}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.whiteColor,
                                                      ),
                                                      ),
                                                      SizedBox(height : 15,),
                                                      Text('Licence No : ${driverListModel.result[index].licenceNumber}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                        color: Colors.grey[700],
                                                      ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                            }),
                          )
                        ]))));})))
    );
  }
  }
