import 'package:flutter/material.dart';

// Separar los widgets complejos en archivos independientes, mejora la lectura del código de nuestra aplicación
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Definir estado de esta página
  int _selectedIndex =
      0; // representa el tab (bottomNavigationBar) actualmente seleccionado

  // Listado de páginas a mostrar dependiendo del elemento seleccionado en la barra inferior de navegación
  static List<Widget> pages = [
    Container(color: Colors.red),
    Container(color: Colors.green),
    Container(color: Colors.blue)
  ];

  // método privado (controlador) para conocer que elemento de la barra de navegación inferior ha sido tocado
  void _onItemTapped(int index) {
    // Notificar a flutter que el estado de esta pantalla ha cambiado para que lo vuelva a reconstruir y en consecuencia muestre el nuevo contenido (página seleccionada)
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold es uno de los widget mas usados en Fluuter, que se encarga de definir el diseño y estructura de la aplicación
    // puede esta compuesto por: BottomSheet, BottomNavigationBar, Drawer, FloatingActionButton, SnackBar para la navegación
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          // agregar estilo declarado en el tema a los widgets de la aplicación
          // Theme.of(context) devuelve el tema más cercano declarado en el árbol de widgets. Si el widget tiene un tema definido, lo devuelve. De lo contrario, devuelve el tema de la aplicación
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      // Muestra el widget (relacionado por su posicion) para el elemento de la barra de navegación seleccionado
      body: pages[_selectedIndex],
      // Agregar barra de navegación inferior
      bottomNavigationBar: BottomNavigationBar(
          // Establecer el color cuando un elemento de navegación está seleccionado
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          // indica a la barra de navegación inferior que elemento o pestaña resaltar
          currentIndex: _selectedIndex,
          // llama al método de controlador asociado, que se encarga de actualizar el estado con el índice seleccionado
          onTap: _onItemTapped,
          // Elementos de la barra de navegación
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card 2'),
            BottomNavigationBarItem(
                icon: Icon(Icons.card_giftcard), label: 'Card 3')
          ]),
    );
  }
}
