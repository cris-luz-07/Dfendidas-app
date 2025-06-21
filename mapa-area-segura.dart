import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaSeguranca(),
    );
  }
}

class TelaSeguranca extends StatelessWidget {
  const TelaSeguranca({super.key});

  final String logoIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/logo.png';

  final String marcadorIcon =
      'https://cdn-icons-png.flaticon.com/512/684/684908.png'; // Ícone de localização

  final String mapaUrl =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/mapa_brasilia.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F0EA),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F0EA),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Image.network(logoIcon),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Fundo do mapa pela URL
          Positioned.fill(
            child: Image.network(
              mapaUrl,
              fit: BoxFit.cover,
            ),
          ),

          // Marcador 1
          Positioned(
            top: 150,
            left: 120,
            child: Column(
              children: [
                Image.network(
                  marcadorIcon,
                  width: 40,
                  height: 40,
                ),
                const SizedBox(height: 4),
                const Text(
                  "Área de Segurança:\nDelegacia da Mulher",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Color(0xAAFFFFFF),
                  ),
                ),
              ],
            ),
          ),

          // Adicione mais marcadores se quiser
        ],
      ),
    );
  }
}
