import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';

class GroceryListScreen extends StatelessWidget {
  // Requiere el Manejador de estado referente a las recetas, para mostrar el listado de las mismas
  final GroceryManager manager;
  const GroceryListScreen({super.key, required this.manager});

  @override
  Widget build(BuildContext context) {
    // Obtnener la lista de ingredientes mostribles desde el estado global de la aplicación
    final groceryItems = manager.groceryItems;
    return Padding(
      padding: const EdgeInsets.all(16),
      // Agregar una lista separada para mostrar los ingredientes almacenados en el estado
      child: ListView.separated(
        // Obtener el número de ingredientes en la lista
        itemCount: groceryItems.length,
        itemBuilder: (context, index) {
          // Para cada elemento en la lista, obtnener su información
          final item = groceryItems[index];
          // Disimissable
          // InkWell
          // Crear un GroceryItem con la información recuperada de cada elemento
          return GroceryTile(
            key: Key(item.id),
            item: item,
            // Función que se debe ejecutar cuando se presiona el chkecbox
            onComplete: (change) {
              // Actualizar el estado para este elemento cuando el checkbox cambie
              manager.completeItem(index, change!);
            },
          );
        },
        // Separar cada ingrediente comestible con 16px de distancia
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16.0,
          );
        },
      ),
    );
  }
}
