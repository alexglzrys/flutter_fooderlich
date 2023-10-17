// Representa un ingrediente en particular del cual se compone una receta
class Ingredient {
  late String imageUrl;
  late String title;
  late String source;

  // Constructor con parámetros por nombre obligatorios
  Ingredient(
      {required this.imageUrl, required this.title, required this.source});

  // Constructor nombrado
  // Crear una nueva instancia de Ingredient a partir de un parametro de tipo mapa (JSON)
  Ingredient.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    title = json['title'];
    source = json['source'];
  }
}
