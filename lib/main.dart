import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BlueBoxProvider(),
      child: const BlueBoxApp(),
    ),
  );
}

class BlueBoxProvider extends ChangeNotifier {
  double tl = 0;
  double tr = 0;
  double bl = 0;
  double br = 0;

  void setTl(double v) {
    tl = v;
    notifyListeners();
  }

  void setTr(double v) {
    tr = v;
    notifyListeners();
  }

  void setBl(double v) {
    bl = v;
    notifyListeners();
  }

  void setBr(double v) {
    br = v;
    notifyListeners();
  }
}

class BlueBoxApp extends StatelessWidget {
  const BlueBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Конфігуратор кутків (Provider)'), centerTitle: true),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlueBoxWidget(),
              SizedBox(height: 32),
              CornerSlidersSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class BlueBoxWidget extends StatelessWidget {
  const BlueBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final p = context.watch<BlueBoxProvider>();
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(p.tl),
          topRight: Radius.circular(p.tr),
          bottomLeft: Radius.circular(p.bl),
          bottomRight: Radius.circular(p.br),
        ),
      ),
    );
  }
}

class CornerSlidersSection extends StatelessWidget {
  const CornerSlidersSection({super.key});

  Widget _item(String label, double value, ValueChanged<double> onChanged) {
    return Column(
      children: [
        Text('$label: ${value.toStringAsFixed(2)}'),
        Slider(value: value, min: 0, max: 75, onChanged: onChanged),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<BlueBoxProvider>();
    final read = context.read<BlueBoxProvider>();
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _item('TL', p.tl, read.setTl)),
            Expanded(child: _item('TR', p.tr, read.setTr)),
          ],
        ),
        Row(
          children: [
            Expanded(child: _item('BL', p.bl, read.setBl)),
            Expanded(child: _item('BR', p.br, read.setBr)),
          ],
        ),
      ],
    );
  }
}