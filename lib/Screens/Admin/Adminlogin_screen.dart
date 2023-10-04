import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/Screens/Admin/Admin_dashbord.dart';
import 'package:flutter_sql_internalstorage/model/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var _adminanmeController = TextEditingController();
  var _admipasswordController = TextEditingController();
  bool _validateadminname = false;
  bool _validateadminpassword = false;
  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void isValid() {
    if ("Admin" == _adminanmeController.text &&
        "000" == _admipasswordController.text.toString()) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminDashbord()));
    } else {
      _showSuccessSnackBar('Admin invalid');
    }
  }

  bool passwordVisible = false;
  @override
  void initState() {
    super.initState();
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
                "Admin Login",
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
                  controller: _adminanmeController,
                  decoration: InputDecoration(
                    hintText: 'Enter Admin Name',
                    labelText: 'Admin Name (Admin)',
                    errorText: _validateadminname
                        ? 'Adminname Contact Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              // TextField(
              //     controller: _admipasswordController,
              //     decoration: InputDecoration(
              //
              //       hintText: 'Enter Adminpassword',
              //       labelText: 'Admin Password (000)',
              //       errorText: _validateadminpassword
              //           ? 'Adminpassword Contact Value Can\'t Be Empty'
              //           : null,
              //     )),
              TextField(
                controller: _admipasswordController,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  hintText: "Password",
                  labelText: "Password",
                  // helperText: "Password must contain special character",
                  errorText: _validateadminpassword
                      ? 'Adminpassword Contact Value Can\'t Be Empty'
                      : null,
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
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    isValid();
                  },
                  child: Text("AdminLogin"))
            ],
          ),
        ),
      ),
    );
  }
}
