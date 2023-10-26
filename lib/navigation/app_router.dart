import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/screens/screens.dart';

// Enrutador que configura la lista de páginas que muestra el Navegador
// Escucha a los administradores de estado, y en función de los cambios de estado, configura la lista de rutas de página
// ¿Qué es Navegación Declarativa?:
// En lugar de decirle al navegador que hacer con push() o pop(), le indicamos que cuando el estado sea X, renderice Y páginas

// AppRouter es una implementación de RouterDelegate que se utiliza para gestionar la navegación de la aplicación. Escucha el estado general de la aplicación, así como el listado de ingredientes comestibles, y muestra diferentes páginas según el estado.

// RouterDelegate: Le indica al enrutador que cree y configure un widget Navigator
class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  // GlobalKey: Esta clave se utiliza para identificar el Navigator en la jerarquía de widgets y permitir el acceso a su estado y métodos.
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  // El enrutador escuchará los cambios de estado generales de la aplicación, para configurar la lista de páginas del Navigator
  final AppStateManager appStateManager;
  // El enrutador escuchará los cambios de estado cuando el usuario crea, edita o elimina un ingrediente o producto comestible, para configurar la lista de páginas del Navigator
  final GroceryManager groceryManager;

  // Una instancia de este enrutador necesita conocer quienes son los adminstradores de estado a los que debe escuchar para reacionar a cambios
  // Se inicializa la clave unica del NavigatorState
  AppRouter({required this.appStateManager, required this.groceryManager})
      : navigatorKey = GlobalKey<NavigatorState>() {
    // Añadir o registrar oyentes de estado
    // Cuando el estado cambie, el enrutador reconfigurará el Navigator con un nuevo conjunto de páginas

    // Administra el estado deneral de la aplicación: Gestiona cuando la aplicacion se inicializó, se hizo login, si se completo la guía de introducción rápida, etc.
    appStateManager.addListener(notifyListeners);
    // Administra la lista de artículos comestibles: nuevos, editados, eliminados, su condición de completado o no completado
    groceryManager.addListener(notifyListeners);
  }

  // Cuando finalice o elimine el enrutador, se deben eliminar todos los oyentes registrados durante su creación
  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);
    groceryManager.removeListener(notifyListeners);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Devuelve un Navigator personalizado, que se utilizará para gestionar la navegación en la aplicación
    return Navigator(
      // Utilizar un navigatorKey, el cuál es necesario para recuperar el Navigator actual (pueden existir Navigator anidados)
      key: navigatorKey,
      // Controlar el comportamiento cuando el usuario intenta salir de la página actual para regresar a la página anterior
      onPopPage: _handlePopPage,
      // Declarar la lista de páginas que describen el stack de navegación
      pages: [
        // Si la aplicación no está inicializada, mostrar la página de Bienvenida
        if (!appStateManager.isInitialized) SplashScreen.page(),
        // Si la aplicación esta inicializada, pero no se ha iniciado seción; mostrar la página de Login
        if (appStateManager.isInitialized && !appStateManager.isLoggedIn)
          LoginScreen.page(),
      ],
    );
  }

  // Manejador de evento Pop
  // Este método se dispara cuando el usuario toca el botón atrás, o activa un evento del botón atrás del sistema (método pop())
  // route:   hace referencia a la ruta actual, contiene información como RouteSettings para recuperar el nombre y los argumentos de la ruta
  // result:  es el valor devuelto cuando se completa la ruta, por ejemplo, el valor que devuelve un cuadro de dialogo (aceptar, cancelar)
  bool _handlePopPage(Route<dynamic> route, result) {
    // Comprueba si el POP de la ruta actual tuvo éxito
    if (!route.didPop(result)) {
      // Si falla devuelve falso
      return false;
    }
    // Realizar acciones personalizadas antes de cerrar esta página
    // Si la ruta emergente tiene éxito, se comprueban las diferentes rutas y se activan los cambios de estado apropiados
    return true;
  }

  // Retornar nulo indica que este enrutador no soporta aplicaciones web Flutter
  @override
  Future<void> setNewRoutePath(configuration) async {}
}
