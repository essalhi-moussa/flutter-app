import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        leading: Icon(
          Icons.menu,
        ),
        title: Text(
              'First app',
          ),
        actions: [
          IconButton(
              icon: Icon(
            Icons.notification_important,
          ),
              onPressed:onNotification ),
          IconButton(onPressed: ()
          {
            print('searsh clicked');
          },
              icon: Icon(
                Icons.search,
              )
          )

        ],


      ),
      body: Column(
        children:
        [
          Padding(

            padding: EdgeInsets.all(10.0),

            child: Container(
              width: 200.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(20.0)
                ),
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                    'https://images.pexels.com/photos/36753/flower-purple-lical-blosso.jpg'
                  ),
                    height: 200.0,
                    width: 200.0,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.deepPurpleAccent.withOpacity(.36),
                    width: double.infinity,
                    padding: EdgeInsetsDirectional.symmetric(
                      vertical: 6
                    ),
                    child: Text(
                      'Flower',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,


                      )
                    ),
                  )
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  void onNotification(){
    print('notification clicked');
  }
}
