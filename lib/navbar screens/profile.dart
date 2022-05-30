import 'package:dzaubry_newspaper/login.dart';
import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return Scaffold(
      backgroundColor: colorWhite,
      drawer: MenuDrawer(),
      appBar: AppBar(
        title: const Text('Dzuabry', style: TextStyle( color: primaryColor, fontSize: 24),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
        actions: <Widget>[
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
        padding: const EdgeInsets.all(15.0),
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
                Text("Sergio Busquets", style: TextStyle(color: colorBlack, fontSize: 18, fontWeight: FontWeight.w500),),
                SizedBox(height: 10,),
                Text("@Sergio 272 ", style: TextStyle(color: colorBlack, fontSize: 16, fontWeight: FontWeight.w600),),
                SizedBox(height: 10,),
                Text("Fecha de Registro: Mayo 24 2022", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w400),),
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
                  width: width*0.20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("4", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Publicaciones", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width: width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("34", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Borradores", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width: width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("24", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
                      Text("Siguiente", style: TextStyle(color: colorWhite, fontWeight: FontWeight.w400, fontSize: 12),),
                    ],
                  ),

                ),
                Container(
                  height: 90,
                  width: width*0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: primaryColor
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("6", style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold, fontSize: 16),),
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
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));
                },
                child: Text("Cerrar sesión",style: TextStyle(fontSize:16, fontWeight:FontWeight.w500, color: colorBlack),)),
            Divider(color: colorBlack,),
          ],
        ),
      ),
    );
  }
}
