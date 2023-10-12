import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/widgets/circle_image.dart';

// Los SatefulWidgets pueden administrar su estado dinámicamente
class AuthorHeader extends StatefulWidget {
  // Propiedades para este widget
  final String author;
  final String title;
  final ImageProvider imageProvider;

  // Este widget acepta por parámetros el nombre del autor, su puesto o cargo, y una imagen de perfil
  const AuthorHeader(
      {super.key,
      required this.author,
      required this.title,
      required this.imageProvider});

  @override
  State<AuthorHeader> createState() => _AuthorHeaderState();
}

class _AuthorHeaderState extends State<AuthorHeader> {
  // Propiedades que representan el estado de este Widget
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    // Este Widget se compone de un contenedor con una fila general que muestra un Avatar, y un IconButton para agregar a favoritos
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        // Alinea los elementos a los lados, dejando una separación entre ellos en el eje principal (horizontal)
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Avatar
          Row(
            // En el apartado del Avatar se muestra la imagen, y su respectivo nombre del autor y profesión
            // Esta información se muestra en sentido horizontal (fila), con una respectiva separación entre los dos elementos
            children: [
              // Widget personalizado para mostrar la imagen de avatar del autor
              CircleImage(
                imageProvider: widget.imageProvider,
                imageRadius: 28,
              ),
              // SizeBox nos permite agregar separación entre widgets, ya sea en en lo ancho o alto
              const SizedBox(
                width: 8,
              ),
              Column(
                // Alinea los elementos de la columna con base al eje secundario (horizontal)
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.author,
                    style: FooderlichTheme.lightTextTheme.displayMedium,
                  ),
                  Text(
                    widget.title,
                    style: FooderlichTheme.lightTextTheme.displaySmall,
                  )
                ],
              )
            ],
          ),
          IconButton(
            // Mostrar el icono con base al estado de este widget
            icon: Icon(_isFavorited ? Icons.favorite : Icons.favorite_border),
            iconSize: 30,
            color: Colors.red[400],
            onPressed: () {
              // Administrar el estado de este widget
              setState(() {
                // El estado ha cambiado,
                // Flutter sabe que este widget lo tienen que retirar, y volver a construir con su nuevo estado en el árbol de widgets
                _isFavorited = !_isFavorited;
              });

              if (_isFavorited) {
                // Cuando sea presionado el icono, se mostrará un snackBar en la parte inferior de la pantalla, mostrando el mensaje 'Licuado agregado a favoritos'
                // El widget SnackBar se usa para mostrar brevemente información a los usuarios cuando se ha realizado una acción (como un Toast)
                const snackBar =
                    SnackBar(content: Text('Licuado agregado a favoritos'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
          )
        ],
      ),
    );
  }
}
