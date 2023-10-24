import 'package:flutter/material.dart';

// Clase manejadora de estado que administra el índice de la pestaña o Tab seleccionado por el usuario
// Es importante crear objetos de administración, para administrar funciones y cambios de estado en un solo lugar

// TabManager extiende de ChangeNotifier.
// Esto permite que el objeto de esta clase proporcione notificaciones de cambios a sus oyentes
class TabManager extends ChangeNotifier {
  // Propiedad que realiza un seguimiento de que pestaña o Tab ha tocado el usuario
  int selectedTab = 0;

  // Método que modifica el índice de la pestaña actualmente seleccionada
  void goToTab(index) {
    // Almacena el nuevo índice de la pestaña que actualmente ha tocado el usuario
    selectedTab = index;
    // Notifica a todos los widgets que ha ocurrido un cambio en el estado y que necesitan reconstruirse.
    notifyListeners();
  }

  // Método para establecer el tab seleccionado al índice 1
  // El cuál corresponde a la pantalla del explorador de recetas
  void goToRecipes() {
    selectedTab = 1;
    // Notificar a todos los widgets que escuchan el TabManager, que Explorador es la pestaña actualmente seleccionada
    notifyListeners();
  }
}
