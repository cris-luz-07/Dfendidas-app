import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

// --- APP RAIZ ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AvaliacaoRiscoPage(),
    );
  }
}

// --- TELA 1: Avaliação de Risco (Lista de Blocos) ---
class AvaliacaoRiscoPage extends StatelessWidget {
  const AvaliacaoRiscoPage({super.key});

  void navegarParaPergunta(BuildContext context, String bloco) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Passo2Screen(bloco: bloco),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> blocos = [
      {"titulo": "Violência Física", "respondido": true},
      {"titulo": "Violência Psicológica", "respondido": false},
      {"titulo": "Ameaças", "respondido": false},
      {"titulo": "Controle Financeiro", "respondido": false},
    ];

    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOPO: logo + menu
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
                  const Icon(Icons.menu, size: 30),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Avaliação de Risco",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff2d0052),
                ),
              ),
              const SizedBox(height: 20),

              // Lista de blocos
              Expanded(
                child: ListView.builder(
                  itemCount: blocos.length,
                  itemBuilder: (context, index) {
                    final bloco = blocos[index];
                    return GestureDetector(
                      onTap: () => navegarParaPergunta(context, bloco["titulo"]),
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: bloco["respondido"] == true
                              ? Colors.green.shade100
                              : Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              bloco["titulo"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (bloco["respondido"] == true)
                              const Icon(Icons.check_circle, color: Colors.green)
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- TELA 2: Pergunta (Passo 2) ---
class Passo2Screen extends StatefulWidget {
  final String bloco;

  const Passo2Screen({super.key, required this.bloco});

  @override
  _Passo2ScreenState createState() => _Passo2ScreenState();
}

class _Passo2ScreenState extends State<Passo2Screen> {
  String? respostaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pergunta - ${widget.bloco}'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Pergunta sobre ${widget.bloco}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Você já sofreu com Armas?',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            // Opções
            ...[
              {'label': '✅ Sim', 'value': 'sim'},
              {'label': '❌ Não', 'value': 'nao'},
              {'label': '🤔 Às vezes', 'value': 'as_vezes'},
            ].map((opcao) {
              return ListTile(
                title: Text(opcao['label']!),
                leading: Radio<String>(
                  value: opcao['value']!,
                  groupValue: respostaSelecionada,
                  onChanged: (value) {
                    setState(() {
                      respostaSelecionada = value;
                    });
                  },
                ),
                onTap: () {
                  setState(() {
                    respostaSelecionada = opcao['value']!;
                  });
                },
              );
            }).toList(),

            const Spacer(),

            // Botões
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('PULAR'),
                ),
                ElevatedButton(
                  onPressed: respostaSelecionada == null
                      ? null
                      : () {
                          print('Resposta enviada: $respostaSelecionada');

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TelaPanico(),
                            ),
                          );
                        },
                  child: const Text('ENVIAR'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- TELA 3: Botão de Pânico ---
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
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: SafeArea(
        child: Column(
          children: [
            // TOPO
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
