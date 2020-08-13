import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../styles/app_styling.dart';
import 'tech_details.dart';

class ListPage extends StatefulWidget {
  final String query;

  ListPage(this.query);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future _data;

  Future getPosts() async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore.collection('technicians').getDocuments();
    return qn.documents;
  }

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Details(
          post: post,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data = getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _data,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              List matches = [];
              matches = getMatches(snapshot, widget.query);
              return GridView.builder(
                itemCount: getResultCount(snapshot, widget.query),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, i) {
                  return Container(
                    padding: EdgeInsets.only(top: 10, left: 10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.lightBlue,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.grey,
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                child: Icon(Icons.account_circle, size: 50),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(snapshot.data[matches[i]].data['FirstName'], style: techCardSubTitleStyle),
                                  Text(snapshot.data[matches[i]].data['Occupation'], style: techCardSubTitleStyle),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text("Status: ", style: techCardSubTitleStyle),
                              Text(snapshot.data[matches[i]].data['Status'], style: statusAvailableStyle),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            children: <Widget>[
                              Text('Rate: \$' + snapshot.data[matches[i]].data['Rate'].toString() + '.00/hr', style: techCardSubTitleStyle),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: getRatings(snapshot.data[matches[i]].data['Rating']),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'More Details',
                                style: techCardSubTitleStyle,
                                textAlign: TextAlign.right,
                              ),
                              IconButton(
                                icon: Icon(Icons.arrow_forward),
                                iconSize: 25,
                                color: Colors.white,
                                padding: EdgeInsets.only(left: 40),
                                onPressed: () {
                                  navigateToDetail(snapshot.data[matches[i]]);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

List<Widget> getRatings(rating) {
  List<Widget> ratings = [];
  for (int i = 1; i <= 5; i++) {
    if (i <= rating) {
      ratings.add(
        new Icon(
          Icons.star,
          color: Colors.yellow,
        ),
      );
    } else if (i - 1 <= rating && rating % 1 > .5) {
      ratings.add(
        new Icon(
          Icons.star_half,
          color: Colors.yellow,
        ),
      );
    } else {
      ratings.add(
        new Icon(Icons.star, color: Colors.grey),
      );
    }
  }
  return ratings;
}

getResultCount(snapshot, query) {
  int results = 0;
  bool foundMatch = false;
  for (int i = 0; i < snapshot.data.length; i++) {
    for (int j = 0; j < snapshot.data[i].data['SearchQuery'].length; j++) {
      if (snapshot.data[i].data['SearchQuery']['$j'].toLowerCase() == query.toLowerCase()) {
        foundMatch = true;
      }
    }
    if (foundMatch == true) {
      results += 1;
    }
    foundMatch = false;
  }
  return results;
}

List getMatches(snapshot, query) {
  List matches = [];
  bool foundMatch = false;
  for (int i = 0; i < snapshot.data.length; i++) {
    for (int j = 0; j < snapshot.data[i].data['SearchQuery'].length; j++) {
      if (snapshot.data[i].data['SearchQuery']['$j'].toLowerCase() == query.toLowerCase()) {
        foundMatch = true;
      }
    }
    if (foundMatch == true) {
      matches.add(i);
    }
    foundMatch = false;
  }
  return matches;
}
