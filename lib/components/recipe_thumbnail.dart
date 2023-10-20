import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

// Widget que representa un mosaico o miniautura de receta simple
class RecipeThumbnail extends StatelessWidget {
  // Propiedad que almacena la receta simple a proyectar en este widget
  // Esta clase requiere una receta simple para poder funcionar
  final SimpleRecipe recipe;

  const RecipeThumbnail({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // El contenido que se encuentra en Expanded ocupará todo el espacio restante de la columna
          Expanded(
              // ClipRRect recorta la imagen que tiene como hijo, y hace que sus esquinas estén redondeadas
              child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              recipe.dishImage,
              // La imagen cubre el 100% de su contenedor padre
              fit: BoxFit.cover,
            ),
          )),
          const SizedBox(
            height: 10,
          ),
          // Textos para mostrar el titulo de la receta y la duración
          // maxLines indica al widget de texto que solo muestre una sola linea o renglón en caso de que el contenido sea extenso
          Text(recipe.title,
              maxLines: 1, style: Theme.of(context).textTheme.bodyLarge),
          Text(recipe.duration, style: Theme.of(context).textTheme.bodyLarge)
        ],
      ),
    );
  }
}
