import 'dart:ui';
import 'package:Transporter/data/models/AuthModel/VerifyModel.dart';
import 'package:Transporter/util/AuthProvider.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class Signup extends StatefulWidget {
  Signup({Key key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool autoValidate = false;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  AuthProvider authProvider = AuthProvider();
  
  
  @override
  void initState() {
    super.initState();
    mobileNo.text =  Global.signupno;
  }

  void loginSubmitted(){
    if (_formKey.currentState.validate()) {
         setState(() => Global.isLoading = true);
     loginModel(
       otp: otp.text,
       mobileNo: Global.signupno
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
     }).catchError((onError){
       setState(() => Global.isLoading = false);
        Toast.show('Something went wrong', context);
      });
     
    } else {
    }
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
          child: WillPopScope(
            onWillPop: () async => false,
                      child: Scaffold(
              resizeToAvoidBottomInset: true,
              
              body: Form(
                key: _formKey,
               child: Container(
                width: double.infinity,   
                 decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: ExactAssetImage('assets/images/login/BG-1.png'),
                                        fit: BoxFit.fill
                                      )
                                     ),
                height: SizeConfig.screenHeight,  
                child: LayoutBuilder(builder: (BuildContext context,BoxConstraints viewportConstraints){
                  return SingleChildScrollView(
                       child: ConstrainedBox(
                     constraints: BoxConstraints(
                          minHeight: viewportConstraints.maxHeight,
                        ),
                      child: Container(
                        child: Stack(
                          children: [                      
                          Container(child: Image.asset('assets/images/login/BG-2.png',width: SizeConfig.screenWidth)),
                          Positioned(
                             right: 20,
                             top: 0,
                             child: Padding(
                              padding:  EdgeInsets.only(top : SizeConfig.safeBlockVertical*1,left: 10),
                              child: Container(child: Image.asset('assets/images/Loginsignup/Blu-logo.png',height: 140,width: 140,)),
                            ),
                          ),
                            Container(
                              //height: SizeConfig.safeBlockVertical*76,
                              child: Padding(
                             padding:  EdgeInsets.only(left : 12.0,right: 12.0,top: SizeConfig.safeBlockVertical*22),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(right : 8.0),
                                   child: Text(
                                       'REGISTRATION',
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
                                
                            

                                 TextFormField(
                                   controller: mobileNo,
                                   readOnly: true,
                                   
                                   autovalidateMode: autovalidate,
                                     keyboardType: TextInputType.phone,
                                   style: TextStyle(
                                     fontFamily: 'Arial',
                                     color: AppColors.whiteColor,
                                     fontSize: 22
                                   ),
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
                                     labelStyle: TextStyle(
                                       fontFamily: 'Shruti',
                                       fontWeight: FontWeight.w600,
                                       fontSize: 20,
                                       color: AppColors.textFeildcolor
                                     ),
                                     border: InputBorder.none,
                                   ),
                                 ),
                                  Container(child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                                  Padding(
                                    padding: const EdgeInsets.only(top : 8.0),
                                    child: TextFormField(
                                     controller: otp,
                                     
                                     keyboardType: TextInputType.phone,
                                     style: TextStyle(
                                     fontFamily: 'Arial',
                                     color: AppColors.whiteColor,
                                     fontSize: 22
                                   ),
                                    validator: (val){
                                     if (val.trim().isEmpty) {
                                       return 'Please enter Otp ';
                                     }
                                     return null;
                                    },
                                     decoration: InputDecoration(
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
                                  Container(
                                    child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                            
                            Center(
                              child: Padding(
                                padding:  EdgeInsets.only( top : SizeConfig.safeBlockVertical*3,bottom: 10),
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
                                        child: Text('Register',
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
                            ),
                               ],
                             ),
                              )
                              ),
                          ],
                        ),
                      ),
                ),
                  );
                })),
              )),
          ))));
    
  }
}