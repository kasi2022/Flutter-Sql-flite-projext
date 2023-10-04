import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/Screens/Admin/Adminlogin_screen.dart';
import 'package:flutter_sql_internalstorage/Screens/userlogin_screen.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';
import 'package:flutter_sql_internalstorage/services/userService.dart';

class UserSignin extends StatefulWidget {
  const UserSignin({Key? key}) : super(key: key);

  @override
  State<UserSignin> createState() => _UserSigninState();
}

class _UserSigninState extends State<UserSignin> {
  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  var _userNameController = TextEditingController();
  var _userpasswordtController = TextEditingController();
  var _useremailController = TextEditingController();
  var _userphoneController = TextEditingController();
  bool _validateName = false;
  bool _validatePhone = false;
  bool _validateContact = false;
  bool _validateDescription = false;
  var _userService = UserService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 120, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 115,
                  child: CircleAvatar(
                    backgroundColor: Colors.greenAccent[100],
                    radius: 110,
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/images/pf.png"),
                      radius: 100,
                    ), //CircleAvatar
                  ), //CircleAvatar
                ), //CircleAvatar
              ), //Center
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('pending'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userphoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone ',
                    labelText: 'Phone',
                    errorText: _validatePhone
                        ? ' Phone Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),

              TextField(
                  controller: _useremailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText: _validateDescription
                        ? 'Email  Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),

              TextField(
                controller: _userpasswordtController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  errorText: _validateContact
                      ? ' Password Contact Value Can\'t Be Empty'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(
                        () {
                          passwordVisible = !passwordVisible;
                        },
                      );
                    },
                  ),
                  alignLabelWithHint: false,
                  filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),

              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Container(
                    width: 350,
                    height: 60,
                    child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            _userNameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _userpasswordtController.text.isEmpty
                                ? _validateContact = true
                                : _validateContact = false;
                            _useremailController.text.isEmpty
                                ? _validateDescription = true
                                : _validateDescription = false;
                            _userphoneController.text.isEmpty
                                ? _validatePhone = true
                                : _validatePhone = false;
                          });
                          if (_validateName == false &&
                              _validateContact == false &&
                              _validateDescription == false) {
                            // print("Good Data Can Save");
                            var _user = User();
                            _user.name = _userNameController.text;
                            _user.password = _userpasswordtController.text;
                            _user.email = _useremailController.text;
                            _user.phone = _userphoneController.text;
                            var result = await _userService.SaveUser(_user);
                            // print("print user id" + result.id);
                            // // Navigator.pop(context, result);
                            // print("t=result"+result);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserLogin()));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40.0, vertical: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            primary: Colors.purple),
                        child: Text("Signup")),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Admin User "),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdminLogin()));
                      },
                      child: Text(
                        "Click?",
                        style: TextStyle(color: Colors.blue),
                      )),
                  Padding(padding: EdgeInsets.all(10))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
