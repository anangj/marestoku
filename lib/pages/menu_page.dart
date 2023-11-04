import 'package:flutter/material.dart';
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
                // Tambahkan aksi ketika "Pasien" dipilih
                // navigateToPage("Pasien");
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderFoodPage()));

              },
              child: Text('Pasien'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi ketika "Office" dipilih
                navigateToPage("Office");
              },
              child: Text('Office'),
            ),
            ElevatedButton(
              onPressed: () {
                // Tambahkan aksi ketika "Resto" dipilih
                navigateToPage("Resto");
              },
              child: Text('Resto'),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToPage(String menuOption) {
    // Di sini Anda dapat menavigasi ke halaman yang sesuai berdasarkan pilihan menu
    // Anda dapat menggunakan Navigator, seperti Navigator.push, untuk menampilkan halaman yang sesuai.
    // Misalnya, Navigator.push(context, MaterialPageRoute(builder: (context) => PasienPage()));

    // Contoh:
    if (menuOption == "Pasien") {
      // Navigasi ke halaman Pasienr
    } else if (menuOption == "Office") {
      // Navigasi ke halaman Office
    } else if (menuOption == "Resto") {
      // Navigasi ke halaman Resto
    }
  }
}