import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherWidgetPage(),
    );
  }
}

class WeatherWidgetPage extends StatelessWidget {
  const WeatherWidgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: Stack(
        children: [
          // FUNDO COM IMAGEM
          Positioned.fill(
            child: Image.network(
              'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/fundo_ceu.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // CONTEÚDO
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // TOPO: LOGO + MENU
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.yellow,
                        backgroundImage: const NetworkImage(
                          "https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/logo.png",
                        ),
                      ),
                      const Icon(Icons.menu, color: Colors.black, size: 30),
                    ],
                  ),

                  const SizedBox(height: 80),

                  // CARTÃO DE CLIMA
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      width: largura * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.85),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            "Brasília - Brasil",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Icon(Icons.wb_sunny, color: Colors.amber, size: 40),
                          SizedBox(height: 10),
                          Text(
                            "27°",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Sol com possibilidade de pancadas de chuva à tarde.\nTempo abafado.",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // Rodapé REMOVIDO conforme pedido
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
