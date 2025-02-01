import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = 'Limpar';
  String _expressao = '';
  String _resultado = '';

  // Método de pressionamento de botão
  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == _limpar) {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else {
        _expressao += valor;
      }
    });
  }

  // Método para calcular o resultado
  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  // Método para avaliar a expressão
  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    final evaluator = ExpressionEvaluator();
    final result = evaluator.eval(Expression.parse(expressao), {});
    return result;
  }

  // Widget do botão
  Widget _botao(String valor) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          primary: Colors.blueAccent,
        ),
        onPressed: () => _pressionarBotao(valor),
        child: Text(
          valor,
          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Exibição da expressão
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        // Exibição do resultado
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _resultado,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
          ),
        ),
        // Grade de botões
        Expanded(
          flex: 3,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: 16,
            itemBuilder: (context, index) {
              const botaoValores = [
                '7', '8', '9', '÷',
                '4', '5', '6', 'x',
                '1', '2', '3', '-',
                '0', '.', '=', '+'
              ];
              return _botao(botaoValores[index]);
            },
          ),
        ),
        // Botão de limpar
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              primary: Colors.redAccent,
            ),
            onPressed: () => _pressionarBotao(_limpar),
            child: const Text(
              'Limpar',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

