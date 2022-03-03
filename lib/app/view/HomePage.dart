import 'package:cadastro_projeto_requerimento/app/control/ProjectForm.dart';
import 'package:cadastro_projeto_requerimento/app/view/ProjectsList.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return HomePageDinamic();
  }
}

class HomePageDinamic extends StatefulWidget {
  const HomePageDinamic({Key? key}) : super(key: key);

  @override
  State<HomePageDinamic> createState() => _HomePageDinamic();
}

class _HomePageDinamic extends State<HomePageDinamic> {
  String _text = 'teste';
  /*int _selectedIndex = 0;
    PageController pageController = PageController();
    
    void opTapped(int index)
    {
      setState(() 
      {
        _selectedIndex = index;  
      });
      pageController.jumpToPage(index);
    }
*/
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de projetos'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Projetos'),
            leading: Icon(Icons.note_add_outlined),
          ),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectForm(),
                    ),
                  );
                },
                child: const Text('Cadastrar'),
              )),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProjectList(),
                    ),
                  );
                },
                child: const Text('Listar'),
              )),
          new Divider(),
          ListTile(
            title: Text('Usuários'),
            leading: Icon(Icons.group_add),
          ),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  return null;
                },
                child: const Text('Cadastrar'),
              )),
          Padding(
              padding: const EdgeInsets.all(5.0),
              child: ElevatedButton(
                onPressed: () {
                  return null;
                },
                child: const Text('Listar'),
              )),
        ],
      ),
    );
  }
}



/*
PageView(
        controller: pageController,
        children: 
        [
          Container(),
          Container(),
          Container()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: 
        const <BottomNavigationBarItem> 
        [ 
          BottomNavigationBarItem( icon: Icon(Icons.home), label: 'Home', ),
          BottomNavigationBarItem( icon: Icon(Icons.dock_sharp), label: 'Projetos', ),
          BottomNavigationBarItem( icon: Icon(Icons.usb_rounded), label: 'Usuários', ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: opTapped,
        // selectedItemColor: Colors.white,
        // onTap: _onItemTapped,
      ),
    */