import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hello_world/NetWorking/Comm.dart';
import 'package:hello_world/NetWorking/Server.dart';
import 'package:hello_world/PopMsgs/Toast.dart';
import 'package:hello_world/Protocol/Protocol.dart';
import 'package:hello_world/Protocol/requests/reqTypes.dart';
import 'package:hello_world/res/Strings/EnvRes.dart';
import 'package:image_picker/image_picker.dart';
import 'InputValidator.dart';

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _userNameCtl = TextEditingController();
  final TextEditingController _emailCtl = TextEditingController();
  final TextEditingController _passwdCtl = TextEditingController();
  final TextEditingController _passwdConfirmCtl = TextEditingController();

  List<String> dropdownitems = ['Student', 'lecturer', 'admin'];
  String _currentDropdownSelectedValue = '';
  var imagePicker = ImagePicker();
  var image;
  bool hidePass = true;

  final _formKey = GlobalKey<FormState>();

  void regFormResultslistner(int code) {
    switch (code) {
      case 0:
        ShowToast("registration successful");
        Navigator.pop(context);
        break;
      case -1:
        ShowToast("registration failed. Email all ready exists");
        break;
      case -2:
        ShowToast("registration failed. username all ready exists");
        break;
      case -3:
        ShowToast("Unknow Error");
        break;
      default:
    }
  }

  @override
  void initState() {
    // TODO: implement initState

    Protocol.setRegFormResultslistner(regFormResultslistner);
    _currentDropdownSelectedValue = dropdownitems[0];
    super.initState();
  }

  @override
  void dispose() {
    _userNameCtl.dispose();
    _emailCtl.dispose();
    _passwdCtl.dispose();
    _passwdConfirmCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Scaffold(
        //scrolabel form
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("Asset/Images/reg1.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //profile image upload
                Container(
                  margin: EdgeInsets.only(top: 50),
                  width: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: image == null
                        ? IconButton(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                            onPressed: getimage,
                            iconSize: 150,
                          )
                        : Image.file(
                            image,
                            fit: BoxFit.fitHeight,
                            height: 200,
                          ),
                  ),
                ),
                //image delete button
                Visibility(
                  visible: image != null,
                  child: Container(
                    child: IconButton(
                        onPressed: deleteImage, icon: Icon(Icons.delete)),
                  ),
                ),

                //registration form
                buildForm(),

                //Submit button
                Container(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.subdirectory_arrow_right,
                        color: Colors.white),
                    label: Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => _submitPressed(context),
                    style: ElevatedButton.styleFrom(primary: Color(0xff19599A)),
                  ),
                ),

                //back button goto login page
                Container(
                  child: OutlinedButton.icon(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    label: Text(
                      'Back',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () => {Navigator.pop(context)},
                    style: ElevatedButton.styleFrom(primary: Color(0xff19599A)),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Form buildForm() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            //username field
            Container(
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _userNameCtl,
                  maxLength: 20,
                  cursorColor: Colors.blue,
                  validator: (value) => Validator.valid(value),
                  decoration: InputDecoration(
                    // hintText: 'Username',
                    prefixIcon: Icon(Icons.person),
                    // border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
              ),
            ),
            //dropdown
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              child: Container(
                child: DropdownButtonFormField(
                  dropdownColor: Colors.black45,
                  validator: (value) => Validator.dropdownvalid(value),
                  hint: Text(
                    'Select who you are',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  items: dropdownitems
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: (value != 'admin')
                          ? Text(
                              value,
                              style: TextStyle(color: Colors.white),
                            )
                          : Container(
                              child: Row(children: [
                                Text(
                                  'admin',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Container(
                                  width: 200,
                                ),
                                Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                              ]),
                            ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentDropdownSelectedValue = value as String;
                    });
                  },
                ),
              ),
            ),
            //email feild
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _emailCtl,
                  maxLength: 40,
                  cursorColor: Colors.blue,
                  validator: (value) => Validator.emailvalid(value),
                  decoration: InputDecoration(
                    // hintText: 'Email Address',
                    prefixIcon: Icon(Icons.mail),
                    // border: OutlineInputBorder(),
                    labelText: 'Email Address',
                  ),
                ),
              ),
            ),
            //password field
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _passwdCtl,
                  maxLength: 20,
                  cursorColor: Colors.blue,
                  validator: (value) => Validator.valid(value),
                  obscureText: hidePass,
                  decoration: InputDecoration(
                    // hintText: 'Password',
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
                    // border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ),

            //password confirm field
            Container(
              margin: EdgeInsets.only(bottom: 10),
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
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _passwdConfirmCtl,
                  maxLength: 20,
                  cursorColor: Colors.blue,
                  obscureText: hidePass,
                  validator: (value) => Validator.valid(value),
                  decoration: InputDecoration(
                    // hintText: 'Password',
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

                    // border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPressed(BuildContext context) {
    var file = image == null ? null : image;

    if (_formKey.currentState!.validate()) {
      if (_passwdCtl.text == _passwdConfirmCtl.text) {
        //send req to server

        var req = RegistrationReq(
          EnvRes.restrationReq,
          _userNameCtl.text,
          _emailCtl.text,
          _passwdConfirmCtl.text,
          _currentDropdownSelectedValue,
          profileimage: file,
        );

        if (image != null)
          Server.send(
              msg: json.encode(req),
              binaryData: (image as File).readAsBytesSync());
        else {
          Server.send(
            msg: json.encode(req),
          );
        }

        ShowToast("Submitted");
      } else {
        ShowToast("Password does not match");
      }
    }
  }

  Future<void> getimage() async {
    XFile? _image = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (_image != null) {
        image = File(_image.path);
      }
    });
  }

  void deleteImage() {
    setState(() {
      image = null;
    });
  }
}
