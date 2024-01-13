import 'package:flutter/material.dart';
import 'package:udemy_flutter/models/user/user_model.dart';


class UsersScreen extends StatelessWidget {
  List<UserModel> users = [
    UserModel(
        id: 1,
        name: 'Moussa Essalhi',
        phone: '+212611111111'),
    UserModel(
        id: 2,
        name: 'Hassan Rghioui',
        phone: '+212622222222'),
    UserModel(
        id: 3,
        name: 'Oussama Eljabbari',
        phone: '+21263333333333'),
    UserModel(
        id: 1,
        name: 'Moussa Essalhi',
        phone: '+212611111111'),
    UserModel(
        id: 2,
        name: 'Hassan Rghioui',
        phone: '+212622222222'),
    UserModel(
        id: 3,
        name: 'Oussama Eljabbari',
        phone: '+21263333333333'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'users',
        ),
      ),
        body: ListView.separated(
            itemBuilder: (context, index) => buildUserItem(users[index]),
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 20.0,
              ),
              child: Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
            ),
            itemCount: users.length) ,
    );
  }

  Widget buildUserItem( UserModel user) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25.0,
          child: Text(
            '${user.id}',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
            width:20.0
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${user.phone}',
                style: TextStyle(
                    color: Colors.grey
                ),
              )
            ],
          ),
        )

      ],
    ),
  );
}
