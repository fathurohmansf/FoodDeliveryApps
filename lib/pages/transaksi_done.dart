import 'package:flutter/material.dart';
import 'package:food_delivery_apps/main.dart';
import 'package:food_delivery_apps/model/cart_model.dart';
import 'package:provider/provider.dart';

class TransaksiBerhasil extends StatelessWidget {
  const TransaksiBerhasil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 100.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Transaksi Berhasil!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20.0),
            Consumer<CartModel>(
              builder: (context, value, child) {
                return Column(
                  children: value.cartItems.map<Widget>((item) {
                    return ListTile(
                      title: Text(
                        item[0],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Rp. ${item[1]} x ${item[3]}', //  x ${item[3]}
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyHomePage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                'Kembali ke Homepage',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
