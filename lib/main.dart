import 'package:flutter/material.dart';

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
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
            backgroundColor: Colors.yellow,
            child: Icon(Icons.balance, color: Colors.purple),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black87),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("DFendidas",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple)),
            SizedBox(height: 4),
            Text("REDE DE APOIO",
                style: TextStyle(fontSize: 16, color: Colors.purple)),
            SizedBox(height: 20),
            ...mensagens.map((item) => MensagemCard(item)).toList(),
          ],
        ),
      ),
    );
  }
}

class MensagemCard extends StatelessWidget {
  final Map<String, String> item;
  MensagemCard(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.purple[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['nome']!,
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text(item['mensagem']!),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
            ),
            child: Text("ACIONAR"),
          )
        ],
      ),
    );
  }
}
