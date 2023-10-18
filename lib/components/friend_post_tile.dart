import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/widgets/circle_image.dart';

// Widget para representar un post resumido de un amigo cocinero agregado en la red social
class FriendPostTile extends StatelessWidget {
  // Propiedad que contiene el Post con el cuál se rellenarán los contenidos de este Widget
  final Post post;
  const FriendPostTile({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Avatar que representa la imagen del cocinero o chef
        CircleImage(
            imageProvider: AssetImage(post.profileImageUrl), imageRadius: 20),
        const SizedBox(width: 16),
        // El espacio restante en la fila, la ocupará la columna con la descripción resumida del post
        // El no declarar un Expanded, provocaría desbordamientos en los hijos de la columna
        Expanded(
          // Columna que muestra la publicación y el tiempo de preparación para esa receta
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.comment),
              Text(
                '${post.timestamp} minutos aprox.',
                style: const TextStyle(fontWeight: FontWeight.w700),
              )
            ],
          ),
        )
      ],
    );
  }
}
