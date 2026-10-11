import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EcoCanje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B4D3E)),
        useMaterial3: true,
      ),
      home: const PantallaPrincipal(),
    );
  }
}

// MODELO DE DATOS
class Elemento {
  final String nombre;
  final IconData icono;
  final Color color;
  final String descripcion;

  const Elemento({
    required this.nombre,
    required this.icono,
    required this.color,
    required this.descripcion,
  });
}

// LISTA DE PRENDAS
const List<Elemento> elementos = [
  Elemento(
    nombre: 'Chaqueta de cuero',
    icono: Icons.checkroom,
    color: Color(0xFF1B4D3E),
    descripcion: 'Chaqueta de cuero marrón en excelente estado. Talla M.',
  ),
  Elemento(
    nombre: 'Vestido floral',
    icono: Icons.dry_cleaning,
    color: Color(0xFF1B4D3E),
    descripcion: 'Vestido floral de verano, ligero y cómodo. Talla S.',
  ),
  Elemento(
    nombre: 'Camiseta vintage',
    icono: Icons.strikethrough_s,
    color: Color(0xFF1B4D3E),
    descripcion: 'Camiseta clásica estilo 90s. Talla L.',
  ),
  Elemento(
    nombre: 'Pantalón cargo',
    icono: Icons.accessibility_new,
    color: Color(0xFF1B4D3E),
    descripcion: 'Pantalón cargo verde resistente. Talla M.',
  ),
];

// PANTALLA PRINCIPAL
class PantallaPrincipal extends StatelessWidget {
  const PantallaPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EcoCanje - Dolores Hidalgo, Gto.'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Barra de Búsqueda
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Buscar prenda...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),
          // Rejilla de prendas
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: elementos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (BuildContext context, int indice) {
                final Elemento elemento = elementos[indice];
                return _TarjetaElemento(elemento: elemento);
              },
            ),
          ),
        ],
      ),
      // Botón flotante sencillo (Representa la acción principal del boceto)
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFFE07A5F),
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Ofrecer Prenda',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// TARJETA DE PRENDA
class _TarjetaElemento extends StatelessWidget {
  final Elemento elemento;

  const _TarjetaElemento({required this.elemento});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PantallaDetalle(elemento: elemento),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: elemento.color,
                child: Icon(elemento.icono, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 12),
              Text(
                elemento.nombre,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// PANTALLA DE DETALLE (Vista sencilla secundaria)
class PantallaDetalle extends StatelessWidget {
  final Elemento elemento;

  const PantallaDetalle({super.key, required this.elemento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(elemento.nombre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: elemento.color,
              child: Icon(elemento.icono, color: Colors.white, size: 50),
            ),
            const SizedBox(height: 20),
            Text(
              elemento.nombre,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              elemento.descripcion,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4D3E),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Regresar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
