import 'package:flutter_demo/aplicacion/autenticacion/iniciar_autenticacion_use_case.dart';
import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter_demo/infraestructura/autenticacion/autenticar.dart';
import 'package:flutter_demo/infraestructura/dispositivo/medidas.dart';
import 'package:flutter_demo/infraestructura/widgets/boton_primario.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';

class Autenticacion extends StatefulWidget
{
  const Autenticacion({super.key});

  @override
  State<Autenticacion> createState() => _AutenticacionState();
}

class _AutenticacionState extends State<Autenticacion>
{
  late String valorEstadoAutenticacion;

  @override
  void initState()
  {
    super.initState();

    valorEstadoAutenticacion = "AutenticacionlbNoAutenticado";
  }

  @override
  Widget build(BuildContext context)
  {
    return ScaffoldBase(
      barraSuperior: traduccion(context, 'AutenticacionlbAutenticar'),
      cuerpo: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: separacion),
              child: Text(traduccion(context, valorEstadoAutenticacion)),
            ),
            BotonPrimario(traduccion(context, 'AutenticacionbtnComenzar'), _comenzarAutenticacion)
          ],
        ),
      ),
    );
  }

  Future<void> _comenzarAutenticacion() async
  {
    IniciarAutenticacionUseCase iniciarAutenticacionUseCase = IniciarAutenticacionUseCase(Autenticar(context));
    bool resultado = await iniciarAutenticacionUseCase.invoke();

    if (resultado)
    {
      valorEstadoAutenticacion = 'AutenticacionlbAutenticado';
    }
  }
}