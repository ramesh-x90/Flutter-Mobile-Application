import 'package:flutter/material.dart';
import 'package:hello_world/NetWorking/Comm.dart';
import 'package:hello_world/NetWorking/Server.dart';
import 'package:hello_world/Protocol/Protocol.dart';

import 'InputValidator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailCon = TextEditingController();
  TextEditingController _passwdCtl = TextEditingController();
  String _email = 'test', _passwd = 'name';
  final _formKey = GlobalKey<FormState>();

  Server? server = Comm.getServer();

  void _logingPressed() {
    if (_formKey.currentState!.validate()) {
      _email = _emailCon.text;
      _passwd = _passwdCtl.text;
      print("username: " + _email + " passwd: " + _passwd);
      server?.send_logging_data(name: _email, passwd: _passwd);

      //if verified load menu

    }
  }

  void loggingVerListner(int code) {
    switch (code) {
      case 1:
        Navigator.pushNamed(context, '/DashBoard');
        break;
      default:
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    Protocol.setloginpagelistner(loggingVerListner);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      controller: _emailCon,
                      maxLength: 20,
                      cursorColor: Colors.blue,
                      validator: (value) => Validator.valid(value),
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        prefixIcon: Icon(Icons.mail),
                        suffixIcon: Icon(Icons.remove_red_eye),
                        border: OutlineInputBorder(),
                        labelText: 'Email address',
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: TextFormField(
                      maxLength: 20,
                      controller: _passwdCtl,
                      validator: (value) => Validator.valid(value),
                      cursorColor: Colors.blue,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'passWord',
                        border: OutlineInputBorder(),
                        labelText: 'password',
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: Icon(Icons.remove_red_eye),
                      ),
                    ),
                  ),
                  OutlinedButton.icon(
                    icon: Icon(Icons.login),
                    label: Text('Login'),
                    onPressed: _logingPressed,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
