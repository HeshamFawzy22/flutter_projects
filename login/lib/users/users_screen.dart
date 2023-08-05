import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/user/user_model.dart';

class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(id: 1, name: 'Hisham', phone: '+20112654995'),
    UserModel(id: 2, name: 'Ahmed', phone: '+20122513995'),
    UserModel(id: 3, name: 'Mohamed', phone: '+20102654995'),
    UserModel(id: 4, name: 'Sayed', phone: '+20122654995'),
    UserModel(id: 5, name: 'kareem', phone: '+20112654995'),
    UserModel(id: 6, name: 'Omar', phone: '+20102654995'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.separated(
          itemBuilder: (context, index) => buildUserModel(users[index]),
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10.0,
              start: 10.0,
              bottom: 10.0,
            ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          itemCount: users.length,
        ),
      ),
    );
  }

  Widget buildUserModel(UserModel user) => Row(
        children: [
          CircleAvatar(
            radius: 25.0,
            child: Text(
              '${user.id}',
              style: const TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                user.phone,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      );
}
