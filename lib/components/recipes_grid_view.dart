import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

// Widget para mostrar un GridView de recetas simples
class RecipesGridView extends StatelessWidget {
  // Propiedad para almacenar las recetas simples a mostrar dentro del grid
  // Esta clase requiere un listado de recetas para funcionar
  final List<SimpleRecipe> recipes;

  const RecipesGridView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      // GridView.builder() muestra solo los elementos visibles en pantalla (ahorrar memoria RAM del dispositivo)
      // Este es un constructor útil cuando se tiene una lista dinámica o infinita de elementos recuperados bajo demanda
      child: GridView.builder(
          // Cuantos elementos habrá en el grid
          itemCount: recipes.length,
          // El eje principal de este grid es la vertical
          scrollDirection: Axis.vertical,
          // SliverGridDelegateWithFixedCrossAxisCount() crea una cuadrícula con un número fijo de elementos en el eje secundario o transversal
          // El eje transversal esta dado por la dirección opuesta del eje principal del grid, definida en la propiedad scrollDirection (por defecto es vertical)
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // Indicamos que existirán 2 columnas en el eje secundario
              // Por tanto el grid sera de N Filas x 2 Columnas
              crossAxisCount: 2,
              mainAxisSpacing: 3.0,
              crossAxisSpacing: 3.0),
          // Por cada receta se genera un widget RecipeThumbnail, mismo que recibe la información de la receta para mostrarla
          itemBuilder: (context, index) {
            // Recuperar la receta actual en el listado de recetas pasadas al widget principal
            final simpleRecipe = recipes[index];
            return RecipeThumbnail(recipe: simpleRecipe);
          }),
    );
  }
}
