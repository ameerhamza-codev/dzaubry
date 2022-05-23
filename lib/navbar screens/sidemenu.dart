import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/material.dart';

import '../login.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  _MenuDrawerState createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Stack(
          children: [
        Container(
        decoration: const BoxDecoration(
            color: primaryColor
          ),
          ),
                Scaffold(
                  backgroundColor: Colors.transparent,

                  body: ListView(
              children: [
                  SizedBox(height: 100,),
                  ListTile(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Profile()));

                    },
                    title: Text("Seleccionar ubicación", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),
                  ListTile(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserNotifications()));

                    },
                    title: Text("Selecciona la zona horaria", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),
                  ListTile(
                    onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UserSettings()));

                    },
                    title: Text("Categorías", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),
                  ListTile(
                    onTap: (){
                    },
                    title: Text("Perfil", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),
                  ListTile(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Login()));

                    },
                    title: Text("Cerrar sesión", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.w400),),
                  ),

              ],
            ),
                )
          ],
        )
    );
  }
}
