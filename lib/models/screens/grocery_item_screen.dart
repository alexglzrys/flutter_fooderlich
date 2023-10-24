import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class GroceryItemScreen extends StatefulWidget {
  // Callback que permite saber cuando se crea un nuevo elemento
  final Function(GroceryItem)? onCreate;
  // Callback que retorna un nuevo elemento comestible actualizado
  final Function(GroceryItem)? onUpdate;
  // El artículo comestible en el que se hizo click
  final GroceryItem? originalItem;
  // Determina si el usuario esta creando o editando un elemento
  final bool isUpdating;

  // Los : se utilizan para inicializar la variable isUpdating en el constructor de GroceryItemScreen.
  // Este tipo de inicialización es común en Dart y se utiliza para establecer el valor de una variable en el momento de la creación de un objeto.
  const GroceryItemScreen(
      {super.key, this.onCreate, this.onUpdate, this.originalItem})
      : isUpdating = (originalItem != null);

  @override
  State<GroceryItemScreen> createState() => _GroceryItemScreenState();
}

class _GroceryItemScreenState extends State<GroceryItemScreen> {
  // Este Widget gestiona el siguiente estado interno

  // Almacena el nombre del producto
  String _name = '';
  // Almacena el nivel de importancia
  Importance _importance = Importance.low;
  // Almacena la fecha y hora acutal
  DateTime _dateTime = DateTime.now();
  // Almacena la hora actual
  TimeOfDay _timeOfDay = TimeOfDay.now();
  // Almacena la etiqueta de color asociada al producto
  Color _currentColor = Colors.green;
  // Almacena la cantidad de un producto
  int _currentSliderValue = 0;

  // Escucha cambios en un campo de texto asociado, controla el valor mostrado
  final _nameController = TextEditingController();

  // Inicializar las propieaddes de estado interno para este Widget
  @override
  void initState() {
    // cuando el articulo original no es nulo, significa que el usuario esta editando un elemento existente
    // En este caso se configura el widget para mostrar los valores del elemento
    if (widget.originalItem != null) {
      _nameController.text = widget.originalItem!.name;
      _name = widget.originalItem!.name;
      _currentSliderValue = widget.originalItem!.quantity;
      _importance = widget.originalItem!.importance;
      _currentColor = widget.originalItem!.color;
      final date = widget.originalItem!.date;
      _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
      _dateTime = date;
    }

    // Registrar un escuchador de eventos al controlador de campos de texto
    _nameController.addListener(() {
      // Cuando el texto cambia, configura el nuevo nombre
      setState(() {
        _name = _nameController.text;
      });
    });

    super.initState();
  }

  // Limpiar y cancelar cuaquier escuchador de eventos.
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define el diseño principal y la estructura de toda la pantalla
    return Scaffold(
      appBar: AppBar(
        // En la barra de aplicaciones se declara un botón de acción
        actions: [
          IconButton(
              // El usuario tocara este botón cuando ha terminado de crear un artículo
              onPressed: () {
                // Se crea un producto comestible a partir de las propiedades de estado
                final groceryItem = GroceryItem(
                    // Si se trata de un producto existente, se conserva su id, caso contrario, se genera uno aleatorio
                    id: widget.originalItem?.id ?? const Uuid().v1(),
                    name: _nameController.text,
                    importance: _importance,
                    color: _currentColor,
                    quantity: _currentSliderValue,
                    date: DateTime(_dateTime.year, _dateTime.month,
                        _dateTime.day, _timeOfDay.hour, _timeOfDay.minute));

                // Si el usuario esta actualizando un producto existente, se invoca el método pertinente para actualizar, en caso contrario se registra el nuevo ingrediente.
                if (widget.isUpdating) {
                  widget.onUpdate!(groceryItem);
                } else {
                  widget.onCreate!(groceryItem);
                }
              },
              icon: const Icon(Icons.check))
        ],
        title: Text(
          'Elemento comestible',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
        // Elimina la sombra debajo de la barra de aplicaciones
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        // Mostrar un listView, ya que el contenido puede suoerar el alto de la pantalla del dispositivo
        child: ListView(
          children: [
            buildNameField(),
            buildImportanceField(),
            buildDateField(context),
            buildTimeField(context),
            const SizedBox(height: 10),
            buildColorPicker(context),
            const SizedBox(height: 10),
            buildQuantityField(),
            const SizedBox(height: 16),
            // Agregar widget personalizado GroceryTile
            // La intensión es mostrar un preview del comestible con los valores de las propiedades del estado interno de este Widget
            GroceryTile(
              item: GroceryItem(
                  id: const Uuid().v1(),
                  name: _name,
                  importance: _importance,
                  color: _currentColor,
                  quantity: _currentSliderValue,
                  date: DateTime(_dateTime.year, _dateTime.month, _dateTime.day,
                      _timeOfDay.hour, _timeOfDay.minute)),
            )
          ],
        ),
      ),
    );
  }

  // Método para construir un campo de texto para el nombre del ingrediente
  Widget buildNameField() {
    // Los elementos se colocaran de forma vertical
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label con tipografía de Lato de Google Fonts
        Text(
          'Nombre del comestible',
          style: GoogleFonts.lato(fontSize: 28),
        ),
        // Agregar un campo de texto
        TextField(
          // asociar el controlador de eventos de tipo TextEditingController a esta caja de texto
          // Este enfoque permite un control más detallado sobre el campo de texto, como obtener o establecer el valor del campo de texto según una lógica determinada.
          controller: _nameController,
          // Establecer el color del cursor en este TextField
          cursorColor: _currentColor,
          // Dar estilo al campo de texto
          decoration: InputDecoration(
              // Placeholder
              hintText: 'Por ejemplo: Manzana, Plátano, 1 Bolsa de sal',
              // Personalizar el color del borde del campo de texto
              // Color de borde cuando el textField esta habilitado
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              // Color del borde cuando el TextField obtiene el foco
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor)),
              // Color de borde cuando el TextField no tiene errorr
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: _currentColor))),
        )
      ],
    );
  }

  // Método para construir chips de selección para elegir la importancia del producto comestible
  Widget buildImportanceField() {
    // El diseño es en sentido vertical
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Titular de la sección
        Text(
          'Importancia',
          style: GoogleFonts.lato(fontSize: 28.0),
        ),
        // Agrupo todos los widgets de tipo ChoiseChip con una separación de 10px
        // Por defecto Wrap coloca los hijos en sentido horizontal
        // Cuando no existe más espacio, coloca el resto de sus hijos en la siguiente linea
        Wrap(
          spacing: 10.0,
          children: [
            // Existen 4 tipos diferentes de Chips

            // ChoiseChip() permite al usuario realizar una única selección entre un conjunto de opciones
            // InputChip: convierte una entrada de texto en chip, como en las páginas de empleo donde por cada habilidad escrita se convierte en un chip
            // FilterChip: permite al usuario seleccionar multiples respuestas dadas un conjunto de opciones
            // ActionChip: Un botón con el estilo de un chip

            ChoiceChip(
              label: const Text(
                'Baja',
                style: TextStyle(color: Colors.white),
              ),
              // Verificar si el usuario ha seleccionado este chip
              selected: _importance == Importance.low,
              selectedColor: Colors.black,
              // Si el usuario selecciono este chip, actualiza el estado con la importancia seleccionada
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.low;
                });
              },
            ),
            ChoiceChip(
              label: const Text(
                'Media',
                style: TextStyle(color: Colors.white),
              ),
              selected: _importance == Importance.medium,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.medium;
                });
              },
            ),
            ChoiceChip(
              label: const Text('Alta', style: TextStyle(color: Colors.white)),
              selected: _importance == Importance.hihg,
              selectedColor: Colors.black,
              onSelected: (selected) {
                setState(() {
                  _importance = Importance.hihg;
                });
              },
            )
          ],
        )
      ],
    );
  }

  // Método para construir el campo de selección de fecha para adquirir el producto comestible
  Widget buildDateField(BuildContext context) {
    // Los elementos serán acomodados verticalmente
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // El titulo y selector de fecha se mostrarán horizontalmente
        Row(
          // Agregar espacio entre los elementos de esta fila
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Titulo de la sección
            Text(
              'Fecha',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            // TextButton actuará como un botón para mostrar el selector de fecha
            TextButton(
                // El selector de fechas da una respuesta asíncrona
                onPressed: () async {
                  // Obtener la fecha actual cuando el usuario presiona el botón
                  final currentDate = DateTime.now();
                  // Mostrar el selector de fechas
                  final selectedDate = await showDatePicker(
                      context: context,
                      // Restringir el selector de fechas
                      // Permitiendo al usuario seleccionar una fecha desde hoy hasta 5 años en el futuroo
                      initialDate: currentDate,
                      firstDate: currentDate,
                      lastDate: DateTime(currentDate.year + 5));
                  setState(() {
                    // Si el usuario selecciona una fecha, actualiza el estado con la fecha seleccionada
                    if (selectedDate != null) {
                      _dateTime = selectedDate;
                    }
                  });
                },
                child: const Text('Seleccione')),
          ],
        ),
        // Si existe una fecha, se mostrará debajo del titulo y selector de fecha
        if (_dateTime != null) Text(DateFormat('yyyy-MM-dd').format(_dateTime))
      ],
    );
  }

  // Método para construir un campo de tipo TimePicker que permita al usuario seleccionar una hora determinada para comprar el producto comestible
  Widget buildTimeField(BuildContext context) {
    // Los elementos se acomodan en sentido vertical
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // El titulo del campo y el botón para mostrar el selector de hora, se muestran en sentido horizontal
        Row(
          // Existe una separación entre elementos de esta fila
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Titulo de la sección
            Text(
              'Selecciona la hora',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            // Botón
            TextButton(
                // Mostrar el selector de hora cuando el botón es presionado
                onPressed: () async {
                  // Por defecto el selector de hora, establece y muestra la hora inicial en la hora actual
                  final timeOfDay = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  setState(() {
                    // Una vez que el usuario seleccione una hora, el widget devuelve un objeto TimeOfDate.
                    // Se procede a actualizar el estado con la hora seleccionada
                    if (timeOfDay != null) {
                      _timeOfDay = timeOfDay;
                    }
                  });
                },
                child: const Text('Seleccione'))
          ],
        ),
        if (_timeOfDay != null) Text(_timeOfDay.format(context))
      ],
    );
  }

  // Método para mostrar un ColorPicker que permita al usuario elegir un color para etiquetar el artículo comestible
  Widget buildColorPicker(BuildContext context) {
    // Los elementos están colocados en sentido horizontal
    return Row(
      // Existe una separación entre ellos
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Fila secundaria para agrupar...
        // Un Container para mostrar el color actualmente seleccionado
        // Un SizeBox como separador a lo ancho de 8px
        // Un Text para mostrar el título de la sección
        Row(
          children: [
            Container(
              height: 50,
              width: 10,
              color: _currentColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Color',
              style: GoogleFonts.lato(fontSize: 28),
            )
          ],
        ),
        // Botón
        TextButton(
            child: const Text('Seleccione'),
            onPressed: () {
              // Mostrar un cuadro de dialogo emergente cuando se presiona el botón
              showDialog(
                  context: context,
                  builder: (context) {
                    // Envolver el Widget de BlockPicker (ColorPicker widget de terceros) en un cuadro de alerta emergente
                    return AlertDialog(
                      content: BlockPicker(
                        pickerColor: Colors.white,
                        onColorChanged: (color) {
                          // Actualizar el estado cuando el usuario selecciona un color
                          setState(() {
                            _currentColor = color;
                          });
                        },
                      ),
                      // Acciones del cuadro de alerta emergente
                      actions: [
                        TextButton(
                            // Cuando el usuario presiona este botón, se cierra el dialogo
                            // Saca de la pila de navegación al cuadro de dialogo y regresa a la pantalla anterior
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Guardar'))
                      ],
                    );
                  });
            })
      ],
    );
  }

  // Método para mostrar un control que permita al usuario seleccionar la cantidad o monto que necesita de un artículo comestible determinado
  Widget buildQuantityField() {
    // Widgets acomodados en sentido vertical
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // El titulo de la sección y la Cantidad actualmente seleccionada, se mostrarán en sentido horizontal
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Cantidad',
              style: GoogleFonts.lato(fontSize: 28),
            ),
            const SizedBox(
              width: 16,
            ),
            // Slider() trabaja con valores double
            // Es importante hacer el casting si necesitamos trabajar con valores entreros
            // Casting a String si necesitamos mostrar ese valor en un Widget de texto.
            Text(
              _currentSliderValue.toInt().toString(),
              style: GoogleFonts.lato(fontSize: 18),
            )
          ],
        ),
        // Slider() es un control deslizante apto para mostrar o seleccionar cantidades numéricas
        Slider(
            // Establecer valor actual, así como el valor mínimo y máximo aceptados
            value: _currentSliderValue.toDouble(),
            min: 0,
            max: 100,
            // Establecer como aumentará o disminuira de valor el control deslizante
            divisions: 100,
            // Mostrar etiqueta encima del control deslizante, aqui se muestra el valor actual que tiene asignado dicho control
            label: _currentSliderValue.toInt().toString(),
            // Establecer colores para el rango activo e inactivo de dicho control
            activeColor: _currentColor,
            inactiveColor: _currentColor.withOpacity(0.5),
            onChanged: (double value) {
              // Actualizar el estado cuando cambie de valor dicho control
              setState(() {
                _currentSliderValue = value.toInt();
              });
            })
      ],
    );
  }
}
