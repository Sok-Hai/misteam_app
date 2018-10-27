import 'package:flutter/material.dart';





class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('404 Not Found Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: <Widget>[
            Image.asset(
              'assets/404_not_found.jpg', 
              fit: BoxFit.contain,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'PAGE NOT FOUND!',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold
              ),
            )
          ],
        ),
      ),
    );
  }

}