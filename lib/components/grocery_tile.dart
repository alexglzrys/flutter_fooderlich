import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// Widget para mostrar un mosaico o vista previa de producto comestible
class GroceryTile extends StatelessWidget {
  // Propiedades que necesita es widget para poder funcionar

  // La información del producto comestible que se está creando o editando
  final GroceryItem item;
  // Un Callback que permite saber si el usuario activó o desactivó la casilla de verificación
  final Function(bool?)? onComplete;
  // Helper que permite decorar los textos mostrados en este widget con base a si el producto esta o no completado
  final TextDecoration textDecoration;

  // Cuando se inicializa este widget (Mosaico o vista previa de comestible) verifica si el producto esta completado o no
  // En caso afirmativo, muestra una tachadura en el texto, caso contrario, muestra los textos de manera normal
  GroceryTile({
    super.key,
    required this.item,
    this.onComplete,
  }) : textDecoration =
            item.isComplete ? TextDecoration.lineThrough : TextDecoration.none;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Fila 1 - Agrupa la vista previa de color y una columna que contiene el nombre, fecha e importancia
          Row(
            children: [
              // Widget para mostrar la vista previa de color
              Container(width: 5.0, color: item.color),
              const SizedBox(width: 16.0),
              // Widget para mostrar en sentido vertical elementos como: Nombre del ingrediente, Fecha, e importancia
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.lato(
                        decoration: textDecoration,
                        fontSize: 21.0,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4.0),
                  buildDate(),
                  const SizedBox(height: 4.0),
                  buildImportance()
                ],
              )
            ],
          ),
          // Fila 2 - Agrupa la cantidad y el checkbox para marcar el producto comestible como completado o no completado
          Row(
            children: [
              // Texto para mostrar la cantidad de este ingrediente
              Text(
                item.quantity.toString(),
                style: GoogleFonts.lato(
                    decoration: textDecoration, fontSize: 21.0),
              ),
              // Widget que retorna un chkecbox para marcar como completado o no completado
              buildCheckBox()
            ],
          )
        ],
      ),
    );
  }

  // Método auxiliar que retorna un widget con base al nivel de importancia seleccionado por el usuario
  Widget buildImportance() {
    if (item.importance == Importance.low) {
      return Text(
        'Baja',
        style: GoogleFonts.lato(decoration: textDecoration),
      );
    } else if (item.importance == Importance.medium) {
      return Text(
        'Media',
        style: GoogleFonts.lato(
            decoration: textDecoration, fontWeight: FontWeight.w800),
      );
    } else if (item.importance == Importance.hihg) {
      return Text(
        'Alta',
        style: GoogleFonts.lato(
            decoration: textDecoration, fontWeight: FontWeight.w900),
      );
    } else {
      throw Exception('Este tipo de importancia no existe');
    }
  }

  // Método auxiliar que retorna un widget con el formato de fecha correcto seleccionado por el usuario
  Widget buildDate() {
    final dateFormatter = DateFormat('MMMM dd h:mm a');
    final dateString = dateFormatter.format(item.date);
    return Text(
      dateString,
      style: TextStyle(decoration: textDecoration),
    );
  }

  // Método auxiliar para permitir que el usuario marque el elemento como completado
  Widget buildCheckBox() {
    // Activar o desactivar la casilla de verificación según el status actual de producto comestible
    // Activa el callback onChanged cuando el usuario toca la casilla de verificación
    return Checkbox(value: item.isComplete, onChanged: onComplete);
  }
}
