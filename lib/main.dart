import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const OracaoApp());

class OracaoApp extends StatelessWidget {
  const OracaoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oração do Dia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          bodyLarge: TextStyle(
              fontFamily: 'Georgia',
              fontSize: 20,
              color: Colors.white70,
              height: 1.5),
        ),
      ),
      home: const OracaoPage(),
    );
  }
}

class OracaoPage extends StatefulWidget {
  const OracaoPage({super.key});

  @override
  State<OracaoPage> createState() => _OracaoPageState();
}

class _OracaoPageState extends State<OracaoPage>
    with SingleTickerProviderStateMixin {
  final List<String> oracoes = [
    '“Senhor, fazei-me instrumento de vossa paz.”',
    '“Confia no Senhor de todo o teu coração.” — Provérbios 3:5',
    '“O amor tudo suporta, tudo crê, tudo espera, tudo persevera.” — 1Cor 13:7',
    '“Sede fortes e corajosos. O Senhor vos acompanha.” — Dt 31:6',
    '“O Senhor é meu pastor, nada me faltará.” — Salmo 23:1',
  ];

  String oracaoAtual = '';
  late AnimationController _controller;
  late Animation<Color?> _color1;
  late Animation<Color?> _color2;

  @override
  void initState() {
    super.initState();
    oracaoAtual = oracoes[Random().nextInt(oracoes.length)];

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 8))
          ..repeat(reverse: true);

    _color1 = ColorTween(
      begin: Colors.deepPurple.shade700,
      end: Colors.indigo.shade700,
    ).animate(_controller);

    _color2 = ColorTween(
      begin: Colors.purple.shade300,
      end: Colors.blueAccent.shade200,
    ).animate(_controller);
  }

  void novaOracao() {
    setState(() {
      oracaoAtual = oracoes[Random().nextInt(oracoes.length)];
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_color1.value!, _color2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        Icon(Icons.wb_sunny_rounded,
                            size: 90, color: Colors.white.withOpacity(0.9)),
                        const SizedBox(height: 20),
                        Text(
                          'Oração do Dia',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 80,
                          height: 3,
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ],
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 700),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              FadeTransition(opacity: animation, child: child),
                      child: Padding(
                        key: ValueKey(oracaoAtual),
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          oracaoAtual,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: novaOracao,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Nova Oração',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
