import 'package:flutter/material.dart';
import 'package:marestoku/pages/office_page.dart';
import 'package:marestoku/pages/order_food_page.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilihan Menu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderFoodPage()));
              },
              child: Text('Pasien'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OfficePage()));
              },
              child: Text('Office'),
            ),
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Resto'),
            ),
          ],
        ),
      ),
    );
  }
}