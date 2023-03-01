import 'package:bookshop/screens/cart/cart.dart';
import 'package:bookshop/screens/favorites/favorites.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../models/Product.dart';
import '../login_register/login_screen.dart';
import '../profile/profile_screen.dart';
import 'components/new_arrival_products.dart';
import 'components/popular_products.dart';
import 'components/search_form.dart';
import 'components/search_results_page.dart';

class HomeScreen extends StatefulWidget {
   const HomeScreen({Key? key}) : super(key: key);




  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  String _searchQuery = '';

  int _selectedIndex = 0;

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: SvgPicture.asset("assets/icons/menu.svg"),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/Location.svg"),
            const SizedBox(width: defaultPadding / 2),
            Text(
              "15/2 New Texas",
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1,
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/profile.svg"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/menu.png"),
                  fit: BoxFit.scaleDown,
                ),
              ),
              child: Center(
                child: Text(
                  'Book Shop',
                  style: TextStyle(
                    color: Color.fromRGBO(241, 163, 128, 1.0),
                    fontSize: 30,
                    height: 5,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
                color: _selectedIndex == 0
                    ? Color.fromRGBO(232, 128, 80, 1.0)
                    : Colors.black,
              ),
              title: Text(
                'Home',
                style: TextStyle(
                  color: _selectedIndex == 0
                      ? Color.fromRGBO(232, 128, 80, 1.0)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.favorite_border_outlined,
                color: _selectedIndex == 1
                    ? Color.fromRGBO(232, 128, 80, 1.0)
                    : Colors.black,
              ),
              title: Text(
                'Favorites',
                style: TextStyle(
                  color: _selectedIndex == 1
                      ? Color.fromRGBO(232, 128, 80, 1.0)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.shopping_cart,
                color: _selectedIndex == 2
                    ? Color.fromRGBO(232, 128, 80, 1.0)
                    : Colors.black,
              ),
              title: Text(
                'Your Cart',
                style: TextStyle(
                  color: _selectedIndex == 2
                      ? Color.fromRGBO(232, 128, 80, 1.0)
                      : Colors.black,
                ),
              ),
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(cartItems:[]),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(
                  Icons.logout,
                  color: Color.fromRGBO(248, 12, 12, 1.0)
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.black ),

              ),
              onTap: () async {
                bool confirmLogout = await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to logout?'),
                    actions: [
                      TextButton(
                        child: Text('No'),
                        onPressed: () => Navigator.pop(context, false),
                      ),
                      TextButton(
                        child: Text('Yes'),
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ],
                  ),
                );

                if (confirmLogout == true) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }
              },
            )

          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Explore",
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
            ),
            const Text(
              "Best Books for you",
              style: TextStyle(fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: SearchForm(onSubmitted: (query) {
                setState(() {
                  _searchQuery = query;
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SearchResultsPage(searchQuery: _searchQuery,),
                  ),
                );
              }),
            ),


            const NewArrivalProducts(),
            const PopularProducts(),
          ],
        ),
      ),
    );
  }
}