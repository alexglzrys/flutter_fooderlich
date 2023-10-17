class Post {
  // Url imagen de perfil
  late String profileImageUrl;
  // Comentario
  late String comment;
  // Url imagen receta
  late String foodPictureUrl;
  // Fecha de publicación
  late String timestamp;

  // Constructor con parámetros por nombre obligatorios
  Post(
      {required this.profileImageUrl,
      required this.comment,
      required this.foodPictureUrl,
      required this.timestamp});

  // Constructor nombrado
  // Crear una nueva instancia de Post a partir de un parametro de tipo mapa (JSON)
  Post.fromJson(Map<String, dynamic> json) {
    profileImageUrl = json['profileImageUrl'];
    comment = json['comment'];
    foodPictureUrl = json['foodPictureUrl'];
    timestamp = json['timestamp'];
  }
}
