import 'dart:ui';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';

class GroceryDetails extends StatefulWidget {
  GroceryDetails({Key key}) : super(key: key);

  @override
  _GroceryDetailsState createState() => _GroceryDetailsState();
}

class _GroceryDetailsState extends State<GroceryDetails> {
  @override
  Widget build(BuildContext context) {
   SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            title: Text('Orders',style: TextStyle(
              fontFamily: 'Shruti',
              color: AppColors.whiteColor,
              fontSize: 22
            ),),
            backgroundColor: AppColors.driverprimaryColor,
            actions: [
              IconButton(icon: Icon(Icons.notifications), onPressed: (){}),
              IconButton(icon: Icon(Icons.refresh), onPressed: (){}),
            ],
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
                            child: ListView.builder(
                              itemCount: 5,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
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
                                             Text('133',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Text('Order Date :',
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('2020-03-14',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                         ],
                                       ),
                                       Row(
                                           children: [
                                             Text('Society Name :',
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('Mira park',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Text('House No :',
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('23,Shreehari tower',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Text('Time :',
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('09:00:00 : 09:30:00',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                         Row(
                                           children: [
                                             Text("Receiver's Name :",
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('username',
                                             style: TextStyle(
                                               fontSize: 16
                                             ),
                                             )
                                           ],
                                         ),
                                        Row(
                                           children: [
                                             Text('Phone Number :  ',
                                             style: TextStyle(
                                               color: Colors.grey[500],
                                               fontSize: 16 
                                             ),),
                                             Text('123456789',
                                             style: TextStyle(
                                                decoration: TextDecoration.underline,
                                                color: Colors.pink[300],
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
                                               color: Colors.red[500],
                                               child: Text('VIEW DETAILS',
                                                 style: TextStyle(
                                                   fontWeight: FontWeight.w600,
                                                   fontSize: 20,
                                                   color: AppColors.whiteColor
                                                 ),
                                               ),
                                               onPressed: (){
                                                 Navigator.of(context).pushNamed('orderdetails');
                                               }),
                                           ),
                                           )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          )
                        ]))));})))
    );
  }
}

