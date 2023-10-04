import 'package:flutter/material.dart';
import 'package:flutter_sql_internalstorage/Screens/user_dashbord.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';
import 'package:flutter_sql_internalstorage/services/userService.dart';
import 'package:flutter_sql_internalstorage/services/viewUser.dart';

class AdminViewScreen extends StatefulWidget {
  const AdminViewScreen({Key? key}) : super(key: key);

  @override
  State<AdminViewScreen> createState() => _AdminViewScreenState();
}

class _AdminViewScreenState extends State<AdminViewScreen> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.password = user['password'];
        userModel.email = user['email'];
        userModel.phone = user['phone'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  var _searchController = TextEditingController();
  List<User> filterUsers(String query) {
    query = query.toLowerCase();
    return _userList.where((user) {
      return user.name!.toLowerCase().contains(query) ||
          user.email!.toLowerCase().contains(query);
    }).toList();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result = await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar('User Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(.0),
            child: TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  _userList = filterUsers(query);
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by Name, ID, or Description',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewUser(
                            user: _userList[index],
                          ),
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.person,
                      size: 40,
                    ),
                    title: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(_userList[index].name ?? ''),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_userList[index].password ?? ''),
                        SizedBox(
                          height: 5,
                        ),
                        Text(_userList[index].email ?? '')
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditUser(
                                  user: _userList[index],
                                ),
                              ),
                            ).then((data) {
                              if (data != null) {
                                getAllUserDetails();
                                _showSuccessSnackBar(
                                    'User Detail Updated Success');
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.teal,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _deleteFormDialog(
                              context,
                              _userList[index].id,
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
