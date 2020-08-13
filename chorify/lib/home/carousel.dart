import 'package:chorify/listings/search.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../listings/tech_details.dart';
import '../styles/app_styling.dart';

class Carousel extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CarouselState();
  }
}

class _CarouselState extends State<Carousel> {
  int _current = 0;
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

  List<Widget> imageSliders(snapshot) {
    List<Widget> imgList = [];
    for (int i = 0; i < 3; i++) {
      imgList.add(
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: RawMaterialButton(
                  onPressed: () {
                    navigateToDetail(snapshot.data[i]);
                  },
                  child: Stack(
                    children: <Widget>[
                      Image.network(snapshot.data[i].data['url'], fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.black, Colors.black87, Colors.black54, Colors.black45.withAlpha(0)],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data[i].data['FirstName'] + ' ' + snapshot.data[i].data['LastName'],
                                style: carouselImage,
                              ),
                              Text(
                                snapshot.data[i].data['Occupation'],
                                style: carouselImage,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: getRatings(snapshot.data[i].data['Rating']),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      );
    }
    return imgList;
  }

  List<String> getImgList(snapshot) {
    List<String> imgList = [];
    for (int i = 0; i < 3; i++) {
      imgList.add(snapshot.data[i].data['url']);
    }
    return imgList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _data,
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading..."));
          } else {
            List<Widget> _imageSliders;
            _imageSliders = imageSliders(snapshot);
            List<String> imgList = [];
            imgList = getImgList(snapshot);
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CarouselSlider(
                    items: _imageSliders,
                    options: CarouselOptions(
                      autoPlay: true,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(
                          () {
                            _current = index;
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map(
                      (url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index ? Colors.lightBlue : Color.fromRGBO(0, 0, 0, 0.4),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
