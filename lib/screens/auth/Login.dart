import 'dart:ui';
import 'package:Transporter/data/models/AuthModel/DriverVerifyModel.dart';
import 'package:Transporter/data/models/AuthModel/VerifyModel.dart';
import 'package:Transporter/data/models/AuthModel/loginModel.dart';
import 'package:Transporter/util/AuthProvider.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool autoValidate = false;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  String _character = 'Driver';
  String otpReceived = '';
  AuthProvider authProvider = AuthProvider();


  void loginSubmitted(){
   FocusScope.of(context).unfocus();
    if (_formKey.currentState.validate()) {
      if (_character == 'Transporter') {
        setState(() => Global.isLoading = true);
     loginModel(
       otp: otp.text,
       mobileNo: mobileNo.text
     ).then((value) {
       setState(() => Global.isLoading = false);
         if (value.status == 'success') {
           Global.loginModel = value;
           authProvider.settoken(value: value.token);          
           Global.accessToken = authProvider.gettoken();
        saveTransporterData(value);
       Navigator.of(context).pushNamed('homescreen');
     
         }
         else {
         Toast.show(value.message, context,
          backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
         }
     });
  } else {
    setState(() => Global.isLoading = true);
     driverloginModel(
       otp: otp.text,
       mobileNo: mobileNo.text
     ).then((value) {
       setState(() => Global.isLoading = false);
         if (value.status == 'success') {
          saveDriverData(userModel : value);
           authProvider.settoken(value: value.token);          
           Global.accessToken = authProvider.gettoken();
       Navigator.of(context).pushNamed('driverHomescreen');
         }
         else {
         Toast.show(value.message, context,
          backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
         }
     });
   }
    } else {
    }
  }

 getotp(){
   FocusScope.of(context).unfocus();
   if (_character == 'Transporter') {
  setState(() {
     Global.isLoading = true;
   });
   fetchOtpModel(mobileNo: mobileNo.text).then((value) {
     setState(() {
     Global.isLoading = false;
   });
      if (value.status == 'success') {
        setState(() {
          otpReceived = value.oTP.toString();
          Toast.show(value.message, context,
          backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
        });
      }
      else{
        Toast.show(value.message, context,backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
      }
   });
   } else {
      setState(() {
     Global.isLoading = true;
   });
   fetchDriverOtpModel(mobileNo: mobileNo.text).then((value) {
     setState(() {
     Global.isLoading = false;
   });
      if (value.status == 'success') {
        setState(() {
          otpReceived = value.oTP.toString();
          Toast.show(value.message, context,
          backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
        });
      }
      else{
        Toast.show(value.message, context,backgroundColor: Colors.white,textColor: Colors.black,duration: 2,);
      }
   });
   }
  
 }

 void saveDriverData({DriverUserModel userModel}){
     authProvider.setDriverData(user: userModel);
     setState(() {
       Global.driverUserModel = authProvider.getDriverData();
     });
 }
 void saveTransporterData(LoginModel userModel){
   authProvider.settransportorData(user: userModel);
   setState(() {
     Global.loginModel = authProvider.gettransportorData();
   });
 }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: CircularProgressIndicator(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Form(
              key: _formKey,
             child: Container(
              width: double.infinity,   
             // height: SizeConfig.screenHeight,  
              child: LayoutBuilder(builder: (BuildContext context,BoxConstraints viewportConstraints){
                return ConstrainedBox(
                 constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                       height: SizeConfig.screenHeight,
                          child: Stack(
                            children: [            
                            Padding(
                              padding:  EdgeInsets.only(top : SizeConfig.safeBlockVertical*4),
                              child: Container(child: Image.asset('assets/images/Loginsignup/Blu-SubBG-04.png',width: SizeConfig.screenWidth,height: SizeConfig.safeBlockVertical*40,)),
                            ),
                            Padding(
                              padding:  EdgeInsets.only(top : SizeConfig.safeBlockVertical,left: 10),
                              child: Container(child: Image.asset('assets/images/Loginsignup/Blu-logo.png',height: 140,width: 140,)),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: SizeConfig.safeBlockVertical*83,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: ExactAssetImage('assets/images/Loginsignup/Blu-SubBG-05.png'),
                                      fit: BoxFit.fill
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left : 12.0,right: 12.0,top: 0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                           Container(child: Image.asset('assets/images/Loginsignup/Auto-01.png',height: 140,width: 140,)),
                                            Padding(
                                              padding: const EdgeInsets.only(right : 8.0),
                                              child: Text(
                                                  'Login',
                                                    style: TextStyle(
                                                      fontSize: 30,
                                                      fontFamily: 'Shruti',
                                                      color: Color(0xffaedcff),
                                                     shadows: <Shadow>[
                                                          Shadow(
                                                             offset: Offset(1.0, 1.0),
                                                                    blurRadius: 3.0,
                                                                    color: Color.fromARGB(255, 0, 0, 0),
                                                                 ),
                                                          Shadow(
                                                           offset: Offset(1.0, 1.0),
                                                           blurRadius: 8.0,
                                                           color: Color.fromARGB(125, 0, 0, 255),
                                                                ),
                                             ],
                                               ),
                                         ),
                                            ),
                                        ],
                                      ),
                                      SizedBox(
                                         height: 90,
                                          child: TextFormField(
                                          controller: mobileNo,
                                          
                                          autovalidateMode: autovalidate,
                                          style: TextStyle(
                                            fontFamily: 'Arial',
                                            color: AppColors.whiteColor,
                                            fontSize: 22
                                          ),
                                          keyboardType: TextInputType.phone,
                                          validator: (val){
                                            if (val.trim().isEmpty) {
                                              return 'Please enter Mobile no';
                                            }
                                            else if (val.length > 10 || val.length <10){
                                               return 'Please enter valid mobile No';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'MOBILE NUMBER',
                                            contentPadding: const EdgeInsets.only(top :0.0),
                                            labelStyle: TextStyle(
                                              fontFamily: 'Shruti',
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20,
                                              color: AppColors.textFeildcolor
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                       Container(child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                                       Padding(
                                         padding: const EdgeInsets.only(top : 8.0),
                                         child: SizedBox(
                                             height: 80,
                                            child: TextFormField(
                                            controller: otp,
                                           
                                            style: TextStyle(
                                            fontFamily: 'Arial',
                                            color: AppColors.whiteColor,
                                            fontSize: 22
                                        ),
                                           validator: (val){
                                            if (val.trim().isEmpty) {
                                              return 'Please enter Otp ';
                                            }
                                            else if (otpReceived != val)
                                                {
                                                  return 'Otp inCorrect';
                                                }
                                            return null;
                                           },
                                           keyboardType: TextInputType.phone,
                                            decoration: InputDecoration(
                                               contentPadding: const EdgeInsets.only(top :0.0),
                                              labelText: 'OTP',
                                              labelStyle: TextStyle(
                                                fontFamily: 'Shruti',
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                                color: AppColors.textFeildcolor
                                              ),
                                              border: InputBorder.none,
                                            ),
                                      ),
                                         ),
                                    ),
                                       Container(
                                         child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                                 Padding(
                                   padding:  EdgeInsets.only( top : SizeConfig.safeBlockVertical*3),
                                   child: GestureDetector(
                                     onTap: (){
                                       setState(() {
                                         autovalidate = AutovalidateMode.always;
                                       });
                                       if (mobileNo.text.isNotEmpty) {
                                         print('otp Called');
                                         getotp();
                                       }
                                     },
                                         child: Container(
                                          decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: ExactAssetImage('assets/images/Loginsignup/BT-2.png'),
                                          fit: BoxFit.fill
                                        )
                                       ),
                                       child: Padding(
                                         padding: const EdgeInsets.all(15.0),
                                         child: Text('GENERATE OTP',
                                         style: TextStyle(
                                               fontFamily: 'Arial',
                                               fontWeight: FontWeight.w600,
                                               color: AppColors.blueColor,
                                               fontSize: 18
                                         ),),
                                       ),
                                 ),
                                   ),
                                 ),
                          Row(
                            children: [
                              Expanded(
                                     child: ListTile(
                                        dense: true,
                                       contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                        title: const Text('Driver',style: TextStyle(
                                                     fontFamily: 'Arial',
                                                     fontWeight: FontWeight.w600,
                                                     color: AppColors.whiteColor,
                                                     fontSize: 18
                                               ),),
                                      leading: Radio(
                                        activeColor: Color(0xffaedcff),
                                      value: 'Driver',
                                      groupValue: _character,
                                      onChanged: ( value) {
                                        setState(() {
                                        _character = value;
                                       });
                                      },
                               ),
                              ),
                              ),
                               Expanded(
                                  child: ListTile(
                                     contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                                     dense: true,
                                    title: const Text('Transporter',style: TextStyle(
                                                 fontFamily: 'Arial',
                                                 fontWeight: FontWeight.w600,
                                                 color: AppColors.whiteColor,
                                                 fontSize: 18
                                           ),),
                                  leading: Radio(
                                  value: 'Transporter',
                                    activeColor: Color(0xffaedcff),
                                  groupValue: _character,
                                  onChanged: ( value) {
                                    setState(() {
                                    _character = value;
                                   });
                                  },
                                 ),
                                 ),
                               ),
                            ],
                          ),
                                 Padding(
                                   padding:  EdgeInsets.only( top : SizeConfig.safeBlockVertical),
                                   child: GestureDetector(
                                     onTap: loginSubmitted,
                                     child: Container(
                                       width: 230,
                                          decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: ExactAssetImage('assets/images/Loginsignup/BT-1.png'),
                                          fit: BoxFit.fill
                                        )
                                       ),
                                       child: Padding(
                                         padding: const EdgeInsets.all(15.0),
                                         child: Center(
                                           child: Text('LOGIN',
                                           style: TextStyle(
                                                 fontFamily: 'Arial',
                                                 fontWeight: FontWeight.w600,
                                                 color: AppColors.whiteColor,
                                                 fontSize: 18
                                           ),),
                                         ),
                                       ),
                                 ),
                                   ),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.only(top : 15.0,bottom: 15),
                                   child: GestureDetector(
                                     onTap: () =>  Navigator.of(context).pushNamed('signupdetails'),
                                     child: Text("Don't have a account? Register",
                                     style: TextStyle(
                                                   fontFamily: 'Arial',
                                                   fontWeight: FontWeight.w600,
                                                   color: AppColors.whiteColor,
                                                   fontSize: 14
                                             )),
                                   ),
                                 )
                                    ],
                                  ),
                                )
                                ),
                            ),
                            ],
                          ),
                        ),
                  ],
                )),
              );
              })),
            )))));
  }
}

