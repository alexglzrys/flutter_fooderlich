import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AspectRadio() mantiene una relación de aspecto específica para un widget secundario. Permite controlar las proporciones y el tamaño de los elementos en la UI
            // El valor de aspectRatio es double, pero por comodidad, Flutter recomienda colocarlo como ANCHO / ALTO en lugar del resultado calculado
            AspectRatio(
              aspectRatio: 1 / 1,
              // Usar Image.asset() depende del contexto y las necesidades,
              // AssetImge() también se usa para cargar imágenes desde el directorio de recursos
              // pero Image.asset() proporciona una interfaz más sencilla con múltiples opciones de personalización
              // Internamente, Image.asset() usa la clase AssetImage() para cargar el recurso de imagen, entonces es de más alto nivel
              child: Image.asset('assets/fooderlich_assets/empty_list.png'),
            ),
            // Titulo
            const SizedBox(height: 8.0),
            const Text('No hay alimentos', style: TextStyle(fontSize: 21.0)),
            // Subtitulo
            const SizedBox(height: 16.0),
            const Text(
              '¿Desea comprar ingredientes?\nPresione el botón + para anotarlos',
              textAlign: TextAlign.center,
            ),
            // Botón
            MaterialButton(
              onPressed: () {
                // 3. Acceder al estado
                // Provider.of<TabManager>(context) accede a la instancia de TabManager creada por el ChangeNotifierProvider()
                // Se invoca al método goToRecipes() del objeto TabManager para establecer el índice de la pestaña a 1, la cual se enceuntra asociada con la página de Explorado de Recetas
                // Internamente notifica al Consumer del cambio en el estado, y este le informa a sus widgets descendientes (que usan el estado) para que se reconstruyan
                Provider.of<TabManager>(context, listen: false).goToRecipes();
              },
              textColor: Colors.white,
              color: Colors.green,
              // Aplicar bordes redondeads al botón
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Text('Explorar recetas'),
            )
          ],
        ),
      ),
    );
  }
}
