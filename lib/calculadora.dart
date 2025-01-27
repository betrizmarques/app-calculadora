import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String _limpar = "Limpar";
  String _expressao = '';
  String _resultado = '';

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

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = "Erro: Não foi possível calcular";
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll("x", "*");
    expressao = expressao.replaceAll("÷", "/");
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget _botao(String valor, {Color cor = Colors.blue}) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: cor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.all(12.0),
        ),
        child: Text(
          valor,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _pressionarBotao(valor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Colors.black12,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _expressao,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black26,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _resultado,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              _botao('7'),
              _botao('8'),
              _botao('9'),
              _botao('÷', cor: Colors.orange),
              _botao('4'),
              _botao('5'),
              _botao('6'),
              _botao('x', cor: Colors.orange),
              _botao('1'),
              _botao('2'),
              _botao('3'),
              _botao('-', cor: Colors.orange),
              _botao('0'),
              _botao('.'),
              _botao('=', cor: Colors.green),
              _botao('+', cor: Colors.orange),
              _botao('(', cor: Colors.purple),
              _botao(')', cor: Colors.purple),
              _botao('^', cor: Colors.purple),
              _botao('√', cor: Colors.purple),
            ],
          ),
        ),
        Expanded(
          child: _botao(_limpar, cor: Colors.red),
        ),
      ],
    );
  }
}
