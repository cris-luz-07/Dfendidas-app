import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String logoIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/logo.png';
  final String emergencyIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/emergency.png';
  final String mapIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/Map.png';
  final String groupIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/gmail_groups.png';
  final String roboIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/robo.png';
  final String shieldIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/Shield.png';
  final String sunIcon =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/main/light_mode.png';

  void abrirAcao(BuildContext context, String nome) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Clicou no botão: $nome')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      backgroundColor: const Color(0xFFF8F0EA),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'DFendidas',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B1877),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 260,
                    height: 260,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      shape: BoxShape.circle,
                    ),
                  ),

                  // Botão central - Emergency
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const TelaPanico()),
                      );
                    },
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.purple[200],
                        shape: BoxShape.circle,
                      ),
                      child: Image.network(emergencyIcon, width: 50, height: 50),
                    ),
                  ),

                  // Cada ícone ao redor agora é um botão clicável
                  Positioned(
                    top: 10,
                    child: GestureDetector(
                      onTap: () => abrirAcao(context, "Sol"),
                      child: Image.network(sunIcon, width: 35, height: 35),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    child: GestureDetector(
                      onTap: () => abrirAcao(context, "Escudo"),
                      child: Image.network(shieldIcon, width: 35, height: 35),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    child: GestureDetector(
                      onTap: () => abrirAcao(context, "Mapa"),
                      child: Image.network(mapIcon, width: 35, height: 35),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    child: GestureDetector(
                      onTap: () => abrirAcao(context, "Grupos"),
                      child: Image.network(groupIcon, width: 35, height: 35),
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    right: 50,
                    child: GestureDetector(
                      onTap: () => abrirAcao(context, "Robô"),
                      child: Image.network(roboIcon, width: 35, height: 35),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelaPanico extends StatefulWidget {
  const TelaPanico({super.key});

  @override
  State<TelaPanico> createState() => _TelaPanicoState();
}

class _TelaPanicoState extends State<TelaPanico> {
  int _contador = 5;
  bool alertaEnviado = false;

  @override
  void initState() {
    super.initState();
    _iniciarContagem();
  }

  void _iniciarContagem() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_contador == 0) {
        timer.cancel();
        _enviarAlerta();
      } else {
        setState(() {
          _contador--;
        });
      }
    });
  }

  void _enviarAlerta() async {
    setState(() {
      alertaEnviado = true;
    });

    final Uri whatsappUrl = Uri.parse(
      "https://wa.me/5511992426461?text=${Uri.encodeComponent('🚨 ALERTA: A usuária está em situação de risco! Última localização conhecida: Brasília - DF.\nAcione ajuda imediatamente.')}",
    );

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erro ao abrir o WhatsApp")),
      );
    }
  }

  void _cancelar() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
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
            ),
            const SizedBox(height: 12),
            const Text(
              "DFendidas",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xff2d0052),
              ),
            ),
            const Text(
              "SITUAÇÃO DE RISCO",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Center(
                child: alertaEnviado
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.check_circle, size: 80, color: Colors.green),
                          SizedBox(height: 16),
                          Text(
                            "ALERTA ENVIADO",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              "Seus dados de localização foram enviados aos contatos de emergência.",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.all(20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.pink.shade100,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "BOTÃO DE PÂNICO",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Você tem 5 segundos para cancelar o alerta.\nCaso contrário, seus contatos de segurança e a polícia serão acionados.",
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _cancelar,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              ),
                              child: Text("CANCELAR ($_contador)"),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
