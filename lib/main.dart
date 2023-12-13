import 'package:flutter/material.dart';
import 'package:food_delivery_apps/model/cart_model.dart';
import 'package:food_delivery_apps/pages/welcome_page.dart';
import 'package:food_delivery_apps/pages/home_page.dart';
import 'package:food_delivery_apps/pages/cart_page.dart';
import 'package:food_delivery_apps/pages/account_page.dart';
import 'package:food_delivery_apps/utils/theme_shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //     primarySwatch: Colors.cyan,
        //     primaryColor: secondaryColor,
        //     canvasColor: Colors.transparent),
        //home: WelcomePage(),
        home: WelcomePage(),
        routes: {
          '/login': (context) => WelcomePage(),
        },
        //home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    CartScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CartPage(),
    );
  }
}

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Assuming you are using Firebase Authentication
    User? user = FirebaseAuth.instance.currentUser;

    // Mendapatkan Data User dari Uid
    String uid = user?.uid ?? '';
    return Center(
      child: AccountPage(
        uid: uid,
      ),
    );
  }
}
