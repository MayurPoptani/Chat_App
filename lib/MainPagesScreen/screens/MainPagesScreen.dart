import 'package:chat_app/ChatListScreen/screens/ChatListScreen.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MainPagesScreen extends StatefulWidget {
  @override
  _MainPagesScreenState createState() => _MainPagesScreenState();
}

class _MainPagesScreenState extends State<MainPagesScreen> {
  
  int _pageIndex = 1;
  PageController _pageController;
  
  @override
  void initState() {
    _pageController = PageController(initialPage: _pageIndex, keepPage: true);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: PageView(
        controller: _pageController,
        children: [
          Container(child: "Page 1. Dummy".text.makeCentered(),),
          ChatListScreen(key: PageStorageKey("ChatListScreen-Key"),),
          Container(child: "Page3. Dummy".text.makeCentered(),),
          Container(child: "Page 4. Dummy".text.makeCentered(),),
        ],
        allowImplicitScrolling: false,
        pageSnapping: true,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: bottomNavBar(),
    );
  }
  
  Widget appBar() {
    return AppBar(
      title: "Chat App".text.make(),
      centerTitle: true,
      actions: [
        Builder(
          builder: (_) => IconButton(icon: Icon(Icons.menu), onPressed: () {
            Scaffold.of(_).showSnackBar(SnackBar(content: "Dummy Menu Button".text.make(), behavior: SnackBarBehavior.floating, duration: Duration(milliseconds: 1000),));
          })
        ),
      ],
    );
  }
  
  Widget bottomNavBar() {
    return BottomNavigationBar(
      elevation: 4,
      backgroundColor: Theme.of(context).appBarTheme.color,
      currentIndex: _pageIndex,
      selectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: [
        getBottomNavItem(Icons.device_hub, "Network"),
        getBottomNavItem(Icons.message, "Messages"),
        getBottomNavItem(Icons.contacts, "Contacts"),
        getBottomNavItem(Icons.library_books, "Library"),
      ],
      onTap: (index) async {
        _pageIndex = index;
        if(mounted) _pageController.animateToPage(_pageIndex, duration: Duration(milliseconds: 150), curve: Curves.ease).then((value) {
          if(mounted) setState(() {});
        });  
      },
    );
  }
  
  BottomNavigationBarItem getBottomNavItem(IconData iconData, String label) {
    return BottomNavigationBarItem(
      title: label.text.size(12).make(),
      icon: Icon(iconData),
      activeIcon: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Icon(iconData),
          ),
          Positioned(
            top: 0, right: 0,
            child: Container(
              height: 10, width: 10, 
              decoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      )
    );
  }
}