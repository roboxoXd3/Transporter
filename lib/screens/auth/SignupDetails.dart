import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:Transporter/data/models/AuthModel/Registration.dart';
import 'package:Transporter/data/models/AuthModel/TransPorterList.dart';
import 'package:Transporter/data/models/AuthModel/UserDataModel.dart';
import 'package:Transporter/data/models/DistictList.dart';
import 'package:Transporter/data/models/StateList.dart';
import 'package:Transporter/util/Country.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:Transporter/util/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:intl/intl.dart';
import 'dart:io' as Io;

import 'package:toast/toast.dart';

class SignupDetails extends StatefulWidget {
  SignupDetails({Key key}) : super(key: key);

  @override
  _SignupDetailsState createState() => _SignupDetailsState();
}

class _SignupDetailsState extends State<SignupDetails> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController fHname = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController postoffice = TextEditingController();
  TextEditingController thana = TextEditingController();
  TextEditingController pincode = TextEditingController();
  TextEditingController occupation = TextEditingController();
  TextEditingController indentityDoc = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController email = TextEditingController();
  UserDataModel userDataModel = UserDataModel();
  DateTime selectedDate = DateTime.now();
  bool autoValidate = false;
  AutovalidateMode autovalidate = AutovalidateMode.disabled;
  List<String> organization = ['test1', 'test2', 'test3'];
  List<String> role = ['test1', 'test2', 'test3'];
  StateList stateList = StateList();
  DistictList distictList = DistictList();
  List<Result> stateresult = [];
  List<DistictResult> districtresult = [];
  List<TransporterListResult> transportorlist = [];
  DistictResult test = DistictResult();
  List countries = [];
  String selectedCountry = '';
  File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
  String stateid = '';
  String districtId = '';
  String img64 = '';
  String gender = '';
  String selectedTransporter = '';
  List<String> documenttype = [
    'Aadhar Card',
    'Voter Id Card',
    'PAN Card',
    'Driving License'
  ];
  String selectedDocument = '';
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() {
    fetchStateListModel().then((value) {
      setState(() {
        stateList = value;
        stateresult = stateList.result;
      });
    });
    transporterListModel().then((value) {
      setState(() {
        transportorlist = value.result;
      });
    });
  }

  fetchDistrict(String id) {
    fetchDistrictListModel(id).then((value) {
      setState(() {
        distictList = value;
        districtresult = distictList.result;
        print(distictList.result.isEmpty);
        test = distictList.result[0];
      });
    });
  }

  getImageFile(ImageSource source) async {
    //pickImage(source: source);
    final picker = ImagePicker();
    var selectedimage = await picker.getImage(source: source);

    if (selectedimage != null) {
      croppedFile = await ImageCropper.cropImage(
          sourcePath: selectedimage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: AppColors.appBarColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (croppedFile != null) {
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 88,
            percentage: 80);
        print(compressedFile.lengthSync());
        setState(() {
          _image = compressedFile;
          print("This the Image $_image");
          print("This is the compressed image size :-${_image?.lengthSync()}");
          makeVisible = true;
          final bytes = Io.File(_image.path).readAsBytesSync();

          img64 = base64Encode(bytes);
        });
      }
    }
  }

  //Bottom Sheet
  void imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150.0,
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label: Text('Camera'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      //image = "";
                      getImageFile(ImageSource.camera);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label: Text('Gallery'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();

                      getImageFile(ImageSource.gallery);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.photo_library),
                  ),
                )
              ],
            ),
          );
        });
  }

  void loginSubmitted() {
    print(email.text);
    if (_formKey.currentState.validate() || _image != null) {
      resgistrationModel(
              transporter: selectedTransporter,
              fname: fname.text,
              lname: lname.text,
              email: email.text,
              gender: gender,
              dob: dob.text,
              fathername: fHname.text,
              address: address.text,
              village: village.text,
              postoffice: postoffice.text,
              thana: thana.text,
              country: selectedCountry,
              state: stateid,
              distict: districtId,
              pincode: pincode.text,
              mobile: mobileNo.text,
              occupation: occupation.text,
              document: selectedDocument,
              docimage: img64)
          .then((value) {
        if (value.status == 'success') {
          userDataModel = UserDataModel(
              active: value.data.active,
              otp: value.data.otp,
              verified: value.data.verified,
              deleted: value.data.deleted,
              sId: value.data.sId,
              firstName: value.data.firstName,
              lastName: value.data.lastName,
              village: value.data.village,
              postOffice: value.data.postOffice,
              thana: value.data.thana,
              state: value.data.state,
              district: value.data.district,
              pincode: value.data.pincode,
              document: value.data.document,
              documentImage: value.data.documentImage,
              mobile: value.data.mobile,
              userType: value.data.userType,
              master: value.data.master,
              masterName: value.data.masterName,
              createdDate: value.data.createdDate,
              iV: value.data.iV);
          Toast.show(value.message, context);
          Global.signupno = value.data.mobile;
          Global.userDataModel = userDataModel;
          _formKey.currentState.reset();
          //;
          mobileNo.clear();
          otp.clear();
          fname.clear();
          lname.clear();
          fHname.clear();
          address.clear();
          village.clear();
          postoffice.clear();
          thana.clear();
          pincode.clear();
          occupation.clear();
          indentityDoc.clear();
          dob.clear();
          email.clear();
          Navigator.of(context).pushNamed('signup');
        } else {
          Toast.show(value.message, context);
        }
      }).catchError((onError) {
        Toast.show('Something went wrong', context);
      });
    } else {
      if (_image == null) {
        Toast.show('Please upload the document', context);
      }
    }
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1980),
      lastDate: DateTime(2025),
    ).then((selectedDate) {
      if (selectedDate != null) {
        dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      }
    });
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
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
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: ExactAssetImage(
                                      'assets/images/login/BG-1.png'),
                                  fit: BoxFit.fill)),
                          height: SizeConfig.screenHeight,
                          child: LayoutBuilder(builder: (BuildContext context,
                              BoxConstraints viewportConstraints) {
                            return SingleChildScrollView(
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minHeight: viewportConstraints.maxHeight,
                                ),
                                child: Container(
                                  child: Stack(
                                    children: [
                                      Container(
                                          child: Image.asset(
                                              'assets/images/login/BG-2.png',
                                              width: SizeConfig.screenWidth)),
                                      Positioned(
                                        right: 20,
                                        top: 0,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  SizeConfig.safeBlockVertical *
                                                      1,
                                              left: 10),
                                          child: Container(
                                              child: Image.asset(
                                            'assets/images/Loginsignup/Blu-logo.png',
                                            height: 140,
                                            width: 140,
                                          )),
                                        ),
                                      ),
                                      Container(
                                          //height: SizeConfig.safeBlockVertical*76,
                                          child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 12.0,
                                            right: 12.0,
                                            top: SizeConfig.safeBlockVertical *
                                                22),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
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
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                    Shadow(
                                                      offset: Offset(1.0, 1.0),
                                                      blurRadius: 8.0,
                                                      color: Color.fromARGB(
                                                          125, 0, 0, 255),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            TextFormField(
                                              controller: fname,
                                              autovalidateMode: autovalidate,
                                              style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  color: AppColors.whiteColor,
                                                  fontSize: 22),
                                              validator: (val) {
                                                if (val.trim().isEmpty) {
                                                  return 'Please enter your name';
                                                }

                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'FIRST NAME',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            TextFormField(
                                              controller: lname,
                                              autovalidateMode: autovalidate,
                                              style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  color: AppColors.whiteColor,
                                                  fontSize: 22),
                                              validator: (val) {
                                                if (val.trim().isEmpty) {
                                                  return 'Please enter your Lastname';
                                                }

                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'LAST NAME',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            TextFormField(
                                              controller: email,
                                              autovalidateMode: autovalidate,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  color: AppColors.whiteColor,
                                                  fontSize: 22),
                                              validator: (val) {
                                                if (val.trim().isEmpty) {
                                                  return 'Please enter your Email';
                                                }
                                                return Validators.mustEmail(
                                                    val);
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Email',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                'GENDER',
                                                style: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                              ),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(
                                                  18, 0, 8, 8),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/images/Loginsignup/Field-01.png'),
                                                      fit: BoxFit.fill)),
                                              child:
                                                  new DropdownButtonFormField<
                                                      String>(
                                                isDense: true,
                                                style: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                hint: Text('Select GENDER',
                                                    style: TextStyle(
                                                        fontFamily: 'Shruti',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .textFeildcolor)),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none),
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Image.asset(
                                                    'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Feild Required'
                                                        : null,
                                                items: <String>[
                                                  'Male',
                                                  'Female',
                                                  'Not Specify',
                                                ].map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  setState(() {
                                                    gender = val;
                                                  });
                                                },
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller: dob,

                                                    autovalidateMode:
                                                        autovalidate,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    style: TextStyle(
                                                        fontFamily: 'Arial',
                                                        color: AppColors
                                                            .whiteColor,
                                                        fontSize: 22),
                                                    validator: (val) {
                                                      if (val.trim().isEmpty) {
                                                        return 'Please enter your Date of Birth';
                                                      }

                                                      return null;
                                                    },
                                                    // inputFormatters: [DateTextFormatter],
                                                    decoration: InputDecoration(
                                                      labelText:
                                                          'DATE OF BIRTH',
                                                      labelStyle: TextStyle(
                                                          fontFamily: 'Shruti',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 20,
                                                          color: AppColors
                                                              .textFeildcolor),
                                                      border: InputBorder.none,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      _selectDate(context);
                                                    },
                                                    child: Image.asset(
                                                      'assets/images/Loginsignup/Calender-Icon-01.png',
                                                      height: 30,
                                                      width: 30,
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: fHname,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Name ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText:
                                                      'FATHER/HUSBAND NAME',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: address,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Address ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'ADDRESS1',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: village,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Village ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'VILLAGE',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: postoffice,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Post Office ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'POST OFFICE',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: thana,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Thane ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'THANA',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Text(
                                              'TRANSPORTER',
                                              style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(
                                                  18, 0, 8, 8),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/images/Loginsignup/Field-01.png'),
                                                      fit: BoxFit.fill)),
                                              child:
                                                  new DropdownButtonFormField<
                                                      TransporterListResult>(
                                                isDense: true,
                                                isExpanded: true,
                                                style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor,
                                                ),
                                                hint: Text('Select Transporter',
                                                    style: TextStyle(
                                                        fontFamily: 'Shruti',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .textFeildcolor)),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none),
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Image.asset(
                                                    'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Feild Required'
                                                        : null,
                                                items: transportorlist.map<
                                                        DropdownMenuItem<
                                                            TransporterListResult>>(
                                                    (TransporterListResult
                                                        value) {
                                                  return new DropdownMenuItem<
                                                      TransporterListResult>(
                                                    value: value,
                                                    child: new Text(value.name),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedTransporter =
                                                        val.sId;
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(
                                              'COUNTRY',
                                              style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(
                                                  18, 0, 8, 8),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/images/Loginsignup/Field-01.png'),
                                                      fit: BoxFit.fill)),
                                              child:
                                                  new DropdownButtonFormField<
                                                      String>(
                                                isDense: true,
                                                isExpanded: true,
                                                style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor,
                                                ),
                                                hint: Text('Select',
                                                    style: TextStyle(
                                                        fontFamily: 'Shruti',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .textFeildcolor)),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none),
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Image.asset(
                                                    'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Feild Required'
                                                        : null,
                                                items: countryList
                                                    .map((String value) {
                                                  return new DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: new Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (val) {
                                                  setState(() {
                                                    selectedCountry = val;
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(
                                              'STATE',
                                              style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(
                                                  18, 0, 8, 8),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/images/Loginsignup/Field-01.png'),
                                                      fit: BoxFit.fill)),
                                              child:
                                                  new DropdownButtonFormField<
                                                      Result>(
                                                isDense: true,
                                                style: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                hint: Text('Select State',
                                                    style: TextStyle(
                                                        fontFamily: 'Shruti',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .textFeildcolor)),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none),
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Image.asset(
                                                    'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Feild Required'
                                                        : null,
                                                items: stateresult.map<
                                                    DropdownMenuItem<
                                                        Result>>((Result item) {
                                                  return DropdownMenuItem<
                                                      Result>(
                                                    value: item,
                                                    child: Text(item.name),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  print(value.sId);
                                                  setState(() {
                                                    stateid = value.sId;
                                                    fetchDistrict(stateid);
                                                  });
                                                },
                                              ),
                                            ),
                                            Text(
                                              'DISTRICT',
                                              style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor),
                                            ),

                                            Container(
                                              width: double.infinity,
                                              padding: EdgeInsets.fromLTRB(
                                                  18, 0, 8, 8),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: ExactAssetImage(
                                                          'assets/images/Loginsignup/Field-01.png'),
                                                      fit: BoxFit.fill)),
                                              child:
                                                  new DropdownButtonFormField<
                                                      DistictResult>(
                                                isDense: true,
                                                value: test,
                                                style: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                hint: Text('Select District',
                                                    style: TextStyle(
                                                        fontFamily: 'Shruti',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: AppColors
                                                            .textFeildcolor)),
                                                decoration: InputDecoration(
                                                    enabledBorder:
                                                        InputBorder.none),
                                                icon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Image.asset(
                                                    'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                    height: 15,
                                                    width: 15,
                                                  ),
                                                ),
                                                validator: (value) =>
                                                    value == null
                                                        ? 'Feild Required'
                                                        : null,
                                                items: districtresult.map<
                                                        DropdownMenuItem<
                                                            DistictResult>>(
                                                    (DistictResult item) {
                                                  return DropdownMenuItem<
                                                      DistictResult>(
                                                    value: item,
                                                    child: Text(item.name),
                                                  );
                                                }).toList(),
                                                onChanged: stateid.isEmpty
                                                    ? null
                                                    : (value) {
                                                        print(value.sId);
                                                        setState(() {
                                                          test = value;
                                                          districtId =
                                                              value.sId;
                                                        });
                                                      },
                                              ),
                                            ),
                                            TextFormField(
                                              controller: pincode,
                                              autovalidateMode: autovalidate,
                                              keyboardType: TextInputType.phone,
                                              style: TextStyle(
                                                  fontFamily: 'Arial',
                                                  color: AppColors.whiteColor,
                                                  fontSize: 22),
                                              validator: (val) {
                                                if (val.trim().isEmpty) {
                                                  return 'Please enter Pincode';
                                                }

                                                return null;
                                              },
                                              maxLength: 6,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'PIN CODE',
                                                labelStyle: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: mobileNo,
                                                maxLength: 10,
                                                keyboardType:
                                                    TextInputType.phone,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Mobile No ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'MOBILE NO',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: TextFormField(
                                                controller: occupation,
                                                keyboardType:
                                                    TextInputType.name,
                                                style: TextStyle(
                                                    fontFamily: 'Arial',
                                                    color: AppColors.whiteColor,
                                                    fontSize: 22),
                                                validator: (val) {
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter Occupation  ';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  labelText: 'OCCUPATION',
                                                  labelStyle: TextStyle(
                                                      fontFamily: 'Shruti',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 20,
                                                      color: AppColors
                                                          .textFeildcolor),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                            Container(
                                                child: Image.asset(
                                              'assets/images/Loginsignup/Line-1.png',
                                            )),
                                            //
                                            Text(
                                              'IDENTITY DOCUMENT',
                                              style: TextStyle(
                                                  fontFamily: 'Shruti',
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                  color:
                                                      AppColors.textFeildcolor),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.fromLTRB(
                                                    18, 0, 8, 8),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: ExactAssetImage(
                                                            'assets/images/Loginsignup/Field-01.png'),
                                                        fit: BoxFit.fill)),
                                                child:
                                                    new DropdownButtonFormField<
                                                        String>(
                                                  isDense: true,
                                                  isExpanded: true,
                                                  style: TextStyle(
                                                    fontFamily: 'Shruti',
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 20,
                                                    color: AppColors
                                                        .textFeildcolor,
                                                  ),
                                                  hint: Text('Select Document',
                                                      style: TextStyle(
                                                          fontFamily: 'Shruti',
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 18,
                                                          color: AppColors
                                                              .textFeildcolor)),
                                                  decoration: InputDecoration(
                                                      enabledBorder:
                                                          InputBorder.none),
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Image.asset(
                                                      'assets/images/Loginsignup/DropDown-Icon-01.png',
                                                      height: 15,
                                                      width: 15,
                                                    ),
                                                  ),
                                                  validator: (value) =>
                                                      value == null
                                                          ? 'Feild Required'
                                                          : null,
                                                  items: documenttype
                                                      .map((String value) {
                                                    return new DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: new Text(value),
                                                    );
                                                  }).toList(),
                                                  onChanged: (val) {
                                                    setState(() {
                                                      selectedDocument = val;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                            // Container(
                                            //     child: Image.asset('assets/images/Loginsignup/Line-1.png',)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'UPLOAD DOCUMENT',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                'Shruti',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20,
                                                            color: AppColors
                                                                .textFeildcolor),
                                                      ),
                                                      _image != null
                                                          ? Text(
                                                              'Image Uploaded',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Arial',
                                                                  color: AppColors
                                                                      .whiteColor,
                                                                  fontSize: 22))
                                                          : Container()
                                                    ],
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        imageModalBottomSheet(
                                                            context);
                                                      },
                                                      child: Image.asset(
                                                        'assets/images/Loginsignup/Upload-Icon-01.png',
                                                        height: 50,
                                                        width: 50,
                                                      ))
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Container(
                                                  child: Image.asset(
                                                'assets/images/Loginsignup/Line-1.png',
                                              )),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 15.0),
                                              child: Center(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .safeBlockVertical *
                                                          3),
                                                  child: GestureDetector(
                                                    onTap: loginSubmitted,
                                                    child: Container(
                                                      width: 230,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: ExactAssetImage(
                                                                  'assets/images/Loginsignup/BT-1.png'),
                                                              fit:
                                                                  BoxFit.fill)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Center(
                                                          child: Text(
                                                            'SUBMIT',
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'Arial',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: AppColors
                                                                    .whiteColor,
                                                                fontSize: 18),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                    )))));
  }
}

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
