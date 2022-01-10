import 'package:flutter/material.dart';
import 'package:hello_world/NetWorking/Comm.dart';
import 'package:hello_world/NetWorking/Server.dart';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/ServerResponse/resposes.dart';
import 'package:hello_world/Protocol/requests/reqFunctions.dart';
import 'package:hello_world/Protocol/requests/reqTypes.dart';
import 'package:hello_world/StateSave/CurrentAppstate.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';

import 'InputValidator.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  TextEditingController _userNameCtl = TextEditingController();
  TextEditingController _passwdCtl = TextEditingController();
  String _userName = 'test', _passwd = 'name';
  final _formKey = GlobalKey<FormState>();

  late AnimationController ac;
  late Animation animation;

  // Server? server = Comm.getServer();
  bool hidePass = true;
  bool cached = false;

  late LoginReq loginReq;

  void _logingPressed() {
    if (_formKey.currentState!.validate()) {
      _userName = _userNameCtl.text;
      _passwd = _passwdCtl.text;
      print("username: " + _userName + " passwd: " + _passwd);

      reqLoging(_userName, _passwd);

      //if verified load menu

    }
  }

  void loggingVerListner(LoginAuthentication res) {
    if (this.mounted) {
      switch (res.getVarification()) {
        case 0:
          ShowToast("Login Successful");
          // reqMyuserInfo();
          // Navigator.pushNamed(context, '/DashBoard');
          CurrentAppState.sharedPreferencesStringSave('username', _userName);
          CurrentAppState.sharedPreferencesStringSave('password', _passwd);
          Navigator.pushNamedAndRemoveUntil(
              context, '/DashBoard', (route) => false);
          break;
        case -1:
          _passwdCtl.text = "";
          setState(() {
            cached = false;
          });
          break;
        case -2:
          _userNameCtl.text = "";
          setState(() {
            cached = false;
          });
          break;
        default:
          setState(() {
            cached = false;
          });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    ac = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation =
        Tween<Offset>(begin: Offset(0.0, 0.5), end: Offset(0.0, 0.0)).animate(
      CurvedAnimation(parent: ac, curve: Curves.easeInOut),
    );
    ac.forward();
    Protocol.setloginpagelistner(loggingVerListner);
    checkCredentialsinShared();
    super.initState();
  }

  @override
  void dispose() {
    ac.dispose();
    super.dispose();
  }

  void checkCredentialsinShared() async {
    var spname = await CurrentAppState.getPreferencesStringvalue('username');
    var sppass = await CurrentAppState.getPreferencesStringvalue('password');

    if (spname != null && sppass != null) {
      setState(() {
        cached = true;
      });

      reqLoging(spname, sppass);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: (!cached)
            ? Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  // color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("Asset/Images/log1.jpg"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: AnimatedBuilder(
                  animation: ac,
                  builder: (context, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                              begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
                          .animate(CurvedAnimation(
                              parent: ac, curve: Curves.bounceInOut)),
                      child: child,
                    );
                  },
                  child: SizedBox(
                    child: Column(
                      children: [
                        Spacer(
                          flex: 1,
                        ),
                        buildForm(context),
                        Spacer(
                          flex: 3,
                        ),
                        btns(context),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  Form buildForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      spreadRadius: 0.1,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _userNameCtl,
                    maxLength: 20,
                    cursorColor: Colors.white,
                    validator: (value) => Validator.valid(value),
                    decoration: InputDecoration(
                      // hintText: 'Username',
                      prefixIcon: Icon(Icons.mail),
                      suffixIcon: Icon(Icons.remove_red_eye),
                      // border: OutlineInputBorder(),
                      labelText: 'Username',
                      errorStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                      spreadRadius: 0.1,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLength: 20,
                    controller: _passwdCtl,
                    validator: (value) => Validator.valid(value),
                    cursorColor: Colors.blue,
                    obscureText: hidePass,
                    decoration: InputDecoration(
                      // hintText: 'passWord',
                      // border: OutlineInputBorder(),
                      labelText: 'password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePass = !hidePass;
                          });
                        },
                        icon: (hidePass)
                            ? Icon(Icons.remove_red_eye)
                            : Icon(
                                Icons.remove_red_eye,
                                color: Colors.blueAccent,
                              ),
                      ),
                      errorStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget btns(BuildContext context) {
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.only(
          //     top: (MediaQuery.of(context).size.height) * 0.4),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xff19599A),
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                  spreadRadius: 0.1,
                ),
              ],
            ),
            child: TextButton(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, '/RegistrationForm'),
            ),
          ),
        ),
        Container(
          width: 200,
          decoration: BoxDecoration(
            color: Color(0xff19599A),
            borderRadius: BorderRadius.circular(10),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black45,
                blurRadius: 5,
                offset: Offset(0, 5),
                spreadRadius: 0.1,
              ),
            ],
          ),
          margin: EdgeInsets.only(top: 10),
          child: TextButton(
            child: Text(
              'Sign in',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: _logingPressed,
          ),
        )
      ],
    );
  }
}
