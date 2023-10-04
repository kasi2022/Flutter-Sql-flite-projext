class User {
  int? id; //phone
  String? name;
  String? password; //password
  String? email; //email
  String? phone;

  userMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['password'] = password!;
    mapping['email'] = email!;
    mapping['phone'] = phone!;
    return mapping;
  }
}
