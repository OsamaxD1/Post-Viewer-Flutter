import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemPageOne extends StatefulWidget {
  @override
  _ItemPageOneState createState() => _ItemPageOneState();
}

class _ItemPageOneState extends State<ItemPageOne> {
  Future getPost() async {
    var firestore = Firestore.instance;
    QuerySnapshot snap = await firestore.collection("HomeData").getDocuments();
    return snap.documents;
  }

  Future<Null> getRefresh() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      getPost();
    });
  }

  List<MaterialColor> colorViewItems = [Colors.blue, Colors.teal, Colors.cyan];
  MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: FutureBuilder(
          future: getPost(),
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
                      color = colorViewItems[index % colorViewItems.length];
                      return Container(
                        height: 250.0,
                        margin: EdgeInsets.all(10.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)),
                          elevation: 10,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Image.network(
                                        snapshot.data[index].data["image"],
                                        fit: BoxFit.cover,
                                        height: 250.0,
                                        width:
                                            MediaQuery.of(context).size.width),
                                  )),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(3.0),
                                      child: Text(
                                        snapshot.data[index].data["title"],
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(3.0),
                                      child: Text(
                                        snapshot.data[index].data["content"],
                                        maxLines: 7,
                                        style: TextStyle(fontSize: 15.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: InkWell(
                                        onTap: () {
                                          anyNamecustomDialog(
                                              context,
                                              snapshot
                                                  .data[index].data["image"],
                                              snapshot
                                                  .data[index].data["title"],
                                              snapshot
                                                  .data[index].data["content"]);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              bottom: 10.0, right: 10.0),
                                          padding: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                              color: color,
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: Text(
                                            "View Details",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ));
            }
          }),
    );
  }

  anyNamecustomDialog(
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
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20.0)
                  ,gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.purpleAccent,
                            Colors.blueAccent,
                            Colors.green
                      ])
                  ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 150.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(image,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container(
                      child: Text(title,
                      maxLines: 1,style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0
                        ),),
                    ),
                    SizedBox(height: 5.0,),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: Text(content,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0
                        ),),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
