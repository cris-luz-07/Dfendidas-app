import 'package:flutter/material.dart';

void main() {
  runApp(const DFendidasApp());
}

class DFendidasApp extends StatelessWidget {
  const DFendidasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaAcessibilidade(),
    );
  }
}

class TelaAcessibilidade extends StatefulWidget {
  const TelaAcessibilidade({super.key});

  @override
  State<TelaAcessibilidade> createState() => _TelaAcessibilidadeState();
}

class _TelaAcessibilidadeState extends State<TelaAcessibilidade> {
  bool modoLibras = false;
  bool modoLeitorTela = false;
  bool modoAltoContraste = false;

  List<Map<String, String>> contatos = [];
  String pin = '';

  final TextEditingController nomeController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  void _abrirCadastroContato() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cadastrar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                controller: numeroController,
                decoration: const InputDecoration(labelText: 'Número'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  contatos.add({
                    'nome': nomeController.text,
                    'numero': numeroController.text,
                  });
                  nomeController.clear();
                  numeroController.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _abrirCadastroPin() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Criar PIN'),
          content: TextField(
            controller: pinController,
            decoration: const InputDecoration(labelText: 'Digite seu PIN'),
            obscureText: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  pin = pinController.text;
                  pinController.clear();
                });
                Navigator.of(context).pop();
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSwitch(String label, bool value, void Function(bool?) onChanged, IconData icon) {
    return Row(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Icon(icon, size: 24),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF1E6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFDF1E6),
        elevation: 0,
        toolbarHeight: 100,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(right: 12),
              decoration: const BoxDecoration(
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
                children: const [
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
            const Icon(Icons.menu, color: Colors.black),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Acessibilidade
            _buildSwitch('Libras', modoLibras, (val) => setState(() => modoLibras = val ?? false), Icons.pan_tool),
            _buildSwitch('Leitor de Tela', modoLeitorTela, (val) => setState(() => modoLeitorTela = val ?? false), Icons.volume_up),
            _buildSwitch('Modo Alto Contraste', modoAltoContraste, (val) => setState(() => modoAltoContraste = val ?? false), Icons.contrast),

            const SizedBox(height: 20),

            // Contatos de emergência
            const Text(
              'Contatos de Emergência',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ElevatedButton(
              onPressed: _abrirCadastroContato,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[300]),
              child: const Text('Cadastrar Contatos'),
            ),
            Text('Contatos cadastrados: ${contatos.length}'),

            const SizedBox(height: 20),

            // PIN de acesso
            const Text(
              'PIN de Acesso',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            ElevatedButton(
              onPressed: _abrirCadastroPin,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple[300]),
              child: const Text('Criar PIN'),
            ),
            Text(pin.isNotEmpty ? 'PIN cadastrado ✅' : 'Nenhum PIN cadastrado'),

            const SizedBox(height: 30),

            // Botão entrar no app
            ElevatedButton(
              onPressed: () {
                // Aqui você pode fazer a navegação para a próxima tela futuramente
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Entrando no App...')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Entrar no App',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
