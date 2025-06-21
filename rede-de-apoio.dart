import 'package:flutter/material.dart';
import 'dart:html' as html;

void main() => runApp(DFendidasApp());

class DFendidasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFendidas',
      home: DFendidasHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DFendidasHome extends StatelessWidget {
  final List<Map<String, String>> mensagens = [
    {'nome': 'CICLANA', 'mensagem': 'Preciso do remédio'},
    {'nome': 'BELTRANA', 'mensagem': 'Hoje choveu'},
    {'nome': 'FULANA', 'mensagem': 'Vamos ao parque?'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF1E6),
      appBar: AppBar(
        backgroundColor: Color(0xFFFDF1E6),
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.yellow,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.network(
                  'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DFendidas',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'REDE DE APOIO',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.menu, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            ...mensagens.map((item) => MensagemCard(
                  nome: item['nome']!,
                  mensagem: item['mensagem']!,
                )),
          ],
        ),
      ),
    );
  }
}

class MensagemCard extends StatelessWidget {
  final String nome;
  final String mensagem;

  MensagemCard({required this.nome, required this.mensagem});

  void _enviarWhatsApp(BuildContext context, String texto) {
    final mensagemCodificada = Uri.encodeComponent(texto);
    final url = "https://wa.me/5511992426461?text=$mensagemCodificada";
    html.window.open(url, '_blank');

    // Adicionado: aviso visual após o envio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("✅ Mensagem enviada com sucesso"),
        backgroundColor: Colors.purple[200],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12, top: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nome e mensagem
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nome,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                mensagem,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          // Botão "Acionar"
          ElevatedButton(
            onPressed: () => _enviarWhatsApp(context, mensagem),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("ACIONAR"),
          )
        ],
      ),
    );
  }
}
