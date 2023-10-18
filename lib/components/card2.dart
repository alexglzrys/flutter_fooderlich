import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/explore_recipe.dart';
import 'package:fooderlich/widgets/author_header.dart';

class Card2 extends StatelessWidget {
  final ExploreRecipe recipe;
  const Card2({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(recipe.backgroundImage), fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        // Esta pantalla se compone de 2 elementos principales, un header con información del autor, y el resto un espacio para colocar textos descriptivos
        child: Column(
          children: [
            // Widget personalozado
            AuthorHeader(
              author: recipe.authorName ?? '',
              title: recipe.role,
              imageProvider: AssetImage(recipe.profileImage ?? ''),
            ),
            // Expanded usa todo el espacio que queda disponible en el contenedor padre
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(
                        recipe.title,
                        style: FooderlichTheme.lightTextTheme.displayLarge,
                      )),
                  Positioned(
                    bottom: 70,
                    left: 16,
                    // RotatedBox permite rotar su elemento hijo en el sentido de las manecillas del reloj
                    // La rotación solo puede ser cuartos de vuelta
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Text(
                        recipe.subtitle,
                        style: FooderlichTheme.lightTextTheme.displayLarge,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
