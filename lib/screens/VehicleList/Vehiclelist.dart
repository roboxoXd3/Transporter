import 'dart:ui';
import 'package:Transporter/data/models/TransportorModel/DeleteDriver.dart';
import 'package:Transporter/data/models/TransportorModel/VehicleList.dart';
import 'package:Transporter/screens/Transporter/VehicleEdit.dart';
import 'package:Transporter/screens/VehicleList/AddVehicle.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class VehicleList extends StatefulWidget {
  VehicleList({Key key}) : super(key: key);

  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
   
   VehicleListModel vehicleListModel = VehicleListModel();

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
    deleteVehicleModel(id).then((value) {
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
            icon: Icon(Icons.add,size: 20,color: AppColors.whiteColor,),
            onPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new AddVehicle()),)
        .then((val)=>val?_getRequests():null);
      
             // Navigator.of(context).pushNamed('addvehicle');
            },
             label: Text('Add Truck',
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
            title: Text('Vehicle List',style: TextStyle(
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
                            child: vehicleListModel.result.length == 0 ? Center(
                          child: Text('No data',style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w600,
                                                    color: AppColors.darkColor,
                                                  )),
                        ) :  ListView.builder(
                              itemCount: vehicleListModel.result.length,
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context,index){
                                      return Padding(
                                        padding: EdgeInsets.fromLTRB(0, 14, 0, 0),
                  child: Dismissible(
                                          key: UniqueKey(),
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
                                               color: Colors.green,
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
                                         content: const Text("Are you sure you wish to delete this Vehicle?"),
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
                         );
                  }  
    return await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Edit"),
        content: const Text("Do you want to edit the Vehicle?"),
        actions: <Widget>[
          FlatButton(
            onPressed: () { 
              Navigator.of(context).pop(false);
                                             print('Editcalled');
                                             Global.editvehicledata = vehicleListModel.result[index];
             Navigator.of(context).push(new MaterialPageRoute(builder: (_)=>new VehicleUpdate()),)
        .then((val)=>val?_getRequests():null);
                                           
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
                                           if (direction == DismissDirection.startToEnd) {
                                             print('Delete Called');
                                             deleteVehicleModel(vehicleListModel.result[index].sId);
                                              vehicleListModel.result.removeAt(index);
                                           } 
                                           
                                           
                                            },
                                           child: Container(
                                           
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              gradient: LinearGradient(
                                                begin: Alignment.centerLeft,
                                              colors: [
                                              Colors.tealAccent[400],
                                              Colors.grey[500]
                                             ],),
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Row(
                                              children: [
                                                Image.asset('assets/images/icons/TRUCK.png',height: 65,width: 65,),
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
                                                      Text('Vehicle Number : ${vehicleListModel.result[index].number}',
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        fontSize: 17,
                                                        fontWeight: FontWeight.w600,
                                                        color: AppColors.whiteColor,
                                                      ),
                                                      ),
                                                      SizedBox(height : 15,),
                                                      Text('Category : ${vehicleListModel.result[index].name}',
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
