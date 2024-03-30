import 'package:flutter/material.dart';
import 'package:movies_app/pages/browse/browse.dart';
import 'package:movies_app/pages/home/home_view.dart';
import 'package:movies_app/pages/search/search.dart';
import 'package:movies_app/pages/watch_list/WatchList.dart';





class HomePage extends StatefulWidget {
  static const String routeName = "Homepage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        // currentIndex: currentPage.index,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1A1A1A),
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1A1A1A),
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1A1A1A),
            icon: Icon(Icons.movie),
            label: 'Browse',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xFF1A1A1A),
            icon: Icon(Icons.bookmark),
            label: 'Watchlist',
          ),
        ],
      ),
      body: tabs[selectedIndex],
    );
  }

  List<Widget> tabs = [HomeTab(), Search(), Browse(), WatchList()];
}
