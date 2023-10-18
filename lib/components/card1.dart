import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';

class Card1 extends StatelessWidget {
  // constantes en tiempo de ejecución para definir el contenido a mostrar en la tarjeta
  final ExploreRecipe recipe;

  const Card1({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Center(
        // Container es un widget que entra en la categoría de diseño (organizan la fomra en como se presentan los widgets internos)
        child: Container(
      // aplicar padding de 16px al contenedor
      padding: const EdgeInsets.all(16),
      // restringir el contenedor a un máximo de 350x450
      constraints: const BoxConstraints.expand(width: 350, height: 450),
      // especificar como se dibujará la caja del contenedor
      decoration: const BoxDecoration(
          // pintar una imagen sobre la caja, el recurso se encuentra dentro del directorio de recursos assets/
          // la imagen debe cubrir la totalidad de la caja
          image: DecorationImage(
              image: AssetImage('assets/mag1.png'), fit: BoxFit.cover),
          // Especificar bordes redondeados al contenedor de 10px
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      // Stack coloca sus hijos uno encima del otro
      // Es otro widget de categoría diseño
      child: Stack(children: [
        Text(
          recipe.subtitle,
          style: FooderlichTheme.darkTextTheme.bodyLarge,
        ),
        // Positioned controla dónde se colocará el texto dentro del stack, respetando las propiedades del contenedor padre (paddings, etc.)
        Positioned(
          top: 20,
          child: Text(
            recipe.title,
            style: FooderlichTheme.darkTextTheme.displayMedium,
          ),
        ),
        Positioned(
          bottom: 30,
          right: 0,
          child: Text(
            recipe.message,
            // Aplicar estilo de tema a nuestro widget
            style: FooderlichTheme.darkTextTheme.bodyLarge,
          ),
        ),
        Positioned(
          bottom: 10,
          right: 0,
          child: Text(
            recipe.authorName ?? '',
            // Aplicar estilo de tema a nuestro widget, el cuál se hereda a través del árbol de widgets
            // Si el padre modifica su tema de forma personalizada, lo mejor es asignarlo de forma directa (FooderlichTheme.darkTextTheme.bodyLarge)
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )
      ]),
    ));
  }
}
