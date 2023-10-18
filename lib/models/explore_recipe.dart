import 'package:fooderlich/models/ingredient.dart';
import 'package:fooderlich/models/instruction.dart';

// Contiene todos los detalles de una receta en particular
// Prácticamente es un Card con información adicional
class ExploreRecipe {
  late String cardType;
  late String title;
  late String subtitle;
  late String backgroundImage;
  late String backgroundImageSource;
  late String message;
  late String role;
  late List<String> tags;
  late int? durationInMinutes;
  late String? authorName;
  late String? profileImage;
  late String? dietType;
  late int? calories;
  late String? description;
  late String? source;
  late List<Ingredient>? ingredients;
  late List<Instruction>? instructions;

  ExploreRecipe(
      {required this.cardType,
      required this.title,
      required this.subtitle,
      required this.backgroundImage,
      required this.backgroundImageSource,
      required this.message,
      required this.role,
      required this.tags,
      this.durationInMinutes = 0,
      this.authorName,
      this.profileImage,
      this.dietType,
      this.calories,
      this.description,
      this.source,
      this.ingredients,
      this.instructions});

  ExploreRecipe.fromJson(Map<String, dynamic> json) {
    cardType = json['cardType'];
    title = json['title'];
    subtitle = json['subtitle'];
    backgroundImage = json['backgroundImage'];
    backgroundImageSource = json['backgroundImageSource'];
    message = json['message'];
    authorName = json['authorName'];
    role = json['role'];
    profileImage = json['profileImage'];
    durationInMinutes = json['durationInMinutes'];
    dietType = json['dietType'];
    calories = json['calories'];
    description = json['description'];
    source = json['source'];

    // cast<String>() convierte los elementos de una lista o mapa a un tipo de dato específico
    // Para este ejemplo, el argumento que recibimos en el constructor es un Map<String, dynamic>
    // 'tags': <dynamic>['uno', 'dos', 'tres']
    // Por tanto, convertimos la lista de elementos dinámicos a una lista lista de cadenas
    tags = json['tags'].cast<String>();

    // Verificar si hay presencia de ingredientes en esta receta
    if (json['ingredients'] != null) {
      // Se crea una lista vacía que acepta objetos de tipo Ingredient
      ingredients = <Ingredient>[];
      // Iterar por cada elemento, y crear un nuevo objeto de tipo Ingredient a partir de la información actual
      // finalmente agregar ese objeto a la lista de ingredients
      json['ingredients']
          .forEach((item) => ingredients!.add(Ingredient.fromJson(item)));
    }

    if (json['instructions'] != null) {
      instructions = <Instruction>[];
      json['instructions']
          .forEach((item) => instructions!.add(Instruction.fromJson(item)));
    }
  }
}

// Clase de utilidad que actua como interface o enumeración
class RecipeCardType {
  static const String card1 = 'card1';
  static const String card2 = 'card2';
  static const String card3 = 'card3';
}
