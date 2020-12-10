import 'dart:io';
import 'dart:ui';

import 'package:Transporter/util/Size_config.dart';
import 'package:Transporter/util/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class UpdateProfile extends StatefulWidget {
  UpdateProfile({Key key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
   File _image;
  File croppedFile;
  File result;
  bool makeVisible = false;
   DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(1980),
    lastDate: DateTime(2025),
    )
   .then((selectedDate) {
     if(selectedDate!=null){
       setState(() {
         dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
       });
     }}
  );
  if (picked != null && picked != selectedDate)
    setState(() {
      selectedDate = picked;
      dob.text = DateFormat('yyyy-MM-dd').format(selectedDate);
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
              color: Colors.white
            ),
            
            flexibleSpace: Container(
    decoration: 
      BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/SkeletonScreenDesign/Header-Bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      ),
    title: Row(
              children: [
  GestureDetector(
    onTap: (){
      Navigator.of(context).pop();
    },
      child: Container(
      padding: EdgeInsets.all(2),
      height: 30,
      width: 30,
      decoration: 
        BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/SkeletonScreenDesign/Big-Icon-Holder.png'),
            fit: BoxFit.cover,
            ),
           ),
            child: Padding(
              padding: const EdgeInsets.only(left : 5.0),
              child: Center(child: Icon(Icons.arrow_back_ios,size: 20,)),
            ),
            ),
           ),
           Padding(
              padding: const EdgeInsets.only(left : 5.0),
             child: Image.asset('assets/images/SkeletonScreenDesign/Header-Logo.png',height: 50,width: 50,),
           ),
                Padding(
                    padding: const EdgeInsets.only(left : 10.0),
                  child: Text('Update Profile',style: TextStyle(
                    fontFamily: 'Arial',
                    color: Colors.indigo[900],
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            actions: [
              IconButton(icon: Icon(Icons.cancel,color: Colors.indigo[900],size: 40,), onPressed: (){
                Navigator.of(context).pushNamed('');
              })
            ],
          ),
       body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          return Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                          color:  Colors.indigo[900],
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Padding(
                               padding:  EdgeInsets.only(top : 10.0,left: SizeConfig.safeBlockHorizontal*8),
                               child: GestureDetector(
                                 onTap: (){
                                   imageModalBottomSheet(context);
                                 },
                                   child: Row(
                                   mainAxisAlignment: MainAxisAlignment.start,
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
                                   child: Text('Upload Document',
                                   style: TextStyle(
                                                     fontFamily: 'Arial',
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w600,
                                                          color: Colors.white
                                                        ),
                                          ),
                                      ),
                                       ],
                                     ),
                                   Expanded(
                                    child: Padding(
                                     padding: EdgeInsets.only(left: 15),
                                     child: Text('RUPOM DOGRA',
                                     style: TextStyle(
                                                       fontFamily: 'Arial',
                                                            fontSize: 20,
                                                            fontWeight: FontWeight.w600,
                                                            color: Colors.white
                                                          ),
                                            ),
                                        ),
                                   ),
                                   ],
                                 ),
                               ),
                             ),
                        ),
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              TextFormField(
                                controller: fname,
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  ),
                                decoration: InputDecoration(
                                  labelText: 'FIRST NAME',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  )
                                ),
                              ),
                               TextFormField(
                                controller: lname,
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  ),
                                decoration: InputDecoration(
                                  labelText: 'LAST NAME',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  )
                                ),
                              ),
                               TextFormField(
                                controller: gender,
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  ),
                                decoration: InputDecoration(
                                  labelText: 'Gender',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  )
                                ),
                              ),
                               TextFormField(
                                controller: dob,
                                onTap: () {
                               FocusScope.of(context).unfocus();
                                _selectDate(context);
                                },                        
                                style: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  ),
                                decoration: InputDecoration(
                                    suffixIcon: Icon(Icons.calendar_today_sharp,color: Colors.indigo[800],),
                                  labelText: 'DATE OF BIRTH',
                                  labelStyle: TextStyle(
                                    fontFamily: 'Arial',
                                    fontSize: 18,
                                    color: Colors.indigo[800]
                                  )
                                ),
                              ),
                               Padding(
                               padding:  EdgeInsets.only( top : SizeConfig.safeBlockVertical*3),
                               child: GestureDetector(
                                 onTap: (){},
                                 child: Container(
                                   width: 230,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo[900],
                                    image: DecorationImage(
                                      image: ExactAssetImage('assets/images/Loginsignup/BT-1.png'),
                                      fit: BoxFit.fill
                                    )
                                   ),
                                   child: Padding(
                                     padding: const EdgeInsets.all(15.0),
                                     child: Center(
                                       child: Text('UPDATE',
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
                            ],
                          ),
                        )
                        ]))));})))
    );
  }
}