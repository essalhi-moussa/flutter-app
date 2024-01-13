import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CounterScreen extends StatefulWidget {

  @override
  _CounterScreenState createState() {
    return _CounterScreenState();
  }
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 1;

  @override
  void initStat(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Counter',
        )
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  setState(() {
                    counter--;
                    print(counter);
                  });

                },
                child: Text(
                  'MINUS',
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Text(
                '${counter}',
                style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                setState(() {
                  counter++;
                  print(counter);
                });
              },
              child: Text(
                'PLUS',
              ),
            ),
          ],
        ),
      ),
    );
  }
}


