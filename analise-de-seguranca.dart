import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AlertaPage(),
    );
  }
}

class AlertaPage extends StatefulWidget {
  const AlertaPage({super.key});

  @override
  State<AlertaPage> createState() => _AlertaPageState();
}

class _AlertaPageState extends State<AlertaPage> {
  String? nome = "FULANO";
  String? frase = "VOCÊ É MINHA!";

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController fraseController = TextEditingController();

  void _abrirDialogo() {
    nomeController.text = nome ?? "";
    fraseController.text = frase ?? "";

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Cadastrar Frase de Alerta"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nomeController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: fraseController,
              decoration: const InputDecoration(labelText: "Frase de Alerta"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                nome = nomeController.text;
                frase = fraseController.text;
              });
              Navigator.of(context).pop();
            },
            child: const Text("Salvar"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final largura = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xfff7f1eb),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // LOGO E MENU
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

                // TÍTULOS
                const Text(
                  "DFendidas",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2e135b),
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "ANÁLISE DE SEGURANÇA",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  "SEU RISCO MODERADO",
                  style: TextStyle(fontSize: 16, color: Colors.orange),
                ),
                const SizedBox(height: 10),

                // IMAGEM DO MEDIDOR
                Image.network(
                  "https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/medidor-de-satisfacao-emoji-pequeno%20(1).png",
                  width: largura * 0.85,
                  errorBuilder: (_, __, ___) => const Text("Erro ao carregar imagem"),
                ),

                const SizedBox(height: 10),
                const Text(
                  "RESULTADO DE ACORDO COM O QUESTIONÁRIO\nE A ANÁLISE DE MENSAGENS ARMAZENADAS.\nSIGA PARA A PÁGINA DE ORIENTAÇÕES.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                const Text(
                  "FRASES DE ALERTA",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2e135b),
                  ),
                ),
                const SizedBox(height: 10),

                // CARTÃO DE FRASE OU BOTÃO DE CADASTRO
                frase != null && nome != null
                    ? Card(
                        color: const Color(0xffffe6f3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      nome!.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: _abrirDialogo,
                                    child: const Icon(Icons.edit, size: 20),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                frase!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Frase armazenada'),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.purpleAccent,
                                  minimumSize: const Size.fromHeight(42),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: const Text("ARMAZENAR"),
                              ),
                            ],
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: _abrirDialogo,
                        child: const Text("Cadastrar Frase de Alerta"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
