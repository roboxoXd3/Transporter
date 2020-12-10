import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  _AboutListState createState() => _AboutListState();
}

class _AboutListState extends State<About> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            title: Text('About',style: TextStyle(
                    fontFamily: 'Arial',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [

                          Text(
                            Global.settingModel.data[2].value ?? 'No Data',
                           style: TextStyle(
                             fontSize: 18,
                           ),
                          )
                        ]))));})))
    );
  }
}