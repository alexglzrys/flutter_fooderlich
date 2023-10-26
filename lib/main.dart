// Importar paquete con herramientas UI Material
// Una regla general es usar solo un pequete de UI en toda la aplicación (Material o Cupertino)
import 'package:flutter/material.dart';
// Importación de archivo de tema
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/models/models.dart';
import 'package:fooderlich/navigation/app_router.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatefulWidget {
  const Fooderlich({super.key});

  @override
  State<Fooderlich> createState() => _FooderlichState();
}

class _FooderlichState extends State<Fooderlich> {
  // Inicializar el manejador de estado referente a la lista de ingredientes o productos comestibles
  final _groceryManager = GroceryManager();
  // Inicializar el manejador de estado referente a aspectos generales de la aplicación
  final _appStateManager = AppStateManager();
  // Propiedad para almacenar la instancia del enrutador personalizdo de la aplicación
  late AppRouter _appRouter;

  @override
  void initState() {
    // Inicializar el enrutador de la aplicación
    _appRouter = AppRouter(
        appStateManager: _appStateManager, groceryManager: _groceryManager);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // definir una variable que contiene una referencia al tema a usar
    final theme = FooderlichTheme.dark();
    // MultiProvider() acepta una lista de proveedores de estado a los que pueden acceder los widgets descendiente de Home
    return MultiProvider(
        providers: [
          // 1. Proveer los proveedores de estado

          // El proveedor ayuda a exponer los objetos del modelo de estado a los widgets que están por debajo de él.
          // El proveedor es un asistente de administración del estado, que actúa como contenedor para los widgets heredados

          // ChangeNotifierProvider() crea una instancia de TabManager, que escucha los cambios en el índice de pestañas y notifica a sus oyentes de posibles cambios
          // ChangeNotifierProvider(create: (context) => TabManager()),

          // Creo una instancia de AppStateManager, que escucha los cambios en el estado de la aplicación, tales como: Si está inicializada, si el usuario esta logeado, saber que pestaña del tab esta seleccionada, entre otras.
          ChangeNotifierProvider(create: (context) => _appStateManager),
          // Creo una instancia de CroceryManager, que escucha los cambios en la lista de alimentos o ingredientes, y notifica a sus oyentes de posibles cambios
          ChangeNotifierProvider(create: (context) => _groceryManager)
        ],
        child: MaterialApp(
            // Materail App es un widget que se encarga de darle la apariencia de sistema al App (Material 'Android' | Cupertino 'iOS')
            // Agregar tema personalizado a la aplicación
            theme: theme,
            title: 'Fooderlich',
            // Mostrar una página determinada con base al estado de la aplicación
            home: Router(routerDelegate: _appRouter)));
  }
}
