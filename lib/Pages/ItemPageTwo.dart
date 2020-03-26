import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPageTwo extends StatefulWidget {
  @override
  _ItemPageTwoState createState() => _ItemPageTwoState();
}

class _ItemPageTwoState extends State<ItemPageTwo> {
  Future getHomePost() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();
    return snap.documents;
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getHomePost();
    });
  }

  List<MaterialColor> _colorItem = [
    Colors.deepOrange,
    Colors.green,
    Colors.purple,
    Colors.teal,
    Colors.brown
  ];
  MaterialColor randomColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: getHomePost(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return RefreshIndicator(
              onRefresh: getRefresh,
              child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  randomColor = _colorItem[index % _colorItem.length];
                  return Card(
                    color: Colors.blueAccent,
                    elevation: 10.0,
                    margin: EdgeInsets.all(10.0),
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      height: 350.0,
                      child: Column(
                        //first container
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        child: Text(snapshot
                                            .data[index].data["title"][0]),
                                        backgroundColor: randomColor,
                                        foregroundColor: Colors.black,
                                      ),
                                      Container(
                                        margin: EdgeInsets.all(10.0),
                                        child: Text(
                                          snapshot.data[index].data["title"],
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            //  fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    customDialog(
                                        context,
                                        snapshot.data[index].data["image"],
                                        snapshot.data[index].data["title"],
                                        snapshot.data[index].data["content"]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10.0),
                                    child: Icon(
                                      Icons.more_horiz,
                                      size: 20.0,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            margin: EdgeInsets.all(3.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                snapshot.data[index].data["image"],
                                fit: BoxFit.cover,
                                height: 200.0,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Container(
                              margin: EdgeInsets.all(10.0),
                              child: Text(
                                snapshot.data[index].data["content"],
                                maxLines: 4,
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  customDialog(
      BuildContext context, String image, String title, String content) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Container(
              height: MediaQuery.of(context).size.height / 1.2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.deepPurple,
                        Colors.blueAccent,
                        Colors.teal
                      ])),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          image,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      child: Text(
                        title,
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(
                        content,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
