import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

class TodayRecipeListView extends StatelessWidget {
  // Propiedad para almacenar el listado de recetas
  final List<ExploreRecipe> recipes;

  const TodayRecipeListView({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Titulo de la sección
          Text(
            'Recetas del día 🍳',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          const SizedBox(height: 16),
          // Contenedor para la lista horizontal de recetas del día
          Container(
            height: 400,
            color: Colors.transparent,
            // Construir una lista con separador de elementos en sentido horizontal
            // Las listas actuan como las filas o columnas, solo que tienen una caracteristica adicional y es el scroll
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: recipes.length,
              // La lista se construirá con widgets que sean retornados en el itemBuilder
              // Por cada elemento se construye una tarjeta con información de la receta en cuestión
              itemBuilder: (context, index) {
                final recipe = recipes[index];
                // Cada receta tiene información diferente, en este sentido especifica en que tipo de tarjeta debería presentarse
                // Este método local se encarga de construir la tarjeta especifica para cada tipo de receta
                return buildCard(recipe);
              },
              // El separador de elementos consiste en un espacio a lo ancho de 16 puntos entre ellos
              separatorBuilder: (context, index) {
                return const SizedBox(width: 15);
              },
            ),
          )
        ],
      ),
    );
  }

  // Método que retorna un tipo de tarjeta específico según la receta pasada como parámetro
  Widget buildCard(ExploreRecipe recipe) {
    if (recipe.cardType == RecipeCardType.card1) {
      return Card1(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card2) {
      return Card2(recipe: recipe);
    } else if (recipe.cardType == RecipeCardType.card3) {
      return Card3(recipe: recipe);
    } else {
      throw Exception('Esta tarjeta no existe');
    }
  }
}
