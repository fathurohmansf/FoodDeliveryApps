import 'package:flutter/material.dart';
import 'package:food_delivery_apps/main.dart';
import 'package:food_delivery_apps/utils/utils.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(15),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(""),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/design/images/delivery-1.png',
              width: 150,
              height: 150,
            ),
            SizedBox(height: 30),
            LinearProgressIndicator(
              backgroundColor: Colors.blue,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            SizedBox(height: 20),
            Text(
              'Pesanan akan segera di kirim, \n ke menu account jika sudah sampai dan ingin menyelesaikan pesanan',
              style: SafeGoogleFont(
                'Roboto',
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyHomePage()),
                  );
                },
                child: Text('Cek Status Pesanan'))
          ],
        ),
      ),
    );
  }
}
