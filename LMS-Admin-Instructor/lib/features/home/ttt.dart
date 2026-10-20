import 'package:flutter/material.dart';

class Ttt extends StatefulWidget {
  const Ttt({super.key});

  @override
  State<Ttt> createState() => _TttState();
}

class _TttState extends State<Ttt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ttt')),
      body: const Center(child: Text('Ttt')),
    );
  }
}
