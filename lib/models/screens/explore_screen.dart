import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';

class ExploreScreen extends StatelessWidget {
  // crea unA instancia simulador de respuestas asincronas de servidor
  // Fake API
  final mockService = MockFooderlichService();

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // El widget FutureBuilder toma un future (promise) como parametro, con base al resultado obtenido, retorna una construcción de widgets para ser representados en pantalla
    return FutureBuilder(
      // mockService.getExploreData() retorna una instancia del modelo ExploreData, que contiene una lista de de recetas del día y una lista de publicaciones de amigos
      future: mockService.getExploreData(),
      builder: (context, snapshot) {
        // Verificar el estado del future
        if (snapshot.connectionState == ConnectionState.done) {
          // Si el future esta completado, extraer la respuesta para usarla como contenido en algún widget
          final recipes = snapshot.data!.todayRecipes;
          final posts = snapshot.data!.friendPosts;
          // ? Con base al diseño planteado en esta sección se pueden usar 2 enfoques
          // Usar una Columna para colocar las 2 listas. El problema es que la columna ocupa el 100% del alto del dispositivo y no tiene scroll. Por lo que si se tiene un display pequeño, muchos elementos no serán visibles aunque estos se encuentren dentro de una lista
          // Una lista anidada. Tiene las mismas propiedades que una columna o fila, sumado a que se puede hacer scroll. Por tanto, si el display es pequeño, se pueden ver los elementos ocultos con tan solo desplazarse por la pantalla. (Lista anidada por que pueden haber listas dentro de la lista principal)

          // Se usa el constructor por defecto del ListView dado que se compone de un número pequeño de elementos conocidos
          return ListView(
            scrollDirection: Axis.vertical,
            children: [
              // Lista horizontal que contiene las recetas del día de hoy
              TodayRecipeListView(recipes: recipes),
              const SizedBox(height: 16),
              // Lista vertical que contiene las publicaciones de distintos chefs
              FriendPostListView(friendPosts: posts)
            ],
          );
        } else {
          // Si el future aun no esta completado, mostrar un widget como indicador de carga al usuario
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
