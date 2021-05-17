import 'package:bytebank/components/campoInput.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = 'Criando Transferência';
const _etiquetaCampoValor = 'Valor';
const _placeholderCampoValor = '00.00';
const _etiquetaCampoNumeroConta = '0000';
const _placeholderCampoNumeroConta = 'Número da Conta';
const _textoBotaoConfirmar = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CampoInput(
              controlador: _controladorCampoNumeroConta,
              placeholder: _placeholderCampoNumeroConta,
              etiqueta: _etiquetaCampoNumeroConta,
            ),
            CampoInput(
                controlador: _controladorCampoValor,
                placeholder: _placeholderCampoValor,
                etiqueta: _etiquetaCampoValor,
                icone: Icons.monetization_on),
            BotaoConfirmar(
              controladorCampoNumeroConta: _controladorCampoNumeroConta,
              controladorCampoValor: _controladorCampoValor,
            ),
          ],
        ),
      ),
    );
  }
}

class BotaoConfirmar extends StatelessWidget {
  const BotaoConfirmar({
    @required this.controladorCampoNumeroConta,
    @required this.controladorCampoValor,
    Key key,
  }) : super(key: key);

  final TextEditingController controladorCampoNumeroConta;
  final TextEditingController controladorCampoValor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        child: Text(_textoBotaoConfirmar),
        onPressed: () => _realizarTransferencia(
          context,
          controladorCampoNumeroConta,
          controladorCampoValor,
        ),
      ),
    );
  }
}

void _realizarTransferencia(
    context,
    TextEditingController _controladorCampoNumeroConta,
    TextEditingController _controladorCampoValor) {
  final double valorTransferencia =
      double.tryParse(_controladorCampoValor.text);
  final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
  if (numeroConta != null && valorTransferencia != null) {
    final transferenciaCriada = Transferencia(
      valorTransferencia,
      numeroConta,
    );
    Navigator.pop(context, transferenciaCriada);
  }
}
