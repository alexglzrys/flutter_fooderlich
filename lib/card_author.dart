import 'package:flutter/material.dart';
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/widgets/author_header.dart';

class CardAuthor extends StatelessWidget {
  const CardAuthor({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints.expand(width: 350, height: 450),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/mag5.png'), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        // Esta pantalla se compone de 2 elementos principales, un header con información del autor, y el resto un espacio para colocar textos descriptivos
        child: Column(
          children: [
            // Widget personalozado
            const AuthorHeader(
              author: 'Mike Katz',
              title: 'Conocedor de licuados',
              imageProvider: AssetImage('assets/author_katz.jpeg'),
            ),
            // Expanded usa todo el espacio que queda disponible en el contenedor padre
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                      bottom: 16,
                      right: 16,
                      child: Text(
                        'Recetas',
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
                        'Licuados',
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
