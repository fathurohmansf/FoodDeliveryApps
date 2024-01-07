import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_apps/pages/delivery_page.dart';
import 'package:food_delivery_apps/model/user_model.dart';
import 'package:food_delivery_apps/utils/utils.dart';

import '../model/cart_model.dart';

class CartPage extends StatefulWidget {
  final String uid;
  const CartPage({Key? key, required this.uid});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<UserModel?> _userFuture;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _userFuture = UserModel.getUserFromFirestore(widget.uid);
  }

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
          )),
      body: Consumer<CartModel>(
        builder: (context, value, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Let's order fresh items for you
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  "My Cart",
                  style: GoogleFonts.notoSerif(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // list view of cart
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: value.cartItems.isEmpty
                      ? Center(
                          child: Text(
                            'Daftar pesananmu kosong, \n isi dengan pilihan menu lezat yuk',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        )
                      : ListView.builder(
                          itemCount: value.cartItems.length,
                          padding: EdgeInsets.all(12),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(8)),
                                child: ListTile(
                                  leading: Image.asset(
                                    value.cartItems[index][2],
                                    height: 36,
                                  ),
                                  title: Text(
                                    //value.cartItems[index][0],
                                    '${value.cartItems[index][0]} x${value.cartItems[index][5]}', // Menampilkan judul dan quantity
                                    style: const TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  subtitle: Text(
                                    '\Rp. ' + value.cartItems[index][1],
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black),
                                  ),
                                  trailing: IconButton(
                                    color: Colors.black,
                                    icon: const Icon(Icons.cancel),
                                    onPressed: () => Provider.of<CartModel>(
                                            context,
                                            listen: false)
                                        .removeItemFromCart(index),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              // total amount + pay now

              Padding(
                padding: const EdgeInsets.all(36.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green,
                  ),
                  padding: const EdgeInsets.all(24),
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
                          const SizedBox(height: 8),
                          Text(
                            '\Rp. ${value.calculateTotal()}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Tampilkan notifikasi dan tanggapi aksi pengguna
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Konfirmasi Pesanan"),
                                content: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureBuilder<UserModel?>(
                                      future: UserModel.getUserFromFirestore(
                                          widget.uid),
                                      //future: _userFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        } else if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Center(
                                            child: Text(
                                              "User not found",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          );
                                        } else {
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Nama: ${snapshot.data!.username ?? "N/A"}',
                                                    style: SafeGoogleFont(
                                                      'Roboto',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )
                                                    // TextStyle(fontSize: 18),
                                                    ),
                                                SizedBox(height: 12),
                                                Text(
                                                    'Tujuan: ${snapshot.data!.lokasi ?? "N/A"}',
                                                    style: SafeGoogleFont(
                                                      'Roboto',
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    )),
                                                SizedBox(height: 26),
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Text(
                                        "Anda akan menyelesaikan pesanan dengan total:"),
                                    const SizedBox(height: 8),
                                    Text('\Rp. ${value.calculateTotal()}'),
                                    const SizedBox(height: 16),
                                    Text(
                                        "Apakah Anda yakin ingin melanjutkan?"),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Tutup dialog
                                    },
                                    child: Text("Tidak"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Hapus semua item dari keranjang
                                      Provider.of<CartModel>(context,
                                              listen: false)
                                          .ongoingDelivery();
                                      // Tutup dialog
                                      Navigator.pop(context);
                                      // Navigasi ke halaman transaksi berhasil
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DeliveryPage(),
                                        ),
                                      );
                                    },
                                    child: Text("Ya"),
                                  ),
                                ],
                              );
                            },
                          ); //sini
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                        ),
                        child: Row(
                          children: const [
                            Text(
                              'Pay Now',
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
