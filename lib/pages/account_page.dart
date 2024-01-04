import 'dart:io';
import 'package:flutter/material.dart';
//import 'package:food_delivery_apps/components/order_history_page.dart';
import 'package:food_delivery_apps/model/user_model.dart';
import 'package:food_delivery_apps/pages/home_page.dart';
import 'package:food_delivery_apps/pages/transaksi_done.dart';
import 'package:food_delivery_apps/theme_manager/day_night.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_delivery_apps/pages/delivery_page.dart';
import 'package:food_delivery_apps/model/cart_model.dart';

class ImageProviderModel extends ChangeNotifier {
  XFile? _image;

  XFile? get image => _image;

  void pickImage() async {
    try {
      final picker = ImagePicker();
      XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        _image = pickedFile;
        notifyListeners();
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }
}

class AccountPage extends StatefulWidget {
  final String uid;

  const AccountPage({super.key, required this.uid});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late Future<UserModel?> _userFuture;
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _userFuture = UserModel.getUserFromFirestore(widget.uid);
  }

  Future<void> _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _toggleDarkMode() {
    Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              'Account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Provider.of<ThemeProvider>(context).themeMode ==
                          ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
                onPressed: _toggleDarkMode,
              ),
              IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: _handleLogout,
              ),
            ],
          ),
          body: Consumer<ImageProviderModel>(
            builder: (context, imageProvider, child) {
              return FutureBuilder<UserModel?>(
                future: _userFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}"));
                  } else if (!snapshot.hasData || snapshot.data == null) {
                    return const Center(
                      child: Text(
                        "User not found",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else {
                    return SingleChildScrollView(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  imageProvider.pickImage();
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 60,
                                      backgroundImage: imageProvider.image !=
                                              null
                                          ? FileImage(
                                              File(imageProvider.image!.path))
                                          : (snapshot.data?.profileImageUrl !=
                                                          null
                                                      ? NetworkImage(
                                                          snapshot.data!
                                                              .profileImageUrl!)
                                                      : const AssetImage(
                                                          'assets/default-avatar.png'))
                                                  as ImageProvider<Object>? ??
                                              const AssetImage(
                                                  'assets/default-avatar.png'),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      snapshot.data!.username ?? "N/A",
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //Card untuk email dan Location
                          Card(
                            margin: const EdgeInsets.all(16),
                            elevation: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.email,
                                          size: 20, color: Colors.blue),
                                      const SizedBox(width: 8),
                                      Text(
                                        'Email       :  ${snapshot.data!.email ?? "N/A"}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      const Icon(Icons.location_on,
                                          size: 20, color: Colors.green),
                                      const SizedBox(width: 7),
                                      Text(
                                        'Location  :  ${snapshot.data!.lokasi ?? "N/A"}',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '   Transaksi',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              Consumer<CartModel>(
                                builder: (context, value, child) {
                                  if (value.orderHistory.isEmpty) {
                                    // If there is no order history data, render an empty Card
                                    return Card(
                                      margin: EdgeInsets.all(20),
                                      elevation: 8,
                                      child: Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Center(
                                          child: Text(
                                            'Belum ada pesanan',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Card(
                                      margin: EdgeInsets.all(20),
                                      elevation: 8,
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Text(
                                                'Pesanan Sedang Dikirim',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                  'assets/design/images/delivery-1.png',
                                                  width: 70,
                                                  height: 100,
                                                ),
                                                SizedBox(
                                                  width: 250,
                                                  child:
                                                      LinearProgressIndicator(
                                                    backgroundColor:
                                                        Colors.grey,
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                            Color>(Colors.blue),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: value.orderHistory
                                                  .map<Widget>((item) {
                                                return ListTile(
                                                  title: Text(
                                                    '${item[0]} x${item[5]}',
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  // subtitle: Text(
                                                  //   'Rp. ${item[1]}',
                                                  //   style: const TextStyle(),
                                                  // ),
                                                );
                                              }).toList(),
                                            ),
                                            Center(
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  //untuk hapus ongoingdelivery yg ada di list
                                                  Provider.of<CartModel>(
                                                          context,
                                                          listen: false)
                                                      .clearOngoingDelivery();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TransaksiBerhasil(),
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  "Pesanan Diterima",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     Text(
                          //       '   Transaksi',
                          //       style: TextStyle(
                          //           fontSize: 20, fontWeight: FontWeight.bold),
                          //     ),
                          //     //SizedBox(height: 2),
                          //     Card(
                          //       margin: EdgeInsets.all(20),
                          //       elevation: 8,
                          //       child: Padding(
                          //         padding: EdgeInsets.all(5.0),
                          //         child: Column(
                          //           crossAxisAlignment:
                          //               CrossAxisAlignment.start,
                          //           children: [
                          //             Row(
                          //               mainAxisAlignment:
                          //                   MainAxisAlignment.spaceBetween,
                          //               children: [
                          //                 Image.asset(
                          //                   'assets/design/images/delivery-1.png', // Ganti dengan path gambar yang sesuai
                          //                   width: 50,
                          //                   height: 100,
                          //                 ),
                          //                 SizedBox(
                          //                   width: 250,
                          //                   child: LinearProgressIndicator(
                          //                     backgroundColor: Colors.grey,
                          //                     valueColor:
                          //                         AlwaysStoppedAnimation<Color>(
                          //                             Colors.blue),
                          //                   ),
                          //                 ),
                          //                 //SizedBox(height: 6),
                          //               ],
                          //             ),
                          //             Consumer<CartModel>(
                          //               builder: (context, value, child) {
                          //                 return Column(
                          //                   children: value.orderHistory
                          //                       .map<Widget>((item) {
                          //                     return ListTile(
                          //                       title: Text(
                          //                         '${value.orderHistory[index][0]} x${value.orderHistory[index][5]}',
                          //                         //item[0],
                          //                         style: const TextStyle(
                          //                           fontWeight: FontWeight.bold,
                          //                         ),
                          //                       ),
                          //                       subtitle: Text(
                          //                         'Rp. ${item[1]}', //  x ${item[3]}
                          //                         style: const TextStyle(),
                          //                       ),
                          //                     );
                          //                   }).toList(),
                          //                 );
                          //               },
                          //             ),
                          //             Center(
                          //               child: ElevatedButton(
                          //                 onPressed: () {
                          //                   //untuk hapus ongoingdelivery yg ada di list
                          //                   Provider.of<CartModel>(context,
                          //                           listen: false)
                          //                       .clearOngoingDelivery();
                          //                   Navigator.push(
                          //                       context,
                          //                       MaterialPageRoute(
                          //                         builder: (context) =>
                          //                             TransaksiBerhasil(),
                          //                       ));
                          //                 },
                          //                 child: Text(
                          //                   "Pesanan Diterima",
                          //                   style: TextStyle(
                          //                     color: Colors
                          //                         .white, // Set text color to white
                          //                   ),
                          //                 ),
                          //                 style: ElevatedButton.styleFrom(
                          //                   primary: Colors.blue,
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  }
                },
              );
            },
          ),
        ));
  }
}
