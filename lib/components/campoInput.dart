import 'package:flutter/material.dart';

class CampoInput extends StatelessWidget {
  final TextEditingController controlador;
  final String placeholder;
  final String etiqueta;
  final IconData icone;

  CampoInput({
    this.controlador,
    this.placeholder,
    this.etiqueta,
    this.icone,
  });

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
