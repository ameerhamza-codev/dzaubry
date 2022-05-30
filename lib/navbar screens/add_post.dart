import 'package:dzaubry_newspaper/navbar%20screens/sidemenu.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
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

            SizedBox(height: 10,),
            Center(child: Text("Agregar una Publicación", style: TextStyle(color: colorBlack, fontSize: 24, fontWeight: FontWeight.w500),)),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("De qué quieres hablar?", style: TextStyle(color: colorBlack, fontSize: 14, fontWeight: FontWeight.w600),),
                Container(
                  height: 30,
                  width: width*0.40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: colorBlack,)
                  ),
                  alignment: Alignment.center,
                  child:  DropdownButton<String>(
                    hint: Text('Estilo de vida', style: TextStyle(color: colorBlack, fontSize: 12),),
                    items: <String>['Estilo de vida'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  )
                )
              ],
            ),
            SizedBox(height: 15,),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                ),
                hintText: 'Título',
                fillColor: colorWhite,
                filled: true,

              ),
            ),
            SizedBox(height: 15,),
            TextField(
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
                Text("Agregar contenido de imagen/video/pódcast",style: TextStyle(fontSize:14, fontWeight:FontWeight.w500, color: colorBlack),),
              ],
            ),
            SizedBox(height: 30,),
            Container(
              height: 40,
              width: width*0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: colorBlack)
              ),
              alignment: Alignment.center,
              child: const Text("Publicar ahora",style: TextStyle(fontSize:18, fontWeight: FontWeight.w500,color: colorBlack),),
            ),
            SizedBox(height: 20,),
            Container(
              height: 40,
              width: width*0.7,
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
    );
  }
}
