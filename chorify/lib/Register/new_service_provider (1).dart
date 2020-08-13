import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chorify/routes/router.gr.dart';

class Register extends StatefulWidget {
  final String carpenterUrl =
      'https://firebasestorage.googleapis.com/v0/b/chorify-7420f.appspot.com/o/details_page_img.jpg?alt=media&token=3efb277a-3ae8-42a4-86dd-64788253fdf0';
  final String maidUrl =
      'https://firebasestorage.googleapis.com/v0/b/chorify-7420f.appspot.com/o/cleaning_supplies.jpg?alt=media&token=086cfd36-b071-4b3f-9fab-0273eb9713bd';
  final String mechanicUrl =
      'https://firebasestorage.googleapis.com/v0/b/chorify-7420f.appspot.com/o/mechanic.jpg?alt=media&token=ad5fb491-bc9b-4b04-ad84-f844c116a467';
  final String landscaperUrl =
      'https://firebasestorage.googleapis.com/v0/b/chorify-7420f.appspot.com/o/landscaping.jpg?alt=media&token=76bc6df8-c58f-4b5e-9add-0f9949e1b6dd';
  final String plumberUrl =
      'https://firebasestorage.googleapis.com/v0/b/chorify-7420f.appspot.com/o/plumbing.jpg?alt=media&token=71437a48-f898-46ce-bf4e-1d4833648af5';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _firstName = new TextEditingController();
  final TextEditingController _lastName = new TextEditingController();
  final TextEditingController _occupation = new TextEditingController();
  final TextEditingController _phoneNum = new TextEditingController();
  final TextEditingController _rate = new TextEditingController();
  final TextEditingController _rating = new TextEditingController();
  final TextEditingController _state = new TextEditingController();
  final TextEditingController _city = new TextEditingController();
  final TextEditingController _experience = new TextEditingController();
  final TextEditingController _strengths = new TextEditingController();
  final TextEditingController _priceAdjust = new TextEditingController();

  String firstName = '';
  String lastName = '';
  String occupation = '';
  String phoneNum = '';
  int rate;
  double rating;
  String state = '';
  String city = '';
  String url = '';
  List details = [];

  _RegisterState() {
    _firstName.addListener(_firstNameListen);
    _lastName.addListener(_lastNameListen);
  }

  void _firstNameListen() {
    if (_firstName.text.isEmpty) {
      firstName = "";
    } else {
      firstName = _firstName.text;
    }
  }

  void _lastNameListen() {
    if (_lastName.text.isEmpty) {
      lastName = "";
    } else {
      lastName = _lastName.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildTextFields(),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text("Register as a service provider"),
      centerTitle: true,
    );
  }

  Widget _buildTextFields() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: new TextField(
              controller: _firstName,
              decoration: new InputDecoration(labelText: 'First name'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _lastName,
              decoration: new InputDecoration(labelText: 'Last name'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _occupation,
              decoration: new InputDecoration(labelText: 'Occupation'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _phoneNum,
              decoration: new InputDecoration(labelText: 'Phone Number'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _rate,
              decoration: new InputDecoration(labelText: 'Hourly rate'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _city,
              decoration: new InputDecoration(labelText: 'City'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _state,
              decoration: new InputDecoration(labelText: 'State'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _experience,
              decoration: new InputDecoration(labelText: 'Years of experience'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _strengths,
              decoration: new InputDecoration(labelText: 'Strengths'),
            ),
          ),
          Container(
            child: new TextField(
              controller: _priceAdjust,
              decoration: new InputDecoration(labelText: 'Willing to adjust price? '),
            ),
          ),
        ],
      ),
    );
  }

  String setDetailPicture(occupation) {
    String occ;
    occ = occupation.toString();
    occ.toLowerCase();
    if (occ == 'carpenter') {
      return widget.carpenterUrl;
    } else if (occ == 'maid') {
      return widget.maidUrl;
    } else if (occupation == 'plumber') {
      return widget.plumberUrl;
    } else if (occ == 'landscaper') {
      return widget.landscaperUrl;
    } else if (occ == 'mechanic') {
      return widget.mechanicUrl;
    } else {
      return widget.carpenterUrl;
    }
  }

  Widget _buildButtons() {
    return Container(
      child: RaisedButton(
        child: Text('Register', style: TextStyle(color: Colors.white)),
        onPressed: () {
          Map<String, dynamic> userInfo = {
            'FirstName': _firstName,
            'LastName': _lastName,
            'Occupation': _occupation,
            'PhoneNum': _phoneNum,
            'Rate': _rate,
            'Rating': 0,
            'State': _state,
            'City': _city,
            //'Details' 'Experience': _experience,
            //'Details' 'PriceAdjust': _priceAdjust,
            //'Details' 'Strengths': _strengths,
            'url': setDetailPicture(_occupation)
          };
          _registerPressed(userInfo);
        },
        color: Colors.lightBlue,
      ),
    );
  }

  Future<void> addServiceProvider(userInfo) async {
    Firestore.instance.collection('technicians').add(userInfo).catchError((e) {
      print(e);
    });
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password
  _registerPressed(userInfo) {
    print('The user wants to register with $firstName and $lastName');
    addServiceProvider(userInfo);
    Router.navigator.pushNamed(Router.homePage);
  }
}
