import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/screens/empty_grocery_screen.dart';
import 'package:provider/provider.dart';

class GroceryScreen extends StatelessWidget {
  const GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Se usa un Scaffold ya que esta vista necesita mostrar un boton de acción flotante
    return Scaffold(
      // Mostrar una de las dos pantallas con base al estado consumido
      body: buidGroceyScreen(),
      floatingActionButton: FloatingActionButton(
        // Al presionar el boton se mostrará la pantalla para crear un nuevo elemento
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  // Método auciliar que decide que widget construir con base a la información que se tiene en el estado referente a la lista de alimentos
  Widget buidGroceyScreen() {
    // Declarar un Consumidor y envolver el árbol de widgets que consumiran el estado
    // Cuando GroceryManager cambie (lista de alimentos), los widgets debajo de este consumidor se reconstruiran
    return Consumer<GroceryManager>(builder: (context, manager, child) {
      if (manager.groceryItems.isNotEmpty) {
        // Mostrar la pantalla con la lista de alimentos
        return Container();
      } else {
        // Mostrar la pantalla cuando no existen elementos agregados a la lista de alimentos
        return const EmptyGroceryScreen();
      }
    });
  }
}
