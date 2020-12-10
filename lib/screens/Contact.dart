import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  Contact({Key key}) : super(key: key);

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  Future<void> _launched;

  String _phone = Global.settingModel.data[1].value;
  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
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
            title: Text('Contact',style: TextStyle(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset('assets/images/contact.jpg'),
                   Text('Email : ${Global.settingModel.data[0].value} ',style: TextStyle(
                   
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  )),
                 Text('Phone No : ${Global.settingModel.data[1].value} ',style: TextStyle(
                   
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  )),
                          RaisedButton(
                            color: AppColors.driverprimaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                                    
                            ),
                   child: Text('Call Us',style: TextStyle(
                          fontFamily: 'Arial',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 20
                  ),),
                                    onPressed: (){
                                      setState(() {
                                        _launched = _makePhoneCall('tel:$_phone');
                                      });
                                    })
                        ]))));})))
    );
  }
}