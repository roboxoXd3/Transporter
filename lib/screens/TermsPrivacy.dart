import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';

class TermsPrivacy extends StatefulWidget {
  TermsPrivacy({Key key}) : super(key: key);

  @override
  _TermsPrivacyState createState() => _TermsPrivacyState();
}

class _TermsPrivacyState extends State<TermsPrivacy> {
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
            title: Text("Terms & Privacy",style: TextStyle(
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
                            Global.settingModel.data[3].value ?? 'No data',
                           style: TextStyle(
                             fontSize: 18,
                           ),
                          ),
                                         Text(
                            Global.settingModel.data[4].value ?? 'No data',
                           style: TextStyle(
                             fontSize: 18,
                           ),
                          ),
                        ]))));})))
    );
  }
}