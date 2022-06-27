import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/userdataprovider.dart';
import '../utils/constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    Size size= MediaQuery.of(context).size;
    final provider = Provider.of<UserDataProvider>(context, listen: false);

    //change password
    void _changePassword(String currentPassword, String newPassword) async {
      final user = await FirebaseAuth.instance.currentUser;
      final cred = EmailAuthProvider.credential(
          email: provider.userData!.email, password: currentPassword);

      user?.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            text: "Password Changed Successfully",
          );
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
          // IconButton(
          //   icon: const Icon(Icons.add_circle),
          //   tooltip: 'Show Snackbar',
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('This is a snackbar')));
          //     Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()));
          //   },
          // ),
        ],
      ),
      body: Padding(
        padding: size.width> 756 ? EdgeInsets.symmetric(horizontal: width*0.2):EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(height: 10,),
                Text("Mi Perfil", style: TextStyle(color: colorBlack, fontSize: 20, fontWeight: FontWeight.w600),),
                SizedBox(height: 20,),
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: AssetImage("assets/images/profile.png"),
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
                  Icon(Icons.edit, color: primaryColor,)
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
