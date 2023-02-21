import 'package:flutter_demo/infraestructura/paginas.dart';
import 'package:flutter_demo/infraestructura/traducciones.dart';
import 'package:flutter_demo/infraestructura/widgets/png_visor.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';

class PantallaInicio extends StatefulWidget
{
  const PantallaInicio({super.key});

  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio>
{
  @override
  void initState()
  {
    super.initState();

    _enviarSiguientePantalla();
  }

  @override
  Widget build(BuildContext context)
  {
    return ScaffoldBase(
      cuerpo: Center(
        child: PngVisor('logo'),
      )
    );
  }

  Future<void> _enviarSiguientePantalla() async
  {
    await esperaProgramada();

    Navigator.of(context).pushReplacementNamed(menu);
  }

  Future<void> esperaProgramada() async
  {
    await Future.delayed(const Duration(seconds: 5));
  }
}