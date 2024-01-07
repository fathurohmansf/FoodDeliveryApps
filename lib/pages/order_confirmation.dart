import 'package:flutter/material.dart';
import 'package:food_delivery_apps/model/cart_model.dart';
import 'package:food_delivery_apps/pages/transaksi_success.dart';
import 'package:provider/provider.dart';

class OrderConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Confirmation'),
      ),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: value.orderDelivery.length,
                  itemBuilder: (context, index) {
                    final item = value.orderDelivery[index];
                    return ListTile(
                      title: Text(
                        '${item[0]} x${item[5]}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rp. ${item[1]}'),
                          Text('Rp. ${value.calculateTotalitem(index)}')
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(color: Colors.green[200]),
                        ),
                        Text(
                          'Total: Rp. ${value.calculateTotalOrder()}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: () {
                        // Tambahkan logika untuk tombol 'Konfirmasi Pesanan'
                        _handleOrderConfirmation(context, value.orderDelivery);
                      },
                      child: Text(
                        'Konfirmasi Pesanan',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _handleOrderConfirmation(
      BuildContext context, List<List<dynamic>> orderItems) {
    // Tambahkan logika untuk menangani konfirmasi pesanan
    Provider.of<CartModel>(context, listen: false).clearOngoingDelivery();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TransactionSuccess(),
      ),
    );
    // Misalnya, tampilkan pesan konfirmasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pesanan berhasil dikonfirmasi'),
      ),
    );
  }
}
