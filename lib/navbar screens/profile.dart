import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../provider/userdataprovider.dart';
import '../utils/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  final TextEditingController _newPasswordController = TextEditingController();
  final _newPassKey = GlobalKey<FormState>();
  final _editProfileKey = GlobalKey<FormState>();


  void _changePassword(String newPassword) async {

    final provider = Provider.of<UserDataProvider>(context, listen: false);
    final user = await FirebaseAuth.instance.currentUser;
    final cred = EmailAuthProvider.credential(
        email: provider.userData!.email, password: provider.userData!.password);

    user?.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) async {
        //Success, do something
        FirebaseFirestore.instance.collection('users').doc(provider.userData!.userId).update({
          'password': newPassword,
        });
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
        const snackBar = SnackBar(
          content: Text('Contraseña cambiada con éxito.'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

      }).catchError((error) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: error.toString(),
        );
      });
    }).catchError((err) {
      CoolAlert.show(
        context: context,
        type: CoolAlertType.error,
        text: err.toString(),
      );
    });}

  Future<void> _displayChangePasswordDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Cambia la contraseña'),
            content: Form(
              key: _newPassKey,
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese nueva clave';
                  }
                  return null;
                },
                controller: _newPasswordController,
                decoration: InputDecoration(hintText: "Nueva contraseña"),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Cancelar'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('Hecho'),
                onPressed: () {
                  setState(() {
                    if(_newPassKey.currentState!.validate()) {
                      _changePassword(_newPasswordController.text);
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          );
        });
  }
  Future<void> _displayEditProfileDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Editar perfil'),
            content: Form(
              key: _editProfileKey,
              child: Column(
                children: [

                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese nueva clave';
                      }
                      return null;
                    },
                    controller: _newPasswordController,
                    decoration: InputDecoration(hintText: "Nueva contraseña"),
                  ),
                  SizedBox(height: 10,),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ingrese nueva clave';
                      }
                      return null;
                    },
                    controller: _newPasswordController,
                    decoration: InputDecoration(hintText: "Nueva contraseña"),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text('Cancelar'),
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                  });
                },
              ),
              ElevatedButton(
                child: Text('Hecho'),
                onPressed: () {
                  setState(() {
                    if(_editProfileKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  });
                },
              ),
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size= MediaQuery.of(context).size;
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    //get publication
    Future<int> getPublications()async{
      int count=0;
      await FirebaseFirestore.instance.collection('posts').where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get().then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          count++;
        });
      });
      return count;
    }



    return Scaffold(
      backgroundColor: colorWhite,
      drawer: const MenuDrawer(),
      appBar: AppBar(
        title: const Text('Dzuabry', style: TextStyle( color: primaryColor, fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: const <Widget>[
        ],
      ),
      body: Padding(
        padding: size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.2):EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10,),
                const Text("Mi Perfil", style: TextStyle(color: colorBlack, fontSize: 20, fontWeight: FontWeight.w600),),
                SizedBox(height: 20,),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(provider.userData!.profilePic),
                      fit: BoxFit.cover,
                    ),
                  ),

                ),
                SizedBox(height: 10,),
                Text("${provider.userData!.firstName} ${provider.userData!.lastName}", style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Text("@${provider.userData!.userName}", style: TextStyle(color: colorBlack, fontSize: 16, fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                //Text("Fecha de Registro: Mayo 24 2022", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400),),
                SizedBox(height: 10,),
                InkWell(
                  onTap: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
                  },
                  child: Container(
                    height: 30,
                    width: width*0.20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: colorBlack,)
                    ),
                    alignment: Alignment.center,
                    child: const Text("Editar",style: TextStyle(fontSize:12,color: colorBlack),),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 90,
                  width:  size.width> 756 ? width*0.1 : width*0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: FutureBuilder(
                            future: getPublications(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("-",style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),);

                              }
                              else {
                                if (snapshot.hasError) {
                                  print("error ${snapshot.error}");
                                  return const Center(
                                    child: Text("Something went wrong"),
                                  );
                                }

                                else {

                                  return Text(snapshot.data!.toString(),style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),);

                                }
                              }
                            }
                        ),
                      ),
                      Text("Publicaciones", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width:  size.width> 756 ? width*0.1 : width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("0", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Borradores", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width:  size.width> 756 ? width*0.1 : width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("0", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Siguiente", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width:  size.width> 756 ? width*0.1 : width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("0", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Seguidores", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),

              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 40,
              width: width*0.20,
              decoration: BoxDecoration(
                  border: Border.all(color: colorBlack,)
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" Cartas credenciales",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                  InkWell(onTap:(){
                    _displayChangePasswordDialog(context);
                  }, child: Icon(Icons.edit, color: primaryColor,))
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              height: 250,
              width: width*0.20,
              decoration: BoxDecoration(
                  border: Border.all(color: colorBlack,)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.briefcase,color: primaryColor,size: 20,),
                        SizedBox(width: 9,),
                        Text(" Agregar estado de empleo",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.graduationCap,color: primaryColor,size: 20,),
                        SizedBox(width: 7,),
                        Text("Agregar estado educativo",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.ring,color: primaryColor,size: 20,),
                        SizedBox(width: 7,),
                        Text(" Agregar estado civil",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.locationDot,color: primaryColor,size: 20,),
                        SizedBox(width: 15,),
                        Text("Agregar lugar de residencia",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.locationDot,color: primaryColor,size: 20,),
                        SizedBox(width: 15,),
                        Text("Agregar lugar de origen",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.bookOpen,color: primaryColor,size: 20,),
                        SizedBox(width: 15,),
                        Text("Agregar pasatiempo",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.contactCard,color: primaryColor,size: 20,),
                        SizedBox(width: 15,),
                        Text("Agregar informacion de contacto",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
                      ],
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text("Soporte comunitario",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),),
            Divider(color: colorBlack,),
            SizedBox(height: 10,),
            InkWell(
                onTap: () async{
                  final user = FirebaseAuth.instance.currentUser;
                  if (user!=null) {
                    await FirebaseAuth.instance.signOut();
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
                child: Text("Cerrar sesión",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),)),
            Divider(color: colorBlack,),
          ],
        ),
      ),
    );
  }
}
