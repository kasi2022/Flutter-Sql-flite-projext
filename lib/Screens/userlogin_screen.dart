import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/Screens/user_dashbord.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';
import 'package:flutter_sql_internalstorage/model/constants.dart';
import 'package:flutter_sql_internalstorage/services/userService.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserLogin extends StatefulWidget {
  final String? getindexvalue;
  UserLogin({this.getindexvalue});

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _contactController = TextEditingController();
  String _resultMessage = '';

  Future<void> getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    List<User> userList = [];

    users.forEach((user) {
      var userModel = User();
      userModel.id = user['id'];
      userModel.name = user['name'];
      userModel.password = user['password'];
      userModel.email = user['email'];
      userModel.phone = user['phone'];
      userList.add(userModel);
    });

    setState(() {
      _userList = userList;
    });
  }

  void checkCredentials() {
    String inputUsername = _usernameController.text;
    String inputContact = _contactController.text;

    bool isAuthenticated = _userList.any(
        (user) => user.name == inputUsername && user.password == inputContact);

    setState(() {
      if (isAuthenticated) {
        // Find the index of the authenticated user
        int authenticatedIndex = _userList.indexWhere((user) =>
            user.name == inputUsername && user.password == inputContact);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserDashbord(user: _userList[authenticatedIndex]),
          ),
        );
      } else {
        _resultMessage = 'Authentication failed.';
      }
    });
  }

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    getAllUserDetails();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "LOGIN",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: defaultPadding * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Spacer(),
                  Expanded(
                    flex: 8,
                    child: SvgPicture.asset("assets/icons/login.svg"),
                  ),
                  const Spacer(),
                ],
              ),
              SizedBox(height: defaultPadding * 2),
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _contactController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  helperStyle: TextStyle(color: Colors.green),
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
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: checkCredentials,
                child: Text('Login'),
              ),
              Text(_resultMessage),
            ],
          ),
        ),
      ),
    );
  }
}
