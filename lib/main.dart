// Importar paquete con herramientas UI Material
// Una regla general es usar solo un pequete de UI en toda la aplicación (Material o Cupertino)
import 'package:flutter/material.dart';
// Importación de archivo de tema
import 'package:fooderlich/fooderlich_theme.dart';

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
      // Scaffold es un widget que se encarga de definir el diseño y estructura de la aplicación
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            // agregar estilo declarado en el tema a los widgets de la aplicación
            style: theme.textTheme.titleLarge,
          ),
        ),
        body: Center(
          child: Text(
            'Vamos a cocinar!',
            style: theme.textTheme.displayLarge,
          ),
        ),
      ),
    );
  }
}
