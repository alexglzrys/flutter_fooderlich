import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';

class CardTrends extends StatelessWidget {
  const CardTrends({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/mag2.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        // El contenido de esta tarjeta es colocado a manera de pila uno encima del otro
        child: Stack(children: [
          // Overlay
          // Colocamos una capa oscura con opacidad sobre la imagen para mejorar el contraste y destacar el contenido
          Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
          // Cabecera
          // Consta de un icono y un texto descriptivo colocados en sentido vertical
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.book,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Tendencia en recetas',
                  style: FooderlichTheme.darkTextTheme.displayMedium,
                ),
                const SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
          // Chips
          // Un conjunto de fichas agrupadas, de tal modo que si no existe más espacio a la derecha, las siguientes fichas se colocan en la siguiente fila
          // Wrap es un widget de diseño que intenta acomodar cada uno de sus hijos uno al lado del otro, y de no existir más espacio en lugar de desbordarse, lo coloca en la sigueinte fila o columna según la dirección especificada
          // Funciona igual que la propiedad wrap de Flexbox en CSS
          // No hay necesidad de posicionar este elemento, ya que toma el 100% de todo el contenedor padre y las fichas se muestran en el centro
          Center(
            child: Wrap(
              // Los elementos serán agrupados en la horizontal con alineación a la izquierda, si es que se desbordan
              alignment: WrapAlignment.start,
              spacing: 12,
              children: [
                // Chip es un widget que nos permite diseñar fichas las cuales se usan para mostrar categorías, nubes de etiquetas, etc.
                // Generalmente muestra avatares de texto e imágenes y también realiza acciones del usuario como tocar y eliminar.
                Chip(
                  label: Text(
                    'Licuados',
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  onDeleted: () {
                    // ignore: avoid_print
                    print('Eliminado');
                  },
                ),
                Chip(
                    label: Text(
                      'Vegano',
                      style: FooderlichTheme.darkTextTheme.bodyLarge,
                    ),
                    backgroundColor: Colors.black.withOpacity(0.7),
                    onDeleted: () {
                      // ignore: avoid_print
                      print('Eliminado');
                    }),
                Chip(
                  label: Text(
                    'Pastas',
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                ),
                Chip(
                  label: Text(
                    'Pescado',
                    style: FooderlichTheme.darkTextTheme.bodyLarge,
                  ),
                  backgroundColor: Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
