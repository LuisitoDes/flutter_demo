import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter/material.dart';

class Cargando extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return CircularProgressIndicator(
      color: Colores.principal,
    );
  }
}