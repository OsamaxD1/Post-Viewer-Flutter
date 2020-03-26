import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:imageflutter/Pages/ItemPageOne.dart';
import 'package:imageflutter/Pages/ItemPageTwo.dart';
import 'package:imageflutter/Pages/ItemPageThree.dart';

class ImageViewerHome extends StatefulWidget {
  @override
  _ImageViewerHomeState createState() => _ImageViewerHomeState();
}

class _ImageViewerHomeState extends State<ImageViewerHome> {
  int _indexPage = 0;

  final pageOptions = [ItemPageOne(),
    ItemPageTwo(), ItemPageThree()];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueAccent,
      body: pageOptions[_indexPage],
      bottomNavigationBar: CurvedNavigationBar(
        items: <Widget>[
          Icon(
            Icons.poll,
            size: 30, //color: Colors.white,
          ),
          Icon(
            Icons.home, //color: Colors.white,
            size: 30,
          ),
          Icon(
            Icons.library_books,
            size: 30,
          )
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        index: 1,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _indexPage = index;
          });
        },
      ),
    );
  }
}
