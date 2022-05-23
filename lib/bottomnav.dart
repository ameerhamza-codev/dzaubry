import 'package:dzaubry_newspaper/navbar%20screens/add_post.dart';
import 'package:dzaubry_newspaper/navbar%20screens/home.dart';
import 'package:dzaubry_newspaper/navbar%20screens/profile.dart';
import 'package:dzaubry_newspaper/utils/constants.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavBar>{

  int _currentIndex = 1;

  List<Widget> _children=[];

  @override
  void initState() {
    super.initState();
    _children = [
      AddPost(),
      Home(),
      Profile()
    ];
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        height: AppBar().preferredSize.height,
        color: colorBottomnav,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: (){
                onTabTapped(0);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/icons/add.png",height: 30,color: _currentIndex==0?primaryColor:colorWhite),

                ],
              ),
            ),
            InkWell(
              onTap: (){
                onTabTapped(1);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/icons/home.png",height: 30,color: _currentIndex==1?primaryColor:colorWhite),

                ],
              ),
            ),
            InkWell(
              onTap: (){
                onTabTapped(2);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/icons/profile.png",height: 30,color: _currentIndex==2?primaryColor:colorWhite),

                ],
              ),
            ),
          ],
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}