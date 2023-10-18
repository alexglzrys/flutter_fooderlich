import 'package:flutter/material.dart';
import 'package:fooderlich/components/components.dart';
import 'package:fooderlich/models/models.dart';

// Widget para mostrar una lista vertical de publicaciones de amigos cocineros agregados a la red social
class FriendPostListView extends StatelessWidget {
  // Propiedad para almacenar las publicaciones a mostrar en la lista
  final List<Post> friendPosts;
  const FriendPostListView({super.key, required this.friendPosts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0),
      child: Column(children: [
        // Titulo de la sección
        Text(
          'Social Chefs 👨‍🍳',
          style: Theme.of(context).textTheme.displayLarge,
        ),
        const SizedBox(
          height: 16,
        ),

        ListView.separated(
          // Indicar a Flutter que esta lista se encuentra anidada dentro de otra, por tanto no debe considerarla como principal
          primary: false,
          // Ajustar el tamaño de esta lista con base a su contenido
          // Es una buena idea establecer en true esta propiedad cuando la lista se encuentra dentro de un Container, Expanded con una posible altura fija. ya que previene que su contenido exceda el límite del tamaño de dicho contenedor
          shrinkWrap: true,
          // esta propiedad controla el comportamiento del desplazamiento de la lista
          // NeverScrollableScrollPhysics() desactiva el desplazamiento en la lista
          // Es util cuando dese mostrar un listado de elementos sin permitir que el usuario la desplace.
          // Existen otros tipos de desplazamiento que pueden brindar efectos interesantes
          // ??
          // Como el padre es una lista que se puede desplazar, y esta lista anidada ajusta el tamaño a su contenido, todos los elementos de publicadción se pueden mirar en pantalla, dando el control absoluto al list principal para poder desplazarse y visualizar el resto de los contenidos
          physics: const NeverScrollableScrollPhysics(),
          // Lista en sentido vertical
          scrollDirection: Axis.vertical,
          // La cantidad de elementos a renderizar en esta lista
          itemCount: friendPosts.length,
          // Para cada elemento de publicación, crear un widget FriendPostTile con la respectiva inforación
          itemBuilder: (context, index) {
            // Recuperar la información para este post en particular
            final post = friendPosts[index];
            return FriendPostTile(post: post);
          },
          // Para cada elemento de publicación, agrega una separación a lo alto de 16 puntos
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
        ),
        const SizedBox(height: 16)
      ]),
    );
  }
}
