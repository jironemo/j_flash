import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatefulWidget {
  final int selectedIndex;
  const CustomNavigationDrawer({super.key, required this.selectedIndex});

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: _currentIndex,
      elevation: 2,
      children: [
        const ListTile(
          contentPadding: EdgeInsets.all(20),
          title: Text(
            'Navigation',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          tileColor: Colors.deepPurple,
        ),
        ListTile(
          leading: const Icon(Icons.home),
          textColor: _currentIndex == 1 ? Colors.white : Colors.black,
          tileColor: _currentIndex == 1 ? Colors.deepPurple : Colors.white,
          title: const Text('Home'),
          onTap: () {
            setState(() {
              _currentIndex = 1;
            });
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    );
  }
}
