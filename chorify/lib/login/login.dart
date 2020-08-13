import 'package:flutter/material.dart';
import 'package:chorify/routes/router.gr.dart';

/*  The code that helped with this page was found at 
    https://github.com/ahmed-alzahrani/Flutter_Simple_Login. 
*/

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}

// Used for controlling whether the user is loggin or creating an account
enum FormType {
  login,
  register,
  forgot,
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailFilter = new TextEditingController();
  final TextEditingController _passwordFilter = new TextEditingController();
  final TextEditingController _confirmPasswordFilter = new TextEditingController();
  final TextEditingController _usernameFilter = new TextEditingController();
  final TextEditingController _firstNameFilter = new TextEditingController();
  final TextEditingController _lastNameFilter = new TextEditingController();
  final TextEditingController _phoneNumberFilter = new TextEditingController();

  String _email = "";
  String _password = "";
  String _confirmPassword = "";
  String _username = "";
  String _firstName = "";
  String _lastName = "";
  String _phoneNumber = "";
  FormType _form = FormType
      .login; // our default setting is to login, and we should switch to creating an account when the user chooses to

  _LoginPageState() {
    _emailFilter.addListener(_emailListen);
    _passwordFilter.addListener(_passwordListen);
    _confirmPasswordFilter.addListener(_confirmPasswordListen);
    _firstNameFilter.addListener(_firstNameListen);
    _usernameFilter.addListener(_usernameListen);
    _lastNameFilter.addListener(_lastNameListen);
    _phoneNumberFilter.addListener(_phoneNumberListen);
  }

  void _emailListen() {
    if (_emailFilter.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailFilter.text;
    }
  }

  void _passwordListen() {
    if (_passwordFilter.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordFilter.text;
    }
  }

  void _confirmPasswordListen(){
    if (_confirmPasswordFilter.text.isEmpty){
      _confirmPassword = "";
    }
    else{
      _confirmPassword = _confirmPasswordFilter.text;
    }
  }

  void _usernameListen(){
    if(_usernameFilter.text.isEmpty){
      _username = "";
    }
    else{
      _username = _usernameFilter.text;
    }
  }

  void _firstNameListen(){
    if(_firstNameFilter.text.isEmpty){
      _firstName = "";
    }
    else{
      _firstName = _firstNameFilter.text;
    }
  }

  void _lastNameListen(){
    if(_lastNameFilter.text.isEmpty){
      _lastName = "";
    }
    else{
      _lastName = _lastNameFilter.text;
    }
  }

  void _phoneNumberListen(){
    if(_phoneNumberFilter.text.isEmpty){
      _phoneNumber = "";
    }
    else{
      _phoneNumber = _phoneNumberFilter.text;
    }
  }

  // Swap in between our two forms, registering and logging in
  void _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  void _formChange2() async {
    setState(() {
      if (_form == FormType.forgot){
        _form = FormType.login;
      } else {
        _form = FormType.forgot;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildBar(context),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    if (_form == FormType.login){
      return new AppBar(
        title: new Text("Login"),
        centerTitle: true,
      );
    }
    else if(_form == FormType.register) {
      return new AppBar(
        title: new Text("Register"),
        centerTitle: true,
      );
    }
    else{
      return new AppBar(
        title: new Text("Forgot Password"),
        centerTitle: true,
      );
    }
  }

  Widget _buildTextFields() {
    if(_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              child: new TextField(
                controller: _emailFilter,
                decoration: new InputDecoration(labelText: 'Email'),
              ),
            ),
            new Container(
              child: new TextField(
                controller: _passwordFilter,
                decoration: new InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            )
          ],
        ),
      );
    }
    else if(_form == FormType.register){
      return new Container(
          child: new Column(
            children: <Widget>[
            new Container(
              child: new TextField(
                controller: _emailFilter,
                decoration: new InputDecoration(labelText: 'Email'),
              ),
            ),
            new Container(
              child: new TextField(
                controller: _passwordFilter,
                decoration: new InputDecoration(labelText: 'Password: 8-15 Characters'),
                obscureText: true,
               ),
            ),
            new Container(
              child: new TextField(
                controller: _confirmPasswordFilter,
                decoration: new InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
               ),
             ),
             new Container(
               child: new TextField(
                  controller: _usernameFilter,
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Container(
                child: new TextField(
                  controller: _firstNameFilter,
                  decoration: new InputDecoration(labelText: 'First Name'),
                ),
              ),
              new Container(
                child: new TextField(
                  controller: _lastNameFilter,
                  decoration: new InputDecoration(labelText: 'Last Name'),
                ),
              ),
              new Container(
                child: new TextField(
                  controller: _phoneNumberFilter,
                  decoration: new InputDecoration(labelText: "Phone Number"),
                ),
              )
          ],
        )
          );
    }
    else if (_form == FormType.forgot){
      return new Container(
        child: new Column(
          children: <Widget>[
          new Container(
            child: new TextField(
              controller: _emailFilter,
              decoration: new InputDecoration(labelText: 'Email Address'),
            ),
          )
          ],
        )
      );
    }
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Login'),
              onPressed: _loginPressed,
            ),
            new FlatButton(
              child: new Text('Dont have an account? Tap here to register.'),
              onPressed: _formChange,
            ),
            new FlatButton(
              child: new Text('Forgot Password?'),
              onPressed: _formChange2,
            )
          ],
        ),
      );
    } else if (_form == FormType.register) {
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text('Create an Account'),
              onPressed: _createAccountPressed,
            ),
            new FlatButton(
              child: new Text('Have an account? Click here to login.'),
              onPressed: _formChange,
            )
          ],
        ),
      );
    }
    else{
      return new Container(
        child: new Column(
          children: <Widget>[
            new RaisedButton(
              child: new Text("Send Password Reset"),
              onPressed: _passwordReset,
            ),
            new RaisedButton(
              child: new Text("Back to Login"),
              onPressed: _formChange2,
            )
          ],
        )
      );
    }
  }

  // These functions can self contain any user auth logic required, they all have access to _email and _password
  void _loginPressed() {
    print('The user wants to login with $_email and $_password');
    Router.navigator.pushNamed(Router.homePage);
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Welcome $_email'),
      );
    });
  }

  void _createAccountPressed() {
    print('The user wants to create an account with $_email and $_password and confirmed password: $_confirmPassword');
    print('Username: $_username, First Name: $_firstName, Last Name: $_lastName, phone number: $_phoneNumber');
    if(_password != _confirmPassword){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Passwords do not match'),
        );
      });
    }
    else if (_email == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter an email address'),
        );
      });
    }
    else if (_password == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter a password'),
        );
      });
    }
    else if (_confirmPassword == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Confirm the password'),
        );
      });
    }
    else if (_username == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter a username'),
        );
      });
    }
    else if(_firstName == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter a first name'),
        );
      });
    }
    else if(_lastName == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter a last name'),
        );
      });
    }
    else if(_phoneNumber == ""){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Enter a phone number'),
        );
      });
    }
    else {
      Router.navigator.pushNamed(Router.homePage);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text('Welcome $_firstName'),
        );
      });
    }
  }

  void _passwordReset() {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Password reset sent to $_email'),
      );
    });
    print("The user wants a password reset request sent to $_email");
    _formChange2();
  }
}
