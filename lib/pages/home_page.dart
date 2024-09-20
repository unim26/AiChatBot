import 'package:aichatbot/pages/chat_page.dart';
import 'package:aichatbot/pages/info_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentindex = 0;
  List pages = [
    ChatPage(),
    InfoPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[currentindex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 30,
                ),
                label: "HOME"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.info,
                  size: 30,
                ),
                label: "INFO"),
          ],
          currentIndex: currentindex,
          onTap: (value) {
            currentindex = value;
            setState(() {});
          },
          showSelectedLabels: true,
          showUnselectedLabels: false,
        ),
      ),
    );
  }
}
