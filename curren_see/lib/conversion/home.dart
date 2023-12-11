import 'package:curren_see/pages/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curren_see/conversion/anyToAny.dart';
import 'package:curren_see/conversion/fetchrates.dart';
import 'package:curren_see/conversion/ratesmodel.dart';
import 'package:curren_see/pages/currency_news.dart';
import 'package:curren_see/pages/feedback.dart';
import 'package:curren_see/pages/rate_alerts.dart';
import 'package:curren_see/pages/user_support.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late User user;
  final AppTheme appTheme = AppTheme();

  // Initial Variables
  late Future<RatesModel> result;
  late Future<Map> allcurrencies;
  final formkey = GlobalKey<FormState>();

  // Getting RatesModel and All Currencies
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!;
    setState(() {
      result = fetchrates();
      allcurrencies = fetchcurrencies();
    });
    appTheme.addListener((){
      setState(() {});
    });
  }

  // Drawer Items
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [

          // User Account Drawer Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            accountName: const Text(''),
            accountEmail: Text(user.email!),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white60,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.white,
              ),
            ),
          ),

          // Drawer Items
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: const Text('Currency News & Market Trends'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CurrencyNews()));
                  },
                ),
                ListTile(
                  title: const Text('User Support'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const UserSupport()));
                  },
                ),
                ListTile(
                  title: const Text('Feedback'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage()));
                  },
                ),
                ListTile(
                  title: const Text('Rate Alerts'),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RateAlerts()));
                  },
                ),
              ],
            ),
          ),

          // Logout ListTile at the bottom
          ListTile(
            title: const Text('Logout'),
            leading: const Icon(Icons.logout),
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('C U R R E N S E E'),
        actions: [
          IconButton(
            onPressed: () {
              appTheme.toggleTheme();
            },
            icon: const Icon(Icons.brightness_4),
          )
        ],
      ),
      // Drawer added here
      drawer: _buildDrawer(context),
      // Future Builder for Getting Exchange Rates
      body: Container(
        height: h,
        width: w,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/currency.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: FutureBuilder<RatesModel>(
              future: result,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Center(
                  child: FutureBuilder<Map>(
                    future: allcurrencies,
                    builder: (context, currSnapshot) {
                      if (currSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnyToAny(
                            currencies: currSnapshot.data!,
                            rates: snapshot.data!.rates,
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}