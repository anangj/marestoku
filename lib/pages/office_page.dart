import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfficePage extends StatefulWidget {
  @override
  _OfficePageState createState() => _OfficePageState();
}

class _OfficePageState extends State<OfficePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Office'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            FutureBuilder<double>(
              future: getTotalOrderedMenu(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text('Jumlah Menu yang Dipesan: ${snapshot.data}');
                }
              },
            ),


            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future: getOrderedFoodData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text('Tidak ada data pesanan.');
                  } else {
                    return ListView(
                      children: snapshot.data!.docs.map((document) {
                        final foodName = document['foodName'];
                        final quantity = document['quantity'];
                        return ListTile(
                          title: Text('Food: $foodName'),
                          subtitle: Text('Quantity: $quantity'),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _showAddRestaurantDialog();
              },
              child: Text('Tambah Restoran'),
            ),
          ],
        ),
      ),
    );
  }

  Future<double> getTotalOrderedMenu() async {

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('orders').get();
    double totalMenu = 0;
    for (QueryDocumentSnapshot document in querySnapshot.docs) {
      final quantity = document['quantity'];
      if (quantity is num) {
        totalMenu += quantity.toDouble();
      }
    }
    return totalMenu;
  }

  Future<QuerySnapshot> getOrderedFoodData() async {
    return await FirebaseFirestore.instance.collection('orders').get();
  }
  Future<void> _showAddRestaurantDialog() async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Restoran'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                TextFormField(
                  decoration: InputDecoration(labelText: 'Nama Restoran'),
                  controller: _nameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Alamat Restoran'),
                  controller: _addressController,
                ),

              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Tombol Batal
                Navigator.pop(context);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {

                final restaurantName = _nameController.text;
                final restaurantAddress = _addressController.text;

                if (restaurantName.isNotEmpty && restaurantAddress.isNotEmpty) {

                  final restaurantData = {
                    'name': restaurantName,
                    'address': restaurantAddress,

                  };

                  try {

                    await FirebaseFirestore.instance.collection('restaurants').add(restaurantData);


                    Navigator.pop(context);
                  } catch (error) {

                    print('Error: $error');
                  }
                } else {

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Isi semua bidang formulir.'),
                    ),
                  );
                }
              },
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

}

