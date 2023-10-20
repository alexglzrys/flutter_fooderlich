// Importar paquete con herramientas UI Material
// Una regla general es usar solo un pequete de UI en toda la aplicación (Material o Cupertino)
import 'package:flutter/material.dart';
// Importación de archivo de tema
import 'package:fooderlich/fooderlich_theme.dart';
import 'package:fooderlich/home.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

void main() => runApp(const Fooderlich());

class Fooderlich extends StatelessWidget {
  const Fooderlich({super.key});

  @override
  Widget build(BuildContext context) {
    // definir una variable que contiene una referencia al tema a usar
    final theme = FooderlichTheme.dark();
    // Materail App es un widget que se encarga de darle la apariencia de sistema al App (Material 'Android' | Cupertino 'iOS')
    return MaterialApp(
      // Agregar tema personalizado a la aplicación
      theme: theme,
      title: 'Fooderlich',
      // 1. Proveer los proveedores de estado
      // MultiProvider() acepta una lista de proveedores de estado a los que pueden acceder los widgets descendiente de Home
      home: MultiProvider(providers: [
        // ChangeNotifierProvider() crea una instancia de TabManager, que escucha los cambios en el índice de pestañas y notifica a sus oyentes de posibles cambios
        ChangeNotifierProvider(create: (context) => TabManager())
      ], child: const Home()),
    );
  }
}
