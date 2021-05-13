import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ListaTransferencias(),
      ),
    );
  }
}

//
class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Criando Transferência'),
      ),
      body: Column(
        children: [
          CampoInput(
              controlador: _controladorCampoNumeroConta,
              placeholder: '0000',
              etiqueta: 'Número da Conta'),
          CampoInput(
              controlador: _controladorCampoValor,
              placeholder: '00.00',
              etiqueta: 'Valor',
              icone: Icons.monetization_on),
          BotaoConfirmar(
            controladorCampoNumeroConta: _controladorCampoNumeroConta,
            controladorCampoValor: _controladorCampoValor,
          ),
        ],
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
        child: Text('Confirmar'),
        onPressed: () => _transferencia(
          context,
          controladorCampoNumeroConta,
          controladorCampoValor,
        ),
      ),
    );
  }

  void _transferencia(
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
      debugPrint('criando transferencia');
      Navigator.pop(context, transferenciaCriada);
    }
  }
}

class CampoInput extends StatelessWidget {
  final TextEditingController controlador;
  final String placeholder;
  final String etiqueta;
  final IconData icone;

  CampoInput({this.controlador, this.placeholder, this.etiqueta, this.icone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
      child: TextField(
        style: TextStyle(
          fontSize: 24.0,
        ),
        keyboardType: TextInputType.number,
        controller: controlador,
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          hintText: placeholder,
          labelText: etiqueta,
        ),
      ),
    );
  }
}

class ListaTransferencias extends StatefulWidget {
  final List<Transferencia> _transferencias = [];

  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(222, 2222));
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final Future<Transferencia> future =
              Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormularioTransferencia();
          }));
          future.then((transferenciaRecebida) {
            debugPrint('chegou no then do future');
            debugPrint('$transferenciaRecebida');
            _transferencias.add(transferenciaRecebida);
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ));
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
