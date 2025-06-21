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
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaPanico(),
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
      "https://wa.me/5511992426461?text=${Uri.encodeComponent('🚨 ALERTA: A usuária está em situação de risco! Última localização conhecida: Brasília - DF.\nAcione ajuda imediatamente.')}"
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
    Navigator.of(context).pop(); // volta para tela anterior
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: SafeArea(
        child: Column(
          children: [
            // TOPO: Logo + menu
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
