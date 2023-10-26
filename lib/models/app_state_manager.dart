import 'dart:async';

import 'package:flutter/material.dart';

// Crear constantes para identificar cada pestaña (por su índice) de la barra de navegación que puede tocar el usuario
class FooderlichTab {
  static const int explore = 0;
  static const int recipes = 1;
  static const int toBuy = 2;
}

// Clase que maneja el estado para administrar aspectos generales de la aplicación
class AppStateManager extends ChangeNotifier {
  // Comprueba si la aplicación esta inicializada
  bool _initialized = false;
  // Permite comprobar si el usuario ha iniciado sesión
  bool _loggedIn = false;
  // Comprueba si el usuario completo el tutorial de uso
  bool _onboardingComplete = false;
  // Realiza un seguimiento de que pestaña se encuentra seleccionada por el usuario
  int _selectedTab = FooderlichTab.explore;

  // Métodos getters para acceder a los valores de las propiedades privadas de esta clase
  // Esto es importante para mantener un flujo unidireccional, donde el estado no se puede cambiar directamente, sino a través de llamadas a funciones o eventos enviados
  bool get isInitialized => _initialized;
  bool get isLoggedIn => _loggedIn;
  bool get isOnboardingComplete => _onboardingComplete;
  int get getSelectedTab => _selectedTab;

  // Método para inicializar la aplicación
  void initializeApp() {
    // Establecer un temporizador con retraso de 2000 milisegundos
    Timer(const Duration(milliseconds: 2000), () {
      // Después de 2000 milisegundos, el estado de la aplicación cambia a inicializada
      // La idea es que se muestre por 2 segundos la pantalla de bienvenida y después se reemplace por otra pantalla.
      _initialized = true;
      // Se notifica a todos los oyentes que consuman este estado
      notifyListeners();
    });
  }

  // Método para logear usuarios
  void login(String username, String password) {
    // Se requeire de un username y password para poder logear al usuario
    // En un escenario de producción, se realizaría una llamda a un API de autenticación
    // El estado de la aplicación cambia a logeado
    _loggedIn = true;
    // Se notifica a todos los oyentes que consuman este estado
    notifyListeners();
  }

  // Método para completar la guía rápida de uso de la aplicación
  void completeOnboarding() {
    // Notificar a todos los oyentes que el usuario ha completado la guía rápida de incorporación.
    _onboardingComplete = true;
    notifyListeners();
  }

  // Método que modifica el índice de la pestaña de navegación actualmente seleccionada
  void goToTab(index) {
    _selectedTab = index;
    // Notificar a todos los oyentes
    notifyListeners();
  }

  // Método para establecer el tab seleccionado al índice 1, el cuál corresponde con la página de recetas
  void goToRecipes() {
    _selectedTab = FooderlichTab.recipes;
    // Notificar a todos los oyentes
    notifyListeners();
  }

  // Método para cerrar sesión
  void logout() {
    // Reestablecer todas las propiedades de estado de la aplicación a sus valores por defecto
    _loggedIn = false;
    _onboardingComplete = false;
    _initialized = false;
    _selectedTab = 0;

    // Reiniciar la aplicación
    initializeApp();
    // Notificar a todos los oyentes
    notifyListeners();
  }
}
