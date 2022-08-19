import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/user.dart';

class UserInfoPage extends StatelessWidget {
  UserInfoPage({Key? key, required this.userInfo}) : super(key: key);

  var rowDate = DateTime(1485789600);
  var dateFormat = DateFormat('EEEE');
  print() {
    dateFormat.format(rowDate);
  }

  FormUser userInfo;

  var email = const ListTile(
    title: Text(
      'Email',
      style: TextStyle(
          fontWeight: FontWeight.w500
      ),
    ),
    leading: Icon(
      Icons.mail,
      color: Colors.black,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Info'),
        centerTitle: true,
      ),
      body: Card(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(
                userInfo.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              subtitle: Text(userInfo.story),
              leading: const Icon(Icons.person, color: Colors.black,),
              trailing: Text(userInfo.country),
            ),
            const ListTile(
              title: Text(
                'Phone',
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              leading: Icon(
                Icons.phone,
                color: Colors.black,
              ),
            ),
            email
          ],
        ),
      ),
    );
  }
}
