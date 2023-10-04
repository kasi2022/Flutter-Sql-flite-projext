import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';

class AdminRemovedUserScreen extends StatelessWidget {
  final List<User> removedUsers;

  const AdminRemovedUserScreen({Key? key, required this.removedUsers})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: removedUsers.length,
        itemBuilder: (context, index) {
          var user = removedUsers[index];
          return ListTile(
            title: Text(user.name ?? ''),
            subtitle: Text(user.password ?? ''),
            // Add more user details here
          );
        },
      ),
    );
  }
}
