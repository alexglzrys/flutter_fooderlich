import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/screens/explore_screen.dart';
import 'package:fooderlich/models/screens/grocery_screen.dart';
import 'package:fooderlich/models/screens/recipes_screen.dart';
import 'package:provider/provider.dart';

// Separar los widgets complejos en archivos independientes, mejora la lectura del código de nuestra aplicación
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Definir estado de esta página
  // int _selectedIndex = 0; // representa el tab (bottomNavigationBar) actualmente seleccionado

  // Listado de páginas a mostrar dependiendo del elemento seleccionado en la barra inferior de navegación
  static List<Widget> pages = [
    // Pantalla de Exploración
    const ExploreScreen(),
    RecipesScreen(),
    const GroceryScreen()
  ];

  // método privado (controlador) para conocer que elemento de la barra de navegación inferior ha sido tocado
  /* void _onItemTapped(int index) {
    // Notificar a flutter que el estado de esta pantalla ha cambiado para que lo vuelva a reconstruir y en consecuencia muestre el nuevo contenido (página seleccionada)
    setState(() {
      _selectedIndex = index;
    });
  } */

  @override
  Widget build(BuildContext context) {
    // Declarar un Consumidor y envolver el árbol de widgets que consumiran el estado
    // Cuando TabManager cambie, los widgets debajo de este consumidor se reconstruiran
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      // Existen 3 catagorias principales de widgets: Estructura y Navegación, Mostrar información, y Posicionamiento

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
        // body: pages[_selectedIndex],

        // Muestra el widget correcto con base al índice de la pestaña actualmente seleccionada
        // La información se consume desde el estado que ofrece el Proveedor
        body: pages[tabManager.selectedTab],
        // Agregar barra de navegación inferior
        bottomNavigationBar: BottomNavigationBar(
            // Establecer el color cuando un elemento de navegación está seleccionado
            selectedItemColor:
                Theme.of(context).textSelectionTheme.selectionColor,
            // indica a la barra de navegación inferior que elemento o pestaña resaltar
            // currentIndex: _selectedIndex,

            currentIndex: tabManager.selectedTab,
            // llama al método de controlador asociado, que se encarga de actualizar el estado con el índice seleccionado
            // onTap: _onItemTapped,

            onTap: (index) {
              // Llama a goToTab(indice) cuando el usuario toca una pestaña diferente a la actual
              // esto modifica el estado y notifica a otros widgets que el índice cambió
              tabManager.goToTab(index);
            },
            // Elementos de la barra de navegación
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.explore), label: 'Explorar'),
              BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Recetas'),
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Comprar')
            ]),
      );
    });
  }
}
