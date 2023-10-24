import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/models/screens/grocery_item_screen.dart';

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
          return Dismissible(
            // Se requiere el key para que Flutter localice y elimine el el widget del árbol de elementos
            key: Key(item.id),
            // Dirección en la que el usuario puede deslizar el dedo para eliminar este item
            direction: DismissDirection.endToStart,
            // Declarar el contenido del fondo, el cuál será visible cuando el usuario deslice el dedo
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete_forever,
                  color: Colors.white, size: 50.0),
            ),
            // Evento que se dispara cuando el usuario elimina un elemento mediante el widget Dissmisable()
            // Prácticamente cuando el usuario desliza el dedo
            onDismissed: (direction) {
              // Borrar el item seleccionado de la lista de ingredientes declarada en el estado global de la aplicación
              manager.deletedItem(index);
              // Mostrar un mensaje para notificar al usuario de que la acción fue atendida con éxito.
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} descartado')));
            },
            // InkWell(): proporciona una animación cuando el usuario toca el elemento
            // Envuelvo GroceryTile dentro de un widget detector de gestos InkWell
            child: InkWell(
              // Crear un GroceryItem con la información recuperada de cada elemento
              child: GroceryTile(
                key: Key(item.id),
                item: item,
                // Función que se debe ejecutar cuando se presiona el chkecbox
                onComplete: (change) {
                  // Actualizar el estado para este elemento cuando el checkbox cambie
                  manager.completeItem(index, change!);
                },
              ),
              // Cuando el gesto detecta un toque, presenta la pantalla de GroceryItemScreen con la información del ingrediente seleccionado para proceder a actualizarlo
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GroceryItemScreen(
                            originalItem: item,
                            // Callback que se ejecutará cuando el usuario grabe los nuevos cambios
                            onUpdate: (item) {
                              // Actualizar el ingrediente en el estado global de la aplicación
                              manager.updateItem(item, index);
                              // Cerrar la pantalla de GroceryItemScreen
                              Navigator.pop(context);
                            })));
              },
            ),
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
