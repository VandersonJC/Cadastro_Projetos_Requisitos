import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: HomePageDinamic(),
    );
  }
}

class HomePageDinamic extends StatefulWidget {
  const HomePageDinamic({Key? key}) : super(key: key);

  @override
  State<HomePageDinamic> createState() => _HomePageDinamic();
}

class _HomePageDinamic extends State<HomePageDinamic>
{
    final _selectedIndex = 0;
    
    static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      appBar: AppBar(
        title: Text('MyApp'),
      ),
      body: Container(),
      bottomNavigationBar: BottomNavigationBar(
        items: 
        const <BottomNavigationBarItem> 
        [ 
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dock_sharp),
            label: 'Projetos',
            backgroundColor: Colors.purple,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.usb_rounded),
            label: 'Usuários',
            backgroundColor: Colors.purple,
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Colors.white,
        // onTap: _onItemTapped,
      ),
    );
  }
}