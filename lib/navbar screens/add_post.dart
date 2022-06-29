import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dzaubry_newspaper/bottomnav.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../provider/userdataprovider.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  late Uri imageUri;
  final _formKey = GlobalKey<FormState>();
  var storyController=TextEditingController();
  var titleController=TextEditingController();
  String? category = 'Estilo de vida';
  File? imageFile;
  String photoUrl="";

  bool _progress = false ;

  Future uploadImageToFirebase(BuildContext context) async {
    final ProgressDialog pr = ProgressDialog(context: context);
    pr.show(max: 100, msg: 'Please Wait');
    firebase_storage.Reference firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}');
    firebase_storage.UploadTask uploadTask = firebaseStorageRef.putFile(imageFile!);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) {
        photoUrl=value;
        print("value $value");
        setState(() {
          _progress = true;
          pr.close();
        });

      },
    ).onError((error, stackTrace){
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: error.toString(),
      );
    });
  }
  void fileSet(File file){
    setState(() {
      if(file!=null){
        imageFile=file;
      }
    });
    uploadImageToFirebase(context);
  }

  pickFiles()async{
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) => fileSet(File(value!.path)));
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    Size _size= MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: colorWhite,
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Dzuabry', style: TextStyle( color: primaryColor, fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: const <Widget>[],
      ),
      body: Padding(
        padding: _size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.2):EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              SizedBox(height: 10,),
              Center(child: Text("Agregar una Publicación", style: TextStyle(color: colorBlack, fontSize: 24, fontWeight: FontWeight.w500),)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("De qué quieres hablar?", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w600),),
                  Container(
                    height: 30,
                    width: _size.width> 756 ? width*0.2:width*0.40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: colorBlack,)
                    ),
                    alignment: Alignment.center,
                    child:  DropdownButton<String>(
                      hint: Text('Categorías', style: TextStyle(color: colorBlack, fontSize: 12),),
                      items: <String>['Estilo de vida', 'Deportes', 'Politics'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? val) {
                        setState(() {
                          category = val;
                        });
                      },
                    )
                  )
                ],
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field Can\'t be empty!';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Título',
                  fillColor: colorWhite,
                  filled: true,

                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                controller: storyController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field Can\'t be empty!';
                  }
                  return null;
                },
                keyboardType: TextInputType.multiline,
                minLines: 5,//Normal textInputField will be displayed
                maxLines: 5,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                  ),
                  hintText: 'Escriba aquí',
                  fillColor: colorWhite,
                  filled: true,

                ),
              ),
              SizedBox(height: 15,),
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.upload,color: primaryColor,size: 15,),
                  SizedBox(width: 9,),
                  InkWell(
                    onTap: (){
                      pickFiles();
                    },
                      child: Text("Agregar contenido de imagen/video/pódcast",style: TextStyle(fontSize:14, fontWeight:FontWeight.w500, color: colorBlack),)),
                ],
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  final ProgressDialog pr = ProgressDialog(context: context);
                  final provider = Provider.of<UserDataProvider>(context, listen: false);
                  pr.show(max: 100, msg: "Adding");
                  FirebaseFirestore.instance.collection('posts').add({
                    'title': titleController.text,
                    'story': storyController.text,
                    'image': photoUrl,
                    'comments': 0,
                    'like': [],
                    'dislike': [],
                    'categoryName': category,
                    'userId':FirebaseAuth.instance.currentUser!.uid,
                    'username':provider.userData!.userName,
                    'userPic' :provider.userData!.profilePic,
                    'time':DateTime.now().millisecondsSinceEpoch
                  }).then((value) {
                    pr.close();
                    print("added");
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
                  });
                },
                child: Container(
                  height: 40,
                  width: _size.width> 756 ? width*0.4:width*0.7,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: colorBlack)
                  ),
                  alignment: Alignment.center,
                  child: const Text("Publicar ahora",style: TextStyle(fontSize:18, fontWeight: FontWeight.w500,color: colorBlack),),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                height: 40,
                width: _size.width> 756 ? width*0.4:width*0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: colorBlack)
                ),
                alignment: Alignment.center,
                child: const Text("Guardar como borrador",style: TextStyle(fontSize:14, fontWeight: FontWeight.w500,color: colorBlack),),
              ),
              SizedBox(height: 20,),
              const Text("Tenga en cuenta que este contenido estará sujeto a verificación por cualquier violación de nuestros Términos y condiciones",style: TextStyle(fontSize:12, fontWeight: FontWeight.w500,color: colorBlack),),

            ],
          ),
        ),
      ),
    );
  }
}
