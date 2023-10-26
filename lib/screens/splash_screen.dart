import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  // Método estático para crear un MaterialPage con un identificador único asociado con la pantalla SplashScreen
  //? Se crea una instancia de MaterialPage que representa la página de presentación en una aplicación Flutter, configurando su contenido, nombre de ruta y clave, Esta instancia de página se puede utilizar más adelante para la navegación dentro de la aplicación
  static MaterialPage page() {
    return MaterialPage(
        // La instancia de SplashScreen que se mostrará como contenido de la página
        child: const SplashScreen(),
        // El nombre de la ruta de navegación de la página de presentación
        name: FooderlichPages.splashPath,
        // Una clave única para identificar la página
        key: ValueKey(FooderlichPages.splashPath));
  }

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Método del ciclo de vida de un widget en Flutter que se llama cuando una dependencia del objeto State cambia, o inmediatamente después del initState()
  @override
  void didChangeDependencies() {
    // Utilizar el contexto para recuperar el AppStateManager el cual me permite a través de alguno de sus métodos públicos inicializar la aplicación
    // Esto provoca que se ejecute el Timer() declarado en initalizeApp(), que provoca que en 2 segundos se modifique el estado a: initialized = true. El cual es escuchado por el Enrutador para presentar la ruta con la pantalla correcta en la aplciación
    Provider.of<AppStateManager>(context, listen: false).initializeApp();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
                image: AssetImage('assets/fooderlich_assets/rw_logo.png'),
                height: 200),
            Text('Inicializando...')
          ],
        ),
      ),
    );
  }
}
