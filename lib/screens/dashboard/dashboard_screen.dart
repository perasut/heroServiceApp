import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/bottomnav/booking_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/home_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/market_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/notification_screen.dart';
import 'package:heroServiceApp/screens/bottomnav/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 2;
  String _title = 'Hero Service';
  Widget _actionWidget;

  final List<Widget> _children = [
    MarketScreen(),
    BookingScreen(),
    HomeScreen(),
    NotificationScreen(),
    SettingScreen(),
  ];

  Widget _homeActionBar() {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/qrcode');
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [Icon(Icons.center_focus_strong), Text('Scan')],
        ),
      ),
    );
  }

  Widget _marketActionBar() {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(right: 15.0),
        child: Row(
          children: [Icon(Icons.add), Text('Add News')],
        ),
      ),
    );
  }

  // สร้างฟังก์ชันเพื่อใช้ในการเปลี่ยนหน้า
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;

      // เปลี่ยน title ไปตาม tab ที่เลือก
      switch (index) {
        case 0:
          _title = 'ตลาด';
          _actionWidget = _marketActionBar();
          ;
          break;
        case 1:
          _title = 'รายจอง';
          _actionWidget = Container();
          break;
        case 2:
          _title = 'บริการ';
          _actionWidget = _homeActionBar();
          break;
        case 3:
          _title = 'แจ้งเตือน';
          _actionWidget = Container();
          break;
        case 4:
          _title = 'อื่นๆ';
          _actionWidget = Container();
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _actionWidget = _homeActionBar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$_title'),
        actions: [_actionWidget],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     onTap: onTabTapped,
      //     currentIndex: _currentIndex,
      //     backgroundColor: Colors.teal,
      //     type: BottomNavigationBarType.fixed,
      //     items: [
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.business_center,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             'บริการ',
      //             style: TextStyle(color: Colors.white),
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.shopping_cart,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             'ตลาด',
      //             style: TextStyle(color: Colors.white),
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.library_books,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             'รายการจอง',
      //             style: TextStyle(color: Colors.white),
      //           )),
      //       BottomNavigationBarItem(
      //           icon: Icon(
      //             Icons.menu,
      //             color: Colors.white,
      //           ),
      //           title: Text(
      //             'อื่นๆ',
      //             style: TextStyle(color: Colors.white),
      //           )),
      //     ]),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.teal,
        buttonBackgroundColor: Colors.teal,
        height: 60,
        animationDuration: Duration(milliseconds: 200),
        index: 2,
        animationCurve: Curves.bounceInOut,
        items: [
          Icon(
            Icons.shopping_basket,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.library_books,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.business_center,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.notifications,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.menu,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: onTabTapped,
      ),
      body: _children[_currentIndex],
    );
  }
}
