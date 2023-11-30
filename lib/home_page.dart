import 'package:flutter/material.dart';
import 'package:flutter_application_2/item_page.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //bungkus jadi di tengah
              Container(
                padding: EdgeInsets.fromLTRB(24, 49, 0, 0),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      width: 327,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(3.5, 0, 0, 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  // iconlyboldlocationxim (2:101)
                                  margin: EdgeInsets.fromLTRB(0, 0, 11.5, 0),
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
                          )
                        ],
                      ),
                    ),
                    Container(
                      //Container Search Engine

                      margin: EdgeInsets.fromLTRB(0, 0, 24, 32),
                      width: double.infinity,
                      height: 48,
                      child: Card(
                        //elevation: 3,
                        shadowColor: Colors.black,
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              labelText: "Search",
                              suffixIcon: Icon(Icons.search),
                              contentPadding: EdgeInsets.only(left: 20)),
                        ),
                      ),
                      // Row di sini bekas yang tidak bisa input decoration
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      // Card(
                      //   elevation: 3,
                      //   shadowColor: Colors.red,
                      //   margin: EdgeInsets.symmetric(horizontal: 140),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(15),
                      //   ),
                      // ),
                      // Container(
                      //     margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                      //     padding:
                      //         EdgeInsets.fromLTRB(14.78, 13.5, 150, 12.5),
                      //     height: double.infinity,
                      //     decoration: BoxDecoration(
                      //       border: Border.all(color: Color(0xffe6e6e6)),
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     child: TextFormField(
                      //       decoration: InputDecoration(
                      //           border: InputBorder.none,
                      //           suffixIcon: Icon(Icons.search),
                      //           contentPadding: EdgeInsets.only(left: 20)),
                      //     )
                      // Row(
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      // TextFormField(
                      //   decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       suffixIcon: Icon(Icons.search),
                      //       contentPadding:
                      //           EdgeInsets.only(left: 20)),
                      // ),
                      // SizedBox(
                      //   width: 18.76,
                      //   height: 19.22,
                      //   child: Image.asset(
                      //     'assets/design/images/iconly-light-search.png',
                      //   ),
                      // ),
                      // TextField(
                      //   decoration: InputDecoration(
                      //     prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.search,color: Colors.black,),),) ),
                      // )
                      // Text(
                      //   //Text Serach
                      //   'Search',
                      //   style: SafeGoogleFont('Roboto',
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w400,
                      //       height: 1.1725,
                      //       color: Color(0xffcccccc)),
                      // )
                      //   ],
                      // ),
                      // ),
                      // Container(
                      //   width: 48,
                      //   height: 48,
                      //   child: Image.asset(
                      //     'assets/design/images/frame-4.png',
                      //     width: 48,
                      //     height: 48,
                      //   ),
                      // )
                      //],
                      // ),
                    ),
                    Container(
                      child: ItemPage(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
