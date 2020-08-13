import 'package:chorify/listings/search_results_page.dart';
import 'package:flutter/material.dart';
import './carousel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final queryController = TextEditingController();

  void initState() {
    super.initState();
    queryController.addListener(
      () {
        SearchResults();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 0,
        ),
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      alignment: Alignment.topCenter,
                      height: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(30, 8),
                          bottomRight: Radius.elliptical(30, 8),
                        ),
                        image: DecorationImage(
                          image: AssetImage(
                            "assets/images/home-background-card2.jpg",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 75,
                      child: Image.asset(
                        "assets/images/ic_launcher.png",
                        scale: .8,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 275, left: 20, right: 20),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        child: TextField(
                          controller: queryController,
                          cursorColor: Colors.lightBlue,
                          onTap: () {
                            showSearch(context: context, delegate: DataSearch(), query: queryController.text);
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            hintText: 'Search for providers (e.g. Maid)',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              top: 15,
                              left: 10,
                            ),
                          ),
                          style: TextStyle(
                            fontSize: 17,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Card(
                    elevation: 6.0,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showSearch(context: context, delegate: DataSearch(), query: 'Maid');
                                    },
                                    child: Icon(
                                      Icons.home,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Household')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showSearch(context: context, delegate: DataSearch(), query: 'Mechanic');
                                    },
                                    child: Icon(
                                      Icons.directions_car,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Vehicle')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showSearch(context: context, delegate: DataSearch(), query: 'Landscaper');
                                    },
                                    child: Icon(
                                      Icons.nature,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Outdoor')
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundColor: Colors.blue,
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      showSearch(context: context, delegate: DataSearch(), query: 'All');
                                    },
                                    child: Icon(
                                      Icons.recent_actors,
                                      size: 45,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text('Browse')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      Text('Featured Service Providers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    ],
                  ),
                ),
                Carousel(), // Widget found in the carousel.dart file
              ],
            ),
          ),
        ),
      ),
    );
  }
}
