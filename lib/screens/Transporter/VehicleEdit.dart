import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:io' as Io;
import 'package:Transporter/data/models/TransportorModel/AddVehicle.dart';
import 'package:Transporter/data/models/TransportorModel/VehicleEdit.dart';
import 'package:Transporter/data/models/TransportorModel/VehicleList.dart';
import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/global.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class VehicleUpdate extends StatefulWidget {
  VehicleUpdate({Key key}) : super(key: key);

  @override
  _VehicleUpdateState createState() => _VehicleUpdateState();
}

class _VehicleUpdateState extends State<VehicleUpdate> {
  TextEditingController vehicleNumber = TextEditingController();
  TextEditingController vehiclename = TextEditingController();
  TextEditingController rcNumber = TextEditingController();
  TextEditingController selectVehicle = TextEditingController();
  TextEditingController expiryDate = TextEditingController();
  String vDataImage = '';
  File croppedFile;
  File result;
  String rcbook = '';
  String puc = '';
  String type = '';
  bool readonly = true;
  bool makeVisible = false;
  //final _formKey = GlobalKey<FormState>();
   final GlobalKey<FormState> _formKey =
      new GlobalKey<FormState>(debugLabel: '_loginFormKey');
  DateTime selectedDate = DateTime.now();
  VehicleListResult vehicledata = VehicleListResult();


//   _selectDate(BuildContext context) async {
//   final DateTime picked = await showDatePicker(
//     context: context,
//     initialDate: selectedDate, // Refer step 1
//     firstDate: DateTime(1980),
//     lastDate: DateTime(2025),
//     )
//    .then((selectedDate) {
//      if(selectedDate!=null){
//        setState(() {
//          expiryDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//        });
//      }}
//   );
//   if (picked != null && picked != selectedDate)
//     setState(() {
//       selectedDate = picked;
//       expiryDate.text = DateFormat('yyyy-MM-dd').format(selectedDate);
//     });
//  } 
 @override
 void initState() { 
   super.initState();
   vehiclename.text = Global.editvehicledata.name;
          vehicleNumber.text = Global.editvehicledata.number;
          rcNumber.text = Global.editvehicledata.rcNumber;
 }
  addVehicle(){
    if (readonly) {
      setState(() {
        readonly = false;
      });
    }
    else{
      if (_formKey.currentState.validate()) {
      setState(() {
        Global.isLoading = true;
      });
      
    editVehicleModel(
      id: Global.editvehicledata.sId,
      name: vehiclename.text,
      number: vehicleNumber.text,
      rcNo: rcNumber.text,
      vDataImage: vDataImage,
      rcImage: rcbook,
      pucImage: puc
    ).then((value) {
      setState(() {
        Global.isLoading = false;
      });
      if (value.message == 'Vehicle updated') {
        setState(() {
        readonly = true;
      });
       if (value.token.isNotEmpty) {
          setState(() {
            Global.accessToken = value.token;
          });
        }
        _showSuccessDialog();
      }
    });
    }
    }
    
  }
    

  Future<void> _showSuccessDialog() async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Vehicle Edited'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('The Vehicle has been Edited you can check in the Vehicle list'),
              
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
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
         
          print("This the Image $compressedFile");
          print("This is the compressed image size :-${compressedFile?.lengthSync()}");
          makeVisible = true;
          final bytes = Io.File(compressedFile.path).readAsBytesSync();
          String img64 = base64Encode(bytes);
          if (type == 'rc') {
            rcbook = img64;
          }
          else if(type == 'puc'){
            puc = img64;
          }
          else{
            vDataImage = img64;
          }
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
   SizeConfig().init(context);
   
          
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            Navigator.pop(context,true);
          },
                  child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.white
                ),
              title: Text('Edit Vehicle',style: TextStyle(
                fontFamily: 'Arial',
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 22
              ),),
              backgroundColor: Colors.indigo[900],
            ),
       body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return Form(
              key: _formKey,
                child: ModalProgressHUD(
                                inAsyncCall: Global.isLoading,
                                child: Container(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
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
                            Image.asset('assets/images/icons/TRUCK.png'),
                            Padding(
                             padding: const EdgeInsets.only(top : 8.0),
                             child: TextFormField(
                              controller: vehiclename,
                              readOnly: readonly,
                              keyboardType: TextInputType.name,
                              style: TextStyle(
                                              fontFamily: 'Arial',
                                              color: AppColors.darkColor,
                                              fontSize: 18
                                            ),
                              validator: (val){
                                if (val.trim().isEmpty) {
                                  return 'Please enter the Vehicle Name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Vehicle Name",
                                labelStyle: TextStyle(
                                                 fontFamily: 'Arial',
                                                 fontWeight: FontWeight.w500,
                                                 fontSize: 18,
                                                 color: AppColors.darkColor
                                               ),
                                              
                                ),
                          ),
                        ),
                           Padding(
                             padding: const EdgeInsets.only(top : 8.0),
                             child: TextFormField(
                              controller: vehicleNumber,
                              readOnly: readonly,
                              textInputAction: TextInputAction.go,
                             // keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                              fontFamily: 'Arial',
                                              color: AppColors.darkColor,
                                              fontSize: 18
                                            ),
                              validator: (val){
                                if (val.trim().isEmpty) {
                                  return 'Please enter the Vehicle Number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Vehicle Number",
                                labelStyle: TextStyle(
                                                 fontFamily: 'Arial',
                                                 fontWeight: FontWeight.w500,
                                                 fontSize: 18,
                                                 color: AppColors.darkColor
                                               ),
                                              
                                ),
                          ),
                        ),
                           Padding(
                             padding: const EdgeInsets.only(top : 8.0),
                             child: TextFormField(
                              controller: rcNumber,
                              readOnly: readonly,
                              
                             // keyboardType: TextInputType.numberWithOptions(),
                              style: TextStyle(
                                              fontFamily: 'Arial',
                                              color: AppColors.darkColor,
                                              fontSize: 18
                                            ),
                              validator: (val){
                                if (val.trim().isEmpty) {
                                  return 'Please enter the Rc Number';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Rc Number",
                                labelStyle: TextStyle(
                                                 fontFamily: 'Arial',
                                                 fontWeight: FontWeight.w500,
                                                 fontSize: 18,
                                                 color: AppColors.darkColor
                                               ),
                                              
                                ),
                          ),
                        ),
                      //     Padding(
                      //        padding: const EdgeInsets.only(top : 10.0),
                      //        child: new DropdownButtonFormField<String>(
                      //                  isDense: true,
                      //                  style: TextStyle(
                      //                            fontFamily: 'Arial',
                      //                            fontWeight: FontWeight.w500,
                      //                            fontSize: 18,
                      //                            color: AppColors.darkColor
                      //                          ),
                      //                  hint: Text('Select Vehile',style: TextStyle(
                      //                            fontFamily: 'Arial',
                      //                            fontWeight: FontWeight.w500,
                      //                            fontSize: 18,
                      //                            color: AppColors.darkColor
                      //                          ),),                                    
                      //                           validator: (value) =>
                      //                                    value == null
                      //                                        ? 'Feild Required'
                      //                                        : null,
                      //                  items: <String>['A', 'B', 'C', 'D'].map((String value) {
                      //                        return new DropdownMenuItem<String>(
      
                      //                           value: value,
                      //                           child: new Text(value),
                      //                             );
                      //                            }).toList(),
                      //                            onChanged: (_) {},
                      //                          ),
                      //  ),
                                 Padding(
                                    padding: const EdgeInsets.only(top : 25.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Add Vehicle',style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.darkColor,
                                                          ),),
                                        FloatingActionButton.extended(
                                          elevation: 0,
                                          heroTag: Text("btn1"),
                                           backgroundColor: Colors.red[600],
                                             icon: Icon(Icons.file_upload,size: 30,color: AppColors.whiteColor,),
                                                onPressed: readonly ? null : (){
                                                  setState(() {
                                                    type = 'vehicle';
                                                  });
                                                  imageModalBottomSheet(context);
                                                },
                                               label: Padding(
                                                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                 child: Text('Upload',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: AppColors.whiteColor,
                                                          ),
                                                          ),
                                               ),),
                                      ],
                                    ),
                                 ),
                                  Padding(
                                    padding: const EdgeInsets.only(top : 35.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('RC File',style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.darkColor,
                                                          ),),
                                        FloatingActionButton.extended(
                                          elevation: 0,
                                          heroTag: Text("btn2"),
                                           backgroundColor: Colors.red[600],
                                             icon: Icon(Icons.file_upload,size: 30,color: AppColors.whiteColor,),
                                                onPressed:  readonly ? null : (){
                                                    setState(() {
                                                    type = 'rc';
                                                  });
                                                  imageModalBottomSheet(context);
                                                },
                                               label: Padding(
                                                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                 child: Text('Upload',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: AppColors.whiteColor,
                                                          ),
                                                          ),
                                               ),),
                                      ],
                                    ),
                                 ),
                                  Padding(
                                    padding: const EdgeInsets.only(top : 35.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text('Pollution\nUnder\nControl File',style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.w500,
                                                            color: AppColors.darkColor,
                                                          ),),
                                        FloatingActionButton.extended(
                                          elevation: 0,
                                          heroTag: Text("btn3"),
                                           backgroundColor: Colors.red[600],
                                             icon: Icon(Icons.file_upload,size: 30,color: AppColors.whiteColor,),
                                                onPressed:  readonly ? null : (){
                                                    setState(() {
                                                    type = 'puc';
                                                  });
                                                  imageModalBottomSheet(context);
                                                },
                                               label: Padding(
                                                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                                 child: Text('Upload',
                                                          textAlign: TextAlign.center,
                                                          style: TextStyle(
                                                            fontFamily: 'Arial',
                                                            fontSize: 17,
                                                            fontWeight: FontWeight.w600,
                                                            color: AppColors.whiteColor,
                                                          ),
                                                          ),
                                               ),),
                                      ],
                                    ),
                                 ),
                              //    Padding(
                              //      padding: EdgeInsets.only(top: 25),
                              //      child: Text('Insurance Expiry Date',
                              //                             textAlign: TextAlign.center,
                              //                             style: TextStyle(
                              //                               fontFamily: 'Arial',
                              //                               fontSize: 20,
                              //                               fontWeight: FontWeight.w600,
                              //                               color: AppColors.darkColor,
                              //                      ),
                              //                  ),
                              //        ),
                              //        Padding(
                              //          padding: const EdgeInsets.only(top : 10.0),
                              //          child: TextFormField(
                              //            controller: expiryDate,
                              //            style: TextStyle(
                              //                 fontFamily: 'Arial',
                              //                 color: AppColors.darkColor,
                              //                 fontSize: 18
                              //               ),
                              // validator: (val){
                              //   if (val.trim().isEmpty) {
                              //     return 'Please enter the Expiry Date';
                              //   }
                              //   return null;
                              // },
                              // onTap: () {
                              //   FocusScope.of(context).unfocus();
                              //   _selectDate(context);
                              // },
                              // decoration: InputDecoration(
                              //   prefixIcon: Icon(Icons.calendar_today_sharp,color: AppColors.darkColor,),
                              //  border: new OutlineInputBorder(
                              //    borderSide: BorderSide(width: 1.5,color: AppColors.darkColor),
                              //   borderRadius: const BorderRadius.all(
                              //   const Radius.circular(10.0),
                              //   ),
                              //   ),
                              //   focusedBorder: new OutlineInputBorder(
                              //    borderSide: BorderSide(width: 1.5,color: AppColors.darkColor),
                              //   borderRadius: const BorderRadius.all(
                              //   const Radius.circular(10.0),
                              //   ),
                              //   ),
                              //   enabledBorder: new OutlineInputBorder(
                              //    borderSide: BorderSide(width: 1.5,color: AppColors.darkColor),
                              //   borderRadius: const BorderRadius.all(
                              //   const Radius.circular(10.0),
                              //   ),
                              //   ),
                                              
                              //   ),
                              //          ),
                              //        ),
                          //  Padding(
                          //    padding: const EdgeInsets.only(top : 10.0),
                          //    child: new DropdownButtonFormField<String>(
                          //              isDense: true,
                          //              style: TextStyle(
                          //                        fontFamily: 'Arial',
                          //                        fontWeight: FontWeight.w500,
                          //                        fontSize: 18,
                          //                        color: AppColors.darkColor
                          //                      ),
                          //              hint: Text('Select State',style: TextStyle(
                          //                        fontFamily: 'Arial',
                          //                        fontWeight: FontWeight.w500,
                          //                        fontSize: 18,
                          //                        color: AppColors.darkColor
                          //                      ),),                                    
                          //                       validator: (value) =>
                          //                                value == null
                          //                                    ? 'Feild Required'
                          //                                    : null,
                          //              items: <String>['A', 'B', 'C', 'D'].map((String value) {
                          //                    return new DropdownMenuItem<String>(
      
                          //                       value: value,
                          //                       child: new Text(value),
                          //                         );
                          //                        }).toList(),
                          //                        onChanged: (_) {},
                          //                      ),
                          //    ),
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
                               child: Text(readonly ? 'Edit Vehicle' : 'Save Vehicle',style: TextStyle(
                                      fontFamily: 'Arial',
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                      ),),
                                  ),
                                 onPressed: addVehicle),
                          ),
                        )
                              ])))),
                ),
            );})),
        ))
    );
  }
}