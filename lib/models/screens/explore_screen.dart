import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/components.dart';

// Pantalla principal referente al explorador de recetas del día y publicaciones recientes
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

// Se convirtí a un Widget con estado ya que este este widget necesita reaccionar a interacciones del usuario o eventos internos
class _ExploreScreenState extends State<ExploreScreen> {
  // crea unA instancia simulador de respuestas asincronas de servidor
  final mockService = MockFooderlichService();

  // Crear una instancia de ScrollController para deterctar cuando se hace scroll en la lista
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Registrar el detector de eventos que usará el ScrollController asociado al ListView
    _scrollController.addListener(_scrollListener);
  }

  // Función asociada al detector de evento scroll
  void _scrollListener() {
    // Instrucción para verificar si el usuario ha alcanzado el inicio o final de un ListView
    if (_scrollController.position.atEdge) {
      // Si scroll del ListView se encuentra en la parte superior
      if (_scrollController.position.pixels == 0) {
        // ignore: avoid_print
        print('Estoy en la parte superior de la lista');
      } else {
        // ignore: avoid_print
        print('He llegado al final de la lista');
      }
    }
  }

  @override
  void dispose() {
    // eliminar cualquier suscripción a escuchadores de eventos registrados para evitar desbordamientos de RAM
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // El widget FutureBuilder toma un future (promise) como parametro, con base al resultado obtenido, retorna una construcción de widgets para ser representados en pantalla
    // Es una excelente idea usar FutureBuilder para esperar a que se complete una tarea asíncrona
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
            // Asociar un controlador de eventos a esta lista
            controller: _scrollController,
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
