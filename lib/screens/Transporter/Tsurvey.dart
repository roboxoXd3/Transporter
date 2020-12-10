import 'package:Transporter/data/models/TransportorModel/TransporterSurvey.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class TSurvey extends StatefulWidget {
  TSurvey({Key key}) : super(key: key);

  @override
  _TSurveyState createState() => _TSurveyState();
}

class _TSurveyState extends State<TSurvey> {
  
  TransporterSurveyList transporterSurveyList = TransporterSurveyList();

  @override
  void initState() { 
     super.initState();
     initdata();
  }
  initdata(){
    transPorterSurveyList().then((value) {
      if (value.status == 'success') {
        setState(() {
          transporterSurveyList = value;
        });
      } else {
        Toast.show(value.status, context);
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: AppColors.whiteColor
            ),
            title: Text('Survey',style: TextStyle(
              fontFamily: 'Shruti',
              color: AppColors.whiteColor,
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
                            child: ListView.builder(
                              itemCount: transporterSurveyList.products.length,
                              shrinkWrap: true,
                              itemBuilder: (context,index){
                                return GestureDetector(
                                  onTap: (){
                                    Global.transporterSurveyList = transporterSurveyList.products[index];
                                    Navigator.of(context).pushNamed('submitsurveyform');
                                  },
                                  child: Card(
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
                                               Text('Quantity : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16
                                               ),),
                                               Text(transporterSurveyList.products[index].qty.toString(),
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
                                               Text('Name : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(transporterSurveyList.products[index].name,
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                        ),
                                           Row(
                                             children: [
                                               Text('Manufacturing price : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(transporterSurveyList.products[index].manufacturingPrice,
                                               style: TextStyle(
                                                 fontSize: 16
                                               ),
                                               )
                                             ],
                                           ),
                                           Row(
                                             children: [
                                               Text('Selling price : ',
                                               style: TextStyle(
                                                 color: Colors.grey[500],
                                                 fontSize: 16 
                                               ),),
                                               Text(transporterSurveyList.products[index].sellingPrice,
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
                                );
                              }),
                          )
                        ]))));})))
    );
  }
}