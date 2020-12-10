import 'package:Transporter/data/models/TransportorModel/TransportorOrderList.dart';
import 'package:Transporter/util/AuthProvider.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:Transporter/widgets/CustomAlert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
TransportorOrderList transportorOrderList = TransportorOrderList();
AuthProvider authProvider = AuthProvider();
 DateTime backbuttonpressedTime;
@override
void initState() { 
  super.initState();
 print( Global.accessToken );
}

Future<bool> onWillPop() async {
  DateTime currentTime = DateTime.now();
  //Statement 1 Or statement2
  bool backButton = backbuttonpressedTime == null ||
      currentTime.difference(backbuttonpressedTime) > Duration(seconds: 3);

  if (backButton) {
    backbuttonpressedTime = currentTime;
        Toast.show("Double Click to exit app", context, duration: Toast.LENGTH_LONG,backgroundColor: Colors.white,textColor: Colors.black,
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
            Navigator.of(context).popAndPushNamed('edittransportorprofile');
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
                          child: Text('${Global.loginModel.result.firstName} ${Global.loginModel.result.lastName}',
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
          color: AppColors.primaryColor,
        ),
      ),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.car_rental,color: Colors.white,size: 25,),
          )),
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
            color: AppColors.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/car.png',height: 25,color: Colors.white,),
          )),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('Vehicle',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
         
          Navigator.of(context).popAndPushNamed('vehiclelist');
        
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/driver.png',height: 25,color: Colors.white),
          )),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('Driver',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
          
          Navigator.of(context).popAndPushNamed('addemployee');
        
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
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
          
          Navigator.of(context).popAndPushNamed('THistoryList');
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/survey.png',height: 25,color: Colors.white,),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text('Survey',
          style: TextStyle(
                                                                fontFamily: 'Shruti',
                                                                fontSize: 20,
                                                                fontWeight: FontWeight.w600,
                                                                color: AppColors.darkColor,
                                                              ),),
        ),
        onTap: () {
         
          Navigator.of(context).popAndPushNamed('TSurvey');
        
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
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
          
          Navigator.of(context).popAndPushNamed('TAbout');
       
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
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
         
          Navigator.of(context).popAndPushNamed('TContact');
        
        },
      ),
          Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
          ),
          child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset('assets/images/accepted.png',height: 25,color: Colors.white,),
        )),
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
        
          Navigator.of(context).popAndPushNamed('TTermsPrivacy');
         
        },
      ),
      Divider(color: Colors.black,),
       ListTile(
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor
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
          authProvider.deletetransportorData();
          authProvider.deletetoken();
          Navigator.of(context).popAndPushNamed('login');         
        },
      ),
      //     Divider(color: Colors.black,),
      // ListTile(
      //   leading: Container(
      //     decoration: BoxDecoration(
      //       shape: BoxShape.circle,
      //       color: AppColors.primaryColor
      //     ),
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Image.asset('assets/images/help.png',height: 25,color: Colors.white),
      //     ),
      //   ),
      //   title: Padding(
      //     padding: EdgeInsets.only(top: 5),
      //     child: Text("FaQ",
      //     style: TextStyle(
      //                                                           fontFamily: 'Shruti',
      //                                                           fontSize: 20,
      //                                                           fontWeight: FontWeight.w600,
      //                                                           color: AppColors.darkColor,
      //                                                         ),),
      //   ),
      //   onTap: () {
         
      //     Navigator.of(context).popAndPushNamed('TFaQ');
       
      //   },
      // ),
          Divider(color: Colors.black,),
    ],
  ),
  
);

}
   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
           onWillPop: onWillPop,
                  child: Scaffold(
            backgroundColor: AppColors.primaryColor,
           drawer:  drawer(),        
            appBar: AppBar(
              leading: Builder(
          builder: (context) => IconButton(
              icon:  Container(
      padding: EdgeInsets.all(2),
      height: 30,
      width: 30,
      decoration: 
          BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/SkeletonScreenDesign/Big-Icon-Holder.png'),
              fit: BoxFit.cover,
              ),
             ),
              child: Icon(Icons.menu,size: 20,),
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
              automaticallyImplyLeading: false,
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              
              flexibleSpace: Container(
    decoration: 
      BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SkeletonScreenDesign/Header-Bg.png'),
            fit: BoxFit.cover,
          ),
      ),
      ),
    title: Row(
                children: [
 
             Padding(
                padding: const EdgeInsets.only(left : 5.0),
               child: Image.asset('assets/images/SkeletonScreenDesign/Header-Logo.png',height: 50,width: 50,),
                ),
                  Padding(
                      padding: const EdgeInsets.only(left : 10.0),
                    child: Text('BLU WAY SE',style: TextStyle(
                      fontFamily: 'Arial',
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 20
                    ),),
                  ),
                ],
              ),
              backgroundColor: Colors.white,
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
                            FutureBuilder<TransportorOrderList>(
                            future:  transPorterOrderList(),  
                            builder: (context,snapshot){
                              if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.data.status == 'success') {
                                  if (snapshot.data.token.isNotEmpty) {
                                    setState(() {
                                      Global.accessToken = snapshot.data.token;
                                    });
                                  }
                              if (snapshot.data.result.isNotEmpty) {
                                    return Container(
                                height: SizeConfig.safeBlockVertical*90,
                                child: ListView.builder(
                                  itemCount: snapshot.data.result.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index){
                                    print(snapshot.data.result[index].createdDate);
                                   DateTime now = DateFormat("yyyy-MM-dd").parse(snapshot.data.result[index].createdDate);
                                    return Card(
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
                                                 Text('Products Name : ',
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
                                          snapshot.data.result[index].driver == null ? Container():   Row(
                                               children: [
                                                 Text('Assigned Driver : ',
                                                 style: TextStyle(
                                                   color: Colors.grey[500],
                                                   fontSize: 16 
                                                 ),),
                                                 Text('${snapshot.data.result[index].driver.firstName} ${snapshot.data.result[index].driver.lastName}',
                                                 style: TextStyle(
                                                   fontSize: 16
                                                 ),
                                                 )
                                               ],
                                             ),
                                             Padding(
                                               padding: EdgeInsets.only(top: 10),
                                               child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                     Expanded(
                                                        child: RaisedButton(
                                                         shape: RoundedRectangleBorder(
                                                           borderRadius: BorderRadius.circular(10)
                                                         ),
                                                         color: AppColors.primaryColor,
                                                         child: Text('Assign',
                                                           style: TextStyle(
                                                             fontWeight: FontWeight.w600,
                                                             fontSize: 20,
                                                             color: AppColors.whiteColor
                                                           ),
                                                         ),
                                                         onPressed: (){
                                                         setState(() {
                                                             Global.assignmentDetails = snapshot.data.result[index];
                                                         });
                                                          Navigator.of(context).pushNamed('AssignOrderScreen');
                                                         }),
                                                     ),
                                                     SizedBox(width: 10,),
                                                   Expanded(
                                                        child: RaisedButton(
                                                       shape: RoundedRectangleBorder(
                                                         borderRadius: BorderRadius.circular(10)
                                                       ),
                                                       color: AppColors.primaryColor,
                                                       child: Text('Track',
                                                         style: TextStyle(
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 20,
                                                           color: AppColors.whiteColor
                                                         ),
                                                       ),
                                                       onPressed: (){
                                                         setState(() {
                                                             Global.assignmentDetails = snapshot.data.result[index];
                                                         });
                                                         Navigator.of(context).pushNamed('mapsscreen');
                                                       }),
                                                   ),
                                                 ],
                                               ),
                                               )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                 );
                                  }
                                  else{
                                  return  Text('No Data',style: TextStyle(fontSize: 20,color: Colors.white));
                                  }
                                }
                              }
                              return Center(child: CircularProgressIndicator(backgroundColor: Colors.white));
                            },
                            )
                          ]))));})),
        ))
    );
  }
}