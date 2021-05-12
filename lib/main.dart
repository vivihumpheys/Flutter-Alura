import 'package:flutter/material.dart';

void main() => runApp(ByteBankApp());

class ByteBankApp extends StatelessWidget {
  const ByteBankApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FormularioTransferencia(),
      ),
    );
  }
}

//
class FormularioTransferencia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Criando Transferência'),),
      body:  Column(
        children: [
          TextField(
            obscureText: true,
            decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Numero da Conta',
          ),),
          TextField(
            decoration: InputDecoration(
              labelText: 'Valor',
            ),
          ),
          ElevatedButton(onPressed: null, child: Text('Transferir'))
        ],
      ),

    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Transferências'),
      ),
      body: Column(
        children: <Widget>[
          ItemTransferencia(Transferencia(100, 1000)),
          ItemTransferencia(Transferencia(200, 1000)),
          ItemTransferencia(Transferencia(300, 1000)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
    // TODO: implement build
    return Card(
      child: ListTile(
        leading: Icon(Icons.monetization_on),
        title: Text(_transferencia.valor.toString()),
        subtitle: Text(_transferencia.numeroConta.toString()),
      )
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);
}
