import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class OrderFoodPage extends StatefulWidget {
  @override
  State<OrderFoodPage> createState() => _OrderFoodPageState();
}

class _OrderFoodPageState extends State<OrderFoodPage> {
  @override
  void initState() {
    super.initState();
    // Inisialisasi Firebase
    Firebase.initializeApp(
      name: 'marestoku',
      options: const FirebaseOptions(
        appId: '1:225202683902:web:bfc3afc78be77ba410caaf',
        apiKey: 'AIzaSyCedz-uO0ql74PDHxwI3FrEWmyHo_WvHCY',
        projectId: 'marestoku',
        messagingSenderId: '225202683902',
        storageBucket: 'marestoku.appspot.com',
        authDomain: 'marestoku.firebaseapp.com',
      ),
    );
  }
  int quantity = 1;
  List<String> cart = [];
  List<String> foods = ["Pizza", "Burger", "Pasta"];
  Map<String, int> orders = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Makanan'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pilih Makanan yang Anda Inginkan:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            for (String food in foods)
              GestureDetector(
                onTap: () {
                  // Tambahkan pesanan ke dalam keranjang (orders)
                  if (orders.containsKey(food)) {
                    orders[food] = (orders[food] ?? 0) + 1;;
                  } else {
                    orders[food] = 1;
                  }
                  setState(() {});
                },
                child: Card(
                  child: ListTile(
                    title: Text(food),
                  ),
                ),
              ),
            SizedBox(height: 20),
            Text(
              'Pesanan Anda:',
              style: TextStyle(fontSize: 20),
            ),
            for (String food in orders.keys)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$food: ${orders[food]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Hapus pesanan
                          setState(() {
                            if (orders.containsKey(food)) {
                              orders[food] = orders[food]! - 1;
                              if (orders[food] == 0) {
                                orders.remove(food);
                              }
                            }
                          });
                        },
                        child: Text('Hapus'),
                      ),
                    ],
                  ),
                  Divider(), // Garis pemisah antara setiap pesanan
                ],
              ),
            ElevatedButton(onPressed: (){
              for (String food in orders.keys) {
                saveOrderToFirestore(food, orders[food] ?? 0);
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pesanan Anda telah disimpan.'),
                ),
              );
            }, child: const Text('Simpan'))
          ],
        ),
      ),
    );
  }
}

Future<void> saveOrderToFirestore(String foodName, int quantity) async {
  final ordersCollection = FirebaseFirestore.instance.collection('orders');
  print(ordersCollection);
  await ordersCollection.add({
    'foodName': foodName,
    'quantity': quantity,
    'timestamp': FieldValue.serverTimestamp(),
  });
}
