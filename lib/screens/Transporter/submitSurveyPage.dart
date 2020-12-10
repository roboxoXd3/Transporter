import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:Transporter/data/models/DistictList.dart';
import 'package:Transporter/data/models/StateList.dart';
import 'package:Transporter/data/models/TransportorModel/submitSurvey.dart';
import 'package:Transporter/util/Country.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';
class SubmitSurveyForm extends StatefulWidget {
  SubmitSurveyForm({Key key}) : super(key: key);

  @override
  _EditTransportorProfileState createState() => _EditTransportorProfileState();
}

class _EditTransportorProfileState extends State<SubmitSurveyForm> {

  TextEditingController fnameName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController village = TextEditingController();
  TextEditingController postoffice = TextEditingController();
  TextEditingController thana = TextEditingController();
  TextEditingController address = TextEditingController();
  final Geolocator _geolocator = Geolocator();
  String selectedCountry = '';
  String stateid = '';
  String districtid = '';
  TextEditingController pincode = TextEditingController();
  String profileimage = '';
  String gender;
  File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController dob = TextEditingController();
  StateList stateList = StateList();
  DistictList distictList = DistictList();
  List<Result> stateresult = [];
  List<DistictResult> districtresult = [];
  List countries = [];
  String lat = '';
  String long = '';
  String type;
  final _formKey = GlobalKey<FormState>();
  bool readonly = true;
  DistictResult test = DistictResult();
  @override
  void initState() { 
    super.initState();
    getLocation();
    initData();
  }

   getLocation() async{
     final ph = PermissionHandler();
     ph.requestPermissions([PermissionGroup.location]);
      _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((Position position) {
            
            print(position.latitude);
            print(position.longitude);
      });
     
     }
   initData(){
    fetchStateListModel().then((value) {
       setState(() {
         stateList = value;
         stateresult = stateList.result;
         
       });
    });
  fetchDistrictListModel(Global.loginModel.result.state).then((value) {
      setState(() {
        distictList = value;
        districtresult = distictList.result;
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
          final bytes = Io.File(compressedFile.path).readAsBytesSync();
          String img64 = base64Encode(bytes);
          
            profileimage = img64;
         
        });
      }
    }
  }

  submitsurevy(){
    if (_formKey.currentState.validate() && profileimage.isNotEmpty) {
       submitSurevy(
      surveyid: Global.transporterSurveyList.sId,
      userid: Global.userDataModel.sId,
      fullname: fnameName.text,
      address: address.text,
      village: village.text,
      postOffice: postoffice.text,
      thana: thana.text,
      country: selectedCountry,
      state: stateid,
      distict: districtid,
      pincode: pincode.text,
      mobile: phone.text,
      gender: gender,
      productid: Global.transporterSurveyList.unitValue,
      qntity: Global.transporterSurveyList.qty.toString(),
      image: profileimage,
      lal: lat,
      long: long,
    ).then((value) {
      if (value.status == 'success') {
        Navigator.of(context).pop();
        Toast.show(value.message , context);
      } else {
        Toast.show(value.message , context);
      }
    });
    } else {
      Toast.show('Please upload Image' , context);
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
                    label:
                        Text('Camera'),
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
                    label:
                        Text('Gallery'),
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
 
  @override
  Widget build(BuildContext context) {
   
    return ModalProgressHUD(
      inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: CircularProgressIndicator(),
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white
              ),
              title: Text('Survey',style: TextStyle(
                fontFamily: 'Arial',
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22
              ),),
              backgroundColor: Colors.indigo[600],
              
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
                        child: Form(
                            key: _formKey,
                            child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                               Padding(
                                 padding:  EdgeInsets.only(top : 10.0,left: SizeConfig.safeBlockHorizontal*8),
                                 child: GestureDetector(
                                   onTap: readonly ? null : (){
                                     
                                     imageModalBottomSheet(context);
                                   },
                                     child: Row(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                     children: [
                                       Column(
                                         children: [
                                           _image != null ? ClipRRect(
                                                        borderRadius: BorderRadius.circular(45),
                                                      child : Image.file(_image,height: 90,fit: BoxFit.cover,
                                                      width: 90,)
                                                    ): ClipRRect(
                                                       borderRadius: BorderRadius.circular(50),
                                                           child: Container(
                                                            color: AppColors.blueColor,
                                                             child: Image.network('https://leadslive.io/wp-content/uploads/2017/05/Miniclip-8-Ball-Pool-Avatar-11.png',
                                                                height: 100,
                                                                width: 100,
                                                                ),
                                                       ),
                                            ),
                                     Padding(
                                     padding: EdgeInsets.only(top: 15),
                                     child: Text('Upload',
                                     style: TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.orange[200],
                                                          ),
                                            ),
                                        ),
                                         ],
                                       ),
                                          Container(
                                                     padding: EdgeInsets.all(8),
                                                     margin:  EdgeInsets.all(8),
                                                     decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: AppColors.darkColor
                                                          ),
                                                          child: Icon(Icons.camera_alt,size: 20,color: Colors.white,),
                                                        )
                                     ],
                                   ),
                                 ),
                               ),
                               Padding(
                                 padding: EdgeInsets.only(top: 20),
                                 child: TextFormField(
                                   controller: fnameName,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter you FullName';
                                  }
                                  return null;
                                },
                                readOnly: readonly,
                              decoration: InputDecoration(
                                labelText: 'Full Name',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                              
                             Padding(
                               padding: EdgeInsets.only(top: 10),
                               child: DropdownButtonFormField<String>(
                                   isDense: true,
                                   isExpanded: true,
                                   style: TextStyle(
                                         fontFamily: 'Shruti',
                                         fontWeight: FontWeight.w600,
                                         fontSize: 20,
                                         color: AppColors.textFeildcolor,
                                         
                                       ),
                                   hint: Text('Select Country', style:  TextStyle(
                                                         fontFamily: 'Arial',
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.w500,
                                                              color: Colors.grey
                                                            )),
                                    decoration: InputDecoration(
                                           border : OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.5,color: Colors.grey),
                                  borderRadius: const BorderRadius.all(
                                  const Radius.circular(10.0),
                                  ),
                            )),
                                      
                                            validator: (value) =>
                                                     value == null
                                                         ? 'Feild Required'
                                                         : null,
                                   items: countryList.map((String value) {
                                         return new DropdownMenuItem<String>(
      
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
                              Padding(
                                padding: const EdgeInsets.only( top : 10.0),
                                child: new DropdownButtonFormField<String>(
                                       isDense: true,
                                       style:  TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                           color: Colors.black
                                                          ),
                                       hint: Text('Select Gender',style:  TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey
                                                          ),),
                                decoration: InputDecoration(
                                               border : OutlineInputBorder(
                                borderSide: BorderSide(width: 1.5,color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                const Radius.circular(10.0),
                                ),
                            )),
                                         
                                                validator: (value) =>
                                                         value == null
                                                             ? 'Feild Required'
                                                             : null,
                                       items: <String>['Male', 'Female', 'Not Specify',].map((String value) {
                                             return new DropdownMenuItem<String>(                                         
                                                value: value,
                                                child: new Text(value),
                                                  );
                                                 }).toList(),
                                                 onChanged: readonly ? null : (val) {
                                                   setState(() {
                                                     gender = val;
                                                   });
                                                 },
                                               ),
                              ),
                              Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: address,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the Address';
                                  }
                                  return null;
                                },
                              decoration: InputDecoration(
                                labelText: 'Address',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                              
                               Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: postoffice,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the Postoffice';
                                  }
                                  return null;
                                },
                              decoration: InputDecoration(
                                labelText: 'Post Office',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                               Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: thana,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the Thana';
                                  }
                                  return null;
                                },
                              decoration: InputDecoration(
                                labelText: 'Thana',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                             
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: new DropdownButtonFormField<Result>(
                                       isDense: true,
                                       style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                       hint: Text('Select State',style: TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey
                                                          )),
                                        decoration: InputDecoration(
                                               border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                  )),
                                          
                                                validator: (value) =>
                                                         value == null
                                                             ? 'Feild Required'
                                                             : null,
                                       items: stateresult.map<DropdownMenuItem<Result>>(
                                                    (Result item){
                                                     return DropdownMenuItem<Result>(
                                                     value: item,
                                                     child: Text(item.name),
                                                     );
                                                   }
                                                 ).toList(),
                                                 onChanged: readonly ? null :( value) {
                                                      print(value.sId);
                                                      setState(() {
                                                        fetchDistrictListModel(value.sId);
                                                        stateid = value.sId;
                                                      });
                                                 },
                                               ),
                                ),
                                Padding(
                                 padding: EdgeInsets.only(top: 10),
                                  child: new DropdownButtonFormField<DistictResult>(
                                       isDense: true,
                                       style: TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black
                                                          ),
                                       hint: Text('Select District',style: TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.grey
                                                          )),
                                        decoration: InputDecoration(
                                               border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                  )),
                                         
                                                validator: (value) =>
                                                         value == null
                                                             ? 'Feild Required'
                                                             : null,
                                                value: test,
                                       items: districtresult.map<DropdownMenuItem<DistictResult>>(
                                                    (DistictResult item){
                                                     return DropdownMenuItem<DistictResult>(
                                                     value: item,
                                                     child: Text(item.name),
                                                     );
                                                   }
                                                 ).toList(),
                                                 onChanged: readonly ? null :(value) {
                                                   print(value.sId);
                                                   setState(() {
                                                     test = value;
                                                     districtid = value.sId;
                                                   });
                                                 },
                                               ),
                                ),
                               Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: pincode,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the Pincode';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Pincode',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                                Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: village,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the Village';
                                  }
                                  return null;
                                },
                              decoration: InputDecoration(
                                labelText: 'Village',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                              ),
                              ),
                              Padding(
                                 padding: EdgeInsets.only(top: 10),
                                 child: TextFormField(
                                   controller: phone,
                                     readOnly: readonly,
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.black
                                                        ),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please Enter the mobile No';
                                  }
                                  else if(val.trim().length < 10 || val.trim().length>10)
                                  {
                                    return 'Please enter a valid mobile no';}
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Mobile',
                                labelStyle: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.grey
                                                        ),
                               enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1.5,color: Colors.grey),
                              borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                              ),
                                ),
                                  ),
                                 ),
                              ),
                            
                              
                            
                              Padding(
                      padding: const EdgeInsets.only(top : 15.0),
                      child: Center(
                          child: RaisedButton(
                                    color: Colors.indigo[900],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                           child: Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Text('Submit Survey',style: TextStyle(
                                    fontFamily: 'Arial',
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20
                                    ),),
                                ),
                                            onPressed: submitsurevy),
                      ),
                    )
              ]),
                        ))));})))
      ),
    );
  }
}