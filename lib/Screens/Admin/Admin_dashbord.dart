import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/Screens/Admin/AdminviewScreen.dart';
import 'package:flutter_sql_internalstorage/model/constants.dart';


class AdminDashbord extends StatefulWidget {
  const AdminDashbord({super.key});

  @override
  State<AdminDashbord> createState() => _AdminDashbordState();
}

class _AdminDashbordState extends State<AdminDashbord> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("AdminDashbord"),
          backgroundColor: kPrimaryColor,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "UserDetails",
              ),
              Tab(
                text: "Removed",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(
              child: AdminViewScreen(),
            ),
            Center(child: Text("Pending")),
          ],
        ),
      ),
    );
  }
}
