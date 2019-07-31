import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Error!"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.error,
            size: 150,
            color: Colors.white30,
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text(
              "Trouble Loading Page!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white30,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FlatButton(
            onPressed: () => Navigator.popUntil(
              context,
              ModalRoute.withName("/"),
            ),
            child: Text(
              "return home",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
