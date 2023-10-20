import 'package:flutter/painting.dart';

// Enumeración para etiquetar la importancia de un elemento en el TO-DO de productos comestibles
enum Importance { low, medium, hihg }

class GroceryItem {
  late final String id;
  late final String name;
  late final Importance importance;
  late final Color color;
  late final int quatity;
  late final DateTime date;
  late final bool isComplete;

  // Un usuario puede crear un producto comestible a partir del nombre, nivel de importancia, color, cantidad, fecha de compra. Así como marcar los productos completados
  GroceryItem(
      {required this.id,
      required this.name,
      required this.importance,
      required this.color,
      required this.quatity,
      required this.date,
      this.isComplete = false});

  // Este método copia y crea una nueva instancia de producto comestible a partir de uno existente
  // Es de utilidad cuando se gestione el estado de los elementos
  GroceryItem copyWith(
      {required String id,
      required String name,
      required Importance importance,
      required Color color,
      required int quantity,
      required DateTime date,
      bool? isComplete}) {
    return GroceryItem(
        id: id,
        name: name,
        importance: importance,
        color: color,
        quatity: quatity,
        date: date);
  }
}
