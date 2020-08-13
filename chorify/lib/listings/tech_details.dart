import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../styles/app_styling.dart';
import '../listings/search.dart';

class Details extends StatefulWidget {
  final DocumentSnapshot post;
  const Details({this.post});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.lightBlue[200], Colors.lightBlue[300], Colors.lightBlue[900]],
            ),
          ),
        ),
        Container(
          child: Image.network(
            widget.post.data['url'],
            height: 350,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: 30,
          right: 320,
          child: RawMaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            elevation: 15,
            fillColor: Colors.white,
            shape: CircleBorder(),
            child: Icon(
              Icons.arrow_back,
              color: Colors.lightBlue,
              size: 35,
            ),
          ),
        ),
        Positioned(
          bottom: 15,
          left: 10,
          right: 10,
          child: Card(
            elevation: 15.0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text(widget.post.data['FirstName'] + ' ' + widget.post.data['LastName'], style: techCardDetailsTitle),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(widget.post.data['Occupation'], style: TextStyle(color: Colors.black, fontSize: 20)),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getRatings(widget.post.data['Rating']),
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 20,
                    thickness: 1,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text('Details ', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
                      ),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Text('Location: ', style: techCardDetailsSubTitle),
                                Text(widget.post.data['City'] + ', ' + widget.post.data['State'],
                                    style: TextStyle(color: Colors.black, fontSize: 20)),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Row(
                              children: [
                                Text('Price: ', style: techCardDetailsSubTitle),
                                Text('\$' + widget.post.data['Rate'].toString() + '/hour', style: TextStyle(color: Colors.black, fontSize: 20)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 95),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text('Strengths: ', style: techCardDetailsSubTitle),
                                  Expanded(
                                    child: Text(widget.post.data['Details']['Strengths'], softWrap: true, style: TextStyle(fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text('Years of Experience: ', style: techCardDetailsSubTitle),
                                  Text(widget.post.data['Details']['Experience'], softWrap: true, style: TextStyle(fontSize: 20)),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  Text('Price Adjustment?: ', style: techCardDetailsSubTitle),
                                  Expanded(
                                    child: Text(widget.post.data['Details']['PriceAdjust'], softWrap: true, style: TextStyle(fontSize: 20)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.call,
                                    size: 30,
                                    color: Colors.lightBlue,
                                  ),
                                  onPressed: () => UrlLauncher.launch('tel://' + widget.post.data['PhoneNum']),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text('Call', style: contactStyle),
                                ),
                              ],
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.message,
                                    size: 30,
                                    color: Colors.lightBlue,
                                  ),
                                  onPressed: () => UrlLauncher.launch('sms://' + widget.post.data['PhoneNum']),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8),
                                  child: Text('Message', style: contactStyle),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
