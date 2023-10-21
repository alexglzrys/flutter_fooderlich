import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

// Clase que maneja el estado para administrar la lista de alimentos o ingredientes

// GroceryManager extiende de ChangeNotifier.
// Esto permite que el objeto de esta clase proporcione notificaciones de cambios a sus oyentes
class GroceryManager extends ChangeNotifier {
  // Lista privada de elementos de tipo GroceryItem
  final _groceryItems = <GroceryItem>[];

  // Geeter para obtener una lista no mutable de elementos de tipo GroceryItem
  List<GroceryItem> get groceryItems => List.unmodifiable(_groceryItems);

  // Metodo para eliminar un elemento de la lista
  void deletedItem(int index) {
    _groceryItems.removeAt(index);
    // Notificar a los widgets que el estado a cambiado para que se vuelvan a redibujar
    notifyListeners();
  }

  // Método para agregar un nuevo elemento al final de la lista
  void addItem(GroceryItem item) {
    _groceryItems.add(item);
    notifyListeners();
  }

  // Método para actualizar un elemento basado en su posición en la lista
  void updateItem(GroceryItem item, int index) {
    _groceryItems[index] = item;
    notifyListeners();
  }

  // Método para completar o no completar un elemento dela lista
  void completeItem(int index, bool change) {
    final item = _groceryItems[index];
    _groceryItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}
