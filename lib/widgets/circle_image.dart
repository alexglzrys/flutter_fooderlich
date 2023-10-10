import 'package:flutter/material.dart';

class CircleImage extends StatelessWidget {
  // Propiedades para este widget
  final double imageRadius;
  final ImageProvider imageProvider;

  // Este widget acepta 2 parámetros, uno de ellos requerido y el otro opcional pero con un valor por defecto
  const CircleImage(
      {super.key, required this.imageProvider, this.imageRadius = 20});

  @override
  Widget build(BuildContext context) {
    // CircleAvatar es un widget que define un circulo ya sea con color o imagen de fondo, su respectivo radio y opcionalmente un contenido interno
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: imageRadius,
      // Al definir un CircleAvatar como hijo del principal y un radio menor, se crea un efecto de circulo con imagen de fondo y borde blanco
      child: CircleAvatar(
        radius: imageRadius - 5,
        backgroundImage: imageProvider,
      ),
    );
  }
}
