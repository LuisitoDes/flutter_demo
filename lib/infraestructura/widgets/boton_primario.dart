import 'package:flutter_demo/infraestructura/estilos.dart';
import 'package:flutter/material.dart';

class BotonPrimario extends StatelessWidget
{
  final String _texto;
  final Function() _onPressed;

  BotonPrimario(this._texto, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context)
  {
    return ElevatedButton(
        onPressed: _onPressed,
        style: estiloBotonPrincipal,
        child: Text(_texto)
    );
  }
}