import 'package:flutter/material.dart';

class BotonMenuLateral extends StatelessWidget
{
  final String _texto;
  final IconData _icono;
  final Function() _onPressed;

  const BotonMenuLateral(this._texto, this._icono, this._onPressed, {super.key});

  @override
  Widget build(BuildContext context)
  {
    return ListTile(
        title: Text(_texto),
        leading: Icon(_icono),
        onTap: _onPressed
    );
  }
}