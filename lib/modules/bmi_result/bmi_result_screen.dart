import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiResultScreen extends StatelessWidget {
  final int result;
  final bool gender;
  final int age;

  BmiResultScreen({
    required this.result,
    required this.age,
    required this.gender,
});



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:Text(
            'BMI Result'
        ) ,
        backgroundColor: Color(0xFF0B0F1F),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFF111324),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF1B1A2E),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Gender : ',
                      style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.bold,
                        color: Color(0xFF595869),
                      ),
                    ),
                  ),
                  Text(
                    '${gender ? 'Male' : 'femelle'}',
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF1B1A2E),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Age : ',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595869),
                      ),
                    ),
                  ),
                  Text(
                    '${age}',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFF1B1A2E),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Result : ',
                      style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF595869),
                      ),
                    ),
                  ),
                  Text(
                    '${result}',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:300.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                height: 50.0,
                color: Color(0xFFD41145), // Set the background color
                child: Text(
                  'Go Back',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }
}
