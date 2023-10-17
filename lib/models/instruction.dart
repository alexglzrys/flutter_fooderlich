class Instruction {
  // imagen o icono decorativo para esta instrucción
  late String imageUrl;
  // Descripción detallada referente a esta instrucción
  late String description;
  // Minutos
  late int durationInMinutes;

  // Constructor con parámetros opcionales con valores por defecto
  Instruction(
      {this.imageUrl = '', this.description = '', this.durationInMinutes = 0});

  // Constructor nombrado
  // Crear una nueva instancia de Instruction a partir de un parametro de tipo mapa (JSON)
  Instruction.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'];
    description = json['description'];
    durationInMinutes = json['durationInMinutes'];
  }
}
