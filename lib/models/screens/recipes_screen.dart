import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';

// Pantalla referente al grid de recetas simples
class RecipesScreen extends StatelessWidget {
  // crea una instancia del simulador de respuestas asincronas de servidor
  final exploreService = MockFooderlichService();

  RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Una vez que el future este resuelto, construir un Grid View con el listado de recetas simples recuperadas desde el servidor Fake
    return FutureBuilder(
        // Recuperar el listado de recetas simples
        future: exploreService.getRecipes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Recuperar la data devuelta por el future.
            final recipes = snapshot.data!;
            // Mostrar el GridView con el listado de recetas simples devueltas por el future
            return RecipesGridView(recipes: recipes);
          } else {
            // Mostrar indicador de progreso si el future aun no se resuelve
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
