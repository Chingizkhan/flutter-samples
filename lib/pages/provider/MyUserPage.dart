import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "FutureProvider Example, users loaded from a File",
            style: TextStyle(fontSize: 17),
          ),
        ),
        Consumer(
          builder: (context, List<User> users, _) {
            print('users ${users}');
            return Expanded(
                child: users.isEmpty
                  ? Container(child: const Center(child: CircularProgressIndicator(),),)
                  : ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        color: Colors.grey[(index * 200) % 400],
                        child: Center(child: Text('${users[index].firstName} ${users[index].lastName} | ${users[index].website}'),),
                      );
                    }
                )
            );
          },
        )
      ],
    );
  }
}

class User {
  String firstName = '', lastName = '', website = '';
  User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
    : firstName = json['first_name'],
      lastName = json['last_name'],
      website = json['website'];
}

class UserList {
  final List<User> users;
  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
    : users = usersJson.map((user) => User.fromJson(user)).toList();
}

class UserProvider {
  final String _dataPath = "assets/users.json";
  late List<User> users;

  Future<String> loadAsset() async {
    return await Future.delayed(const Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    print('Done loading users: ' + jsonEncode(users));
    return users;
  }
}
