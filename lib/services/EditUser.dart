import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';
import 'package:flutter_sql_internalstorage/services/userService.dart';

class EditUser extends StatefulWidget {
  final User user;
  const EditUser({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  var _userNameController = TextEditingController();
  var _userPasswordController = TextEditingController();
  var _userEmailController = TextEditingController();
  var _userPhoneController = TextEditingController();

  bool _validateName = false;
  bool _validatePassword = false;
  bool _validateEmail = false;
  bool _validatePhone = false;
  var _userService = UserService();

  @override
  void initState() {
    setState(() {
      _userNameController.text = widget.user.name ?? '';
      _userPasswordController.text = widget.user.phone ?? '';
      _userEmailController.text = widget.user.email ?? '';
      _userPhoneController.text = widget.user.password ?? '';
      ;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("SQLite CRUD"),
      // ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 55, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                      backgroundImage: AssetImage("assets/images/profile.png"),
                      radius: 100,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              const Text(
                'Edit New User',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
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
                  controller: _userPhoneController,
                  decoration: InputDecoration(
                    hintText: 'Enter Phone',
                    labelText: 'Phone',
                    errorText:
                        _validatePhone ? 'Contact Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _userEmailController,
                  decoration: InputDecoration(
                    hintText: 'Enter Email',
                    labelText: 'Email',
                    errorText: _validateEmail
                        ? 'Description Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              // TextField(
              //     controller: _userPasswordController,
              //     decoration: InputDecoration(

              //       hintText: 'Enter Password',
              //       labelText: 'Password',
              //       errorText: _validatePassword
              //           ? 'Contact Value Can\'t Be Empty'
              //           : null,
              //     )),
              // const SizedBox(
              //   height: 20.0,
              // ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          _userNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          _userPasswordController.text.isEmpty
                              ? _validatePassword = true
                              : _validatePassword = false;
                          _userEmailController.text.isEmpty
                              ? _validateEmail = true
                              : _validateEmail = false;
                        });
                        if (_validateName == false &&
                            _validatePassword == false &&
                            _validateEmail == false) {
                          // print("Good Data Can Save");
                          var _user = User();
                          _user.id = widget.user.id;
                          _user.name = _userNameController.text;
                          _user.password = _userPasswordController.text;
                          _user.email = _userEmailController.text;
                          _user.phone = _userPhoneController.text;
                          var result = await _userService.UpdateUser(_user);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        _userNameController.text = '';
                        _userPhoneController.text = '';
                        _userEmailController.text = '';
                        _userPasswordController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
