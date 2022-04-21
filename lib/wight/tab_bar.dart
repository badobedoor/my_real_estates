import 'package:flutter/material.dart';
import 'package:my_real_estates/wight/appWight&Theme/theme.dart';
import 'package:provider/provider.dart';

import '../Provider/main_provider.dart';
import '../screens/home.dart';
import '../screens/rent_order_page.dart';
import 'dilog/Privacy_dilog.dart';

class TabBarHomePage extends StatefulWidget {
  @override
  _TabBarHomePageState createState() => _TabBarHomePageState();
}

class _TabBarHomePageState extends State<TabBarHomePage> {
  int _currentIndex = 2;
  final List<Widget> _pages = <Widget>[];
  @override
  void initState() {
    _pages.add(HomeScreen());
    _pages.add(SettingScreen());
    _pages.add(Home());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('BottomNavigationBar')),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        color: AppColors.darkblue,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8.0,
          clipBehavior: Clip.antiAlias,
          child: Container(
            height: kBottomNavigationBarHeight,
            // color: Colors.orange,
            child: Container(
              child: BottomNavigationBar(
                  currentIndex: _currentIndex,
                  backgroundColor: Colors.blue,
                  selectedItemColor: Colors.white,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_work), label: 'إيجار'),
                    BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.real_estate_agent), label: 'بيع')
                  ]),
            ),
          ),
        ),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,

      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0), //Padding
        child: FloatingActionButton(
            backgroundColor: Color(0xff6E52FC),
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    colors: [Color(0xff52A0F8), Color(0xff6E52FC)],
                    stops: [0.0, 1.0],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    tileMode: TileMode.repeated),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 40,
                color: AppColors.white,
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RentOrder()));
              // final fristTimeprivacy =
              //     Provider.of<MainProvider>(context, listen: false)
              //         .fristTimeprivacy;
              // if (fristTimeprivacy == true) {
              //   privacyDialog(context: context);
              // } else {
              //   Provider.of<MainProvider>(context, listen: false)
              //       .changesellansRentOrderShowBTN(true);
            }),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Home')),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Category')),
    );
  }
}

class SettingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(child: Text('Settings')),
    );
  }
}
