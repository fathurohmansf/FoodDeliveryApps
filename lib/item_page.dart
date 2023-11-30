import 'package:flutter/material.dart';
import 'package:flutter_application_2/on_cart_screen.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/utils.dart';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_application_2/models/menu_model.dart';
import 'package:http/http.dart' as myHttp;
import 'package:flutter_application_2/providers/cart_provider.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class ItemPage extends StatefulWidget {
  const ItemPage({super.key});

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  final String urlMenu =
      "https://script.googleusercontent.com/macros/echo?user_content_key=ke2k-oXsBSF3KRTnkKK6mcPik0VdtXnr9wpS3axFg_Q4xpNhtWgurS-8LVYCw0nfMllyIe_YK98vH-vIzDc4ABTQ8Vd-u-u0m5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnB2yf1caul0kBQMAKnK-ZAECvpfw8IG3s3SZk9Toe_2jyQWEn2eUSi6etOAxzD-nDIioPAsSULVUTSklVDsQHfTqoqBhwpndt9z9Jw9Md8uu&lib=MywVpY5CCjg0nEI8sIh6wSu7LeYFeyUzg";

  Future<List<MenuModel>> getAllData() async {
    List<MenuModel> listMenu = [];
    var response = await myHttp.get(Uri.parse(urlMenu));
    List data = json.decode(response.body);

    data.forEach((element) {
      listMenu.add(MenuModel.fromJson(element));
    });

    return listMenu;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        child: badges.Badge(
          badgeContent: Consumer<CartProvider>(
            builder: (context, value, _) {
              return Text(
                (value.total > 0) ? value.total.toString() : "",
                style: GoogleFonts.montserrat(color: Colors.white),
              );
            },
          ),
          child: Icon(Icons.shopping_bag),
        ),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 11.5, 2),
                width: 17,
                height: 20,
                child: Image.asset(
                    'assets/design/images/iconly-bold-location.png'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 11.33, 0),
                child: Text(
                  'Depok, Indonesia',
                  style: SafeGoogleFont(
                    'Roboto',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.1725,
                    color: Color(0xff0c0c0c),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 11.5, 0),
                width: 17,
                height: 20,
                child: Image.asset(
                    'assets/design/images/iconly-light-arrow-down-2-pcZ.png'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 4.69, 4.69, 0),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    //buat box untuk order your food
                    margin: EdgeInsets.fromLTRB(0, 0, 26.13, 0),
                    constraints: BoxConstraints(
                      maxWidth: 204,
                    ),
                    child: Text(
                      'Order Your Food\nFast And Free',
                      style: SafeGoogleFont('Roboto',
                          fontSize: 27,
                          fontWeight: FontWeight.w500,
                          height: 1.1725,
                          color: Color(0xff0c0c0c)),
                    ),
                  ),
                ),
                Container(
                  //Foto delivery
                  width: 92.19,
                  height: 90.63,
                  child: Image.asset(
                    'assets/design/images/delivery-1.png',
                    width: 7,
                    height: 2,
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 50),
          Container(
            //text categori
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: Text(
              'Categories',
              style: SafeGoogleFont(
                'Roboto',
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.1725,
                color: Color.fromARGB(255, 100, 68, 68),
              ),
            ),
          ),
          Container(
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xffff9431),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                '🍔 Burger',
              ),
            ),
          ),
          // Container(
          //   height: double.infinity,
          //   decoration: BoxDecoration(
          //       color: Color(0xffff9431),
          //       borderRadius: BorderRadius.circular(10)),
          //   child: Text(
          //     '🍔',
          //     style: SafeGoogleFont('DM Sans',
          //         fontSize: 24,
          //         fontWeight: FontWeight.w700,
          //         height: 1.1,
          //         letterSpacing: -0.72,
          //         color: Color(0xff000000)),
          //   ),
          // ),
          //SizedBox(width: 50),
          FutureBuilder(
              future: getAllData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            MenuModel menu = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(menu.image)),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          menu.name,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          menu.description,
                                          textAlign: TextAlign.left,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 13),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Rp. " + menu.price.toString(),
                                              style: GoogleFonts.montserrat(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .addRemove(
                                                              menu.id, false);
                                                    },
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Consumer<CartProvider>(
                                                  builder: (context, value, _) {
                                                    var id = value.cart
                                                        .indexWhere((element) =>
                                                            element.menuId ==
                                                            snapshot
                                                                .data![index]
                                                                .id);
                                                    return Text(
                                                      (id == -1)
                                                          ? "0"
                                                          : value
                                                              .cart[id].quantity
                                                              .toString(),
                                                      textAlign: TextAlign.left,
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 15),
                                                    );
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Provider.of<CartProvider>(
                                                              context,
                                                              listen: false)
                                                          .addRemove(
                                                              menu.id, true);
                                                    },
                                                    icon: Icon(
                                                      Icons.add_circle,
                                                      color: Colors.green,
                                                    )),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Text("Tidak ada data"),
                    );
                  }
                }
              }),
        ],
      )),
    );
  }
}
