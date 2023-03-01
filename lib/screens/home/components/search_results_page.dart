import 'package:bookshop/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class SearchResultsPage extends StatefulWidget {
  final String searchQuery;

  const SearchResultsPage({Key? key, required this.searchQuery}) : super(key: key);

  @override
  _SearchResultsPageState createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Icon(Icons.arrow_back_ios_new, color: Colors.black,
            )
        ),

      title: Text('Search Results', style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text('Search query: ${widget.searchQuery}', style: TextStyle(color: Colors.black),),
      ),
    );
  }
}