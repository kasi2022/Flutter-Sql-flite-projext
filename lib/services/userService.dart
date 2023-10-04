import 'dart:async';

import 'package:flutter_sql_internalstorage/db_helper/repository.dart';
import 'package:flutter_sql_internalstorage/model/User.dart';


class UserService {
  late Repository _repository;
  UserService() {
    _repository = Repository();
  }
  //Save User
  SaveUser(User user) async {
    return await _repository.insertData('users', user.userMap());
  }

  //Read All Users
  readAllUsers() async {
    return await _repository.readData('users');
  }

  //sigin in user value
  // particularuser() async {
  //   return await _repository.readData()
  // }
  //Edit User
  UpdateUser(User user) async {
    return await _repository.updateData('users', user.userMap());
  }

  deleteUser(username) async {
    return await _repository.deleteDataById('users', username);
  }

  selectUser(username) async {
    return await _repository.readDataByUser('user', username);
  }
}
