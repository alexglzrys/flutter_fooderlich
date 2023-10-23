import 'package:flutter/painting.dart';

// Enumeración para etiquetar la importancia de un elemento en el TO-DO de productos comestibles
enum Importance { low, medium, hihg }

class GroceryItem {
  late final String? id;
  late final String name;
  late final Importance importance;
  late final Color color;
  late final int quantity;
  late final DateTime date;
  late final bool isComplete;

  // Un usuario puede crear un producto comestible a partir del nombre, nivel de importancia, color, cantidad, fecha de compra. Así como marcar los productos completados
  GroceryItem(
      {this.id,
      required this.name,
      required this.importance,
      required this.color,
      required this.quantity,
      required this.date,
      this.isComplete = false});

  // Este método copia y crea una nueva instancia de producto comestible a partir de uno existente
  // Es de utilidad cuando se gestione el estado de los elementos
  GroceryItem copyWith(
      {String? id,
      String? name,
      Importance? importance,
      Color? color,
      int? quantity,
      DateTime? date,
      bool? isComplete}) {
    return GroceryItem(
        id: id ?? this.id,
        name: name ?? this.name,
        importance: importance ?? this.importance,
        color: color ?? this.color,
        quantity: quantity ?? this.quantity,
        date: date ?? this.date,
        isComplete: isComplete ?? this.isComplete);
  }
}
