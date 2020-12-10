import 'package:Transporter/data/models/DriverModel/DriverOrderList.dart';
import 'package:Transporter/util/AuthProvider.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:Transporter/widgets/CustomAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class DriverHomeScreen extends StatefulWidget {
  DriverHomeScreen({Key key}) : super(key: key);

  @override
  _DriverHomeScreenState createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  
AuthProvider authProvider = AuthProvider();
 DateTime backbuttonpressedTime;
Future<bool> onWillPop() async {
  DateTime currentTime = DateTime.now();
  //Statement 1 Or statement2
  bool backButton = backbuttonpressedTime == null ||
      currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

  if (backButton) {
    backbuttonpressedTime = currentTime;
        Toast.show("Double Click to exit app", context, duration: Toast.LENGTH_LONG,
         gravity:  Toast.BOTTOM);
    return false;
  }
  SystemNavigator.pop();
  return true;
}


Drawer drawer(){
  return Drawer(
  // Add a ListView to the drawer. This ensures the user can scroll
  // through the options in the drawer if there isn't enough vertical
  // space to fit everything.
  child: ListView(
    // Important: Remove any padding from the ListView.
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child:  GestureDetector(
          onTap: (){
            Navigator.of(context).popAndPushNamed('editdriverprofile');
          },
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network('https://avatars2.githubusercontent.com/u/498852?s=400&v=4'),
                        ),
                        Padding(
                         padding:  EdgeInsets.only(top : 5.0),
                          child: Text('${Global.driverUserModel.result.firstName} ${Global.driverUserModel.result.lastName}',
                                                                textAlign: TextAlign.end,
                                                                style: TextStyle(
                                                                  fontFamily: 'Shruti',
                                                                  fontSize: 20,
                                                                  fontWeight: FontWeight.w600,
                                                                  color: AppColors.whiteColor,
                                                                ),
                           ),
                        ),
                      ],
                    ),
        ),
        decoration: BoxDecoration(
          color: AppColors.driverprimaryColor,
        ),
      ),
     
    
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.car_rental,color: Colors.white,size: 25,),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('Orders',
          style: TextStyle(height: 1,
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
             Navigator.of(context).pop();
         
           
        },
      ),
     Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/history.png',height: 25,color: Colors.white,),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('History',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
          
          Navigator.of(context).popAndPushNamed('historylist');
         
        },
      ),
      // Divider(color: Colors.black,),
      //  ListTile(
      //   leading: Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: AppColors.driverprimaryColor
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset('assets/images/survey.png',height: 25,color: Colors.white,),
      //     ),
      //   ),
      //   title: Padding(
      //     padding: EdgeInsets.only(top: 5),
      //     child: Text('Survey',
      //     style: TextStyle(
      //                                                           fontFamily: 'Shruti',
      //                                                           fontSize: 20,
      //                                                           fontWeight: FontWeight.w600,
      //                                                           color: AppColors.darkColor,
      //                                                         ),),
      //   ),
      //   onTap: () {
         
      //     Navigator.of(context).popAndPushNamed('survey');
        
      //   },
      // ),
      Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/about.png',height: 25,color: Colors.white,),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('About',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
          
          Navigator.of(context).popAndPushNamed('about');
       
        },
      ),
      Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/contact.png',height: 25,color: Colors.white,),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('Contact',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
         
          Navigator.of(context).popAndPushNamed('contact');
        
        },
      ),
      Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/accepted.png',height: 25,color: Colors.white),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text("Term's & Privacy",
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
        
          Navigator.of(context).popAndPushNamed('termsprivacy');
         
        },
      ),
      Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.driverprimaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.logout,size : 25,color: Colors.white),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text("Logout",
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
          authProvider.deleteUserType();
          authProvider.deletedriverData();
          authProvider.deletetoken();
          Navigator.of(context).popAndPushNamed('login');
         
        },
      ),
      
      Divider(color: Colors.black,),
      // ListTile(
      //   leading: Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: AppColors.driverprimaryColor
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset('assets/images/help.png',height: 25,color: Colors.white,),
      //     ),
      //   ),
      //   title: Padding(
      //     padding: EdgeInsets.only(top: 5),
      //     child: Text("FaQ",
      //     style: TextStyle(
      //                                fontFamily: 'Shruti',
      //                                         fontSize: 20,
      //                                             fontWeight: FontWeight.w600,
      //                                         color: AppColors.darkColor,
      //                                       ),),
      //   ),
      //   onTap: () {
         
      //     Navigator.of(context).popAndPushNamed('faq');
      //   },
      // ),
      //  Divider(color: Colors.black,),
    ],
  ),
);
;
}
   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
           onWillPop: onWillPop,
                  child: Scaffold(
            drawer: drawer(),
            
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: AppColors.driverprimaryColor
              ),
               leading: Builder(
          builder: (context) => IconButton(
              icon:  Container(
      padding: EdgeInsets.all(2),
      height: 30,
      width: 30,
      decoration: 
          BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
             ),
              child: Icon(Icons.menu,size: 20,),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
    title: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.only(left : 10.0),
                    child: Text('Driver',style: TextStyle(
                      fontFamily: 'Arial',
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),),
                  ),
                ],
              ),
              backgroundColor: AppColors.driverprimaryColor,
              
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: SizeConfig.safeBlockVertical*90,
                              child: FutureBuilder<DriverOrderList>(
                                future: driverOrderList(),
                              builder: (context,snapshot){

                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.data.result.isNotEmpty) {
                                    
                                    return ListView.builder(
                                  itemCount: snapshot.data.result.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    DateTime now = DateFormat("yyyy-MM-dd").parse(snapshot.data.result[index].createdDate);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        elevation: 5,
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
                                                 Text(snapshot.data.result[index].orderNumber,
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
                                                    itemCount: snapshot.data.result[index].products.length,
                                                     //snapshot.data.result[index].products
                                                    itemBuilder: (BuildContext context , insideindex){
                                                     
                                                      return Text('${insideindex + 1} : ${snapshot.data.result[index].products[insideindex].product.name}',
                                                      style: TextStyle(
                                                     
                                                     fontSize: 16 
                                                     )
                                                      );
                                                    },
                                                   ),
                                                 ),
                                               ],
                                             ),
                                             Row(
                                               children: [
                                                 Text('Transporter Name : ',
                                                 style: TextStyle(
                                                   color: Colors.grey[500],
                                                   fontSize: 16 
                                                 ),),
                                                 Text(snapshot.data.result[index].transporter.name,
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
                                                 Text(snapshot.data.result[index].hub.name,
                                                 style: TextStyle(
                                                   fontSize: 16
                                                 ),
                                                 )
                                               ],
                                             ),
                              
                                               Padding(
                                                 padding: EdgeInsets.only(top: 10),
                                                 child: Container(
                                                   width: double.infinity,
                                                   child: RaisedButton(
                                                     shape: RoundedRectangleBorder(
                                                       borderRadius: BorderRadius.circular(10)
                                                     ),
                                                     color: AppColors.driverprimaryColor,
                                                     child: Padding(
                                                       padding: EdgeInsets.only(top: 5),
                                                       child: Text('VIEW DETAILS',
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 20,
                                                           color: AppColors.whiteColor
                                                         ),
                                                       ),
                                                     ),
                                                     onPressed: (){
                                                       Global.driverOrderResult = snapshot.data.result[index];
                                                       Navigator.of(context).pushNamed('orderdetails');
                                                     }),
                                                 ),
                                                 )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                  }
                                  else if (snapshot.data.result.isEmpty){
                                    return Center(child: Text('No Data',style: TextStyle(
                                      fontFamily: 'Arial',
                                      fontSize: 20
                                    ),));
                                  }
                                  else {
                                    return Text(snapshot.data.status);
                                  }
                                }
                                return Container(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator());
                              },
                              ),
                            )
                          ]))));})),
        ))
    );
  }
}