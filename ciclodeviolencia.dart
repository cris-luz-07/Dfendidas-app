import 'package:flutter/material.dart';

void main() => runApp(DFendidasApp());

class DFendidasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFendidas',
      home: ConhecaSeusDireitos(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConhecaSeusDireitos extends StatelessWidget {
  final logoUrl =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/logo.png';

  void _mostrarImagem(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Image.network(
          'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/ciclo%20de%20violencia.JPG',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _mostrarLegislacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Legislação'),
        content: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('FECHAR'),
          ),
        ],
      ),
    );
  }

  void _mostrarOrientacoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Orientações'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Disque 180 – Central de Atendimento à Mulher'),
            SizedBox(height: 8),
            Text('190 – Polícia Militar'),
            SizedBox(height: 8),
            Text('Saúde Mental – 188 (CVV)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('FECHAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String titulo,
    required String subtitulo,
    required VoidCallback onPressed,
  }) {
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
          // Textos
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(subtitulo, style: TextStyle(color: Colors.black)),
            ],
          ),
          // Botão
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("SAIBA MAIS"),
          )
        ],
      ),
    );
  }

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
                child: Image.network(logoUrl, fit: BoxFit.cover),
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
                    'CONHEÇA SEUS DIREITOS',
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
            _buildCard(
              titulo: "CICLO DE VIOLÊNCIA",
              subtitulo: "Você está em risco?",
              onPressed: () => _mostrarImagem(context),
            ),
            _buildCard(
              titulo: "LEGISLAÇÃO",
              subtitulo: "Saiba seus direitos",
              onPressed: () => _mostrarLegislacao(context),
            ),
            _buildCard(
              titulo: "ORIENTAÇÕES",
              subtitulo: "O que fazer em situações de perigo",
              onPressed: () => _mostrarOrientacoes(context),
            ),
          ],
        ),
      ),
    );
  }
}import 'package:flutter/material.dart';

void main() => runApp(DFendidasApp());

class DFendidasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFendidas',
      home: ConhecaSeusDireitos(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConhecaSeusDireitos extends StatelessWidget {
  final logoUrl =
      'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/logo.png';

  void _mostrarImagem(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        child: Image.network(
          'https://raw.githubusercontent.com/cris-luz-07/Dfendidas-app/refs/heads/main/ciclo%20de%20violencia.JPG',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void _mostrarLegislacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Legislação'),
        content: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec euismod, nisl eget.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('FECHAR'),
          ),
        ],
      ),
    );
  }

  void _mostrarOrientacoes(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Orientações'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Disque 180 – Central de Atendimento à Mulher'),
            SizedBox(height: 8),
            Text('190 – Polícia Militar'),
            SizedBox(height: 8),
            Text('Saúde Mental – 188 (CVV)'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('FECHAR'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String titulo,
    required String subtitulo,
    required VoidCallback onPressed,
  }) {
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
          // Textos
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(subtitulo, style: TextStyle(color: Colors.black)),
            ],
          ),
          // Botão
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Text("SAIBA MAIS"),
          )
        ],
      ),
    );
  }

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
                child: Image.network(logoUrl, fit: BoxFit.cover),
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
                    'CONHEÇA SEUS DIREITOS',
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
            _buildCard(
              titulo: "CICLO DE VIOLÊNCIA",
              subtitulo: "Você está em risco?",
              onPressed: () => _mostrarImagem(context),
            ),
            _buildCard(
              titulo: "LEGISLAÇÃO",
              subtitulo: "Saiba seus direitos",
              onPressed: () => _mostrarLegislacao(context),
            ),
            _buildCard(
              titulo: "ORIENTAÇÕES",
              subtitulo: "O que fazer em situações de perigo",
              onPressed: () => _mostrarOrientacoes(context),
            ),
          ],
        ),
      ),
    );
  }
}
