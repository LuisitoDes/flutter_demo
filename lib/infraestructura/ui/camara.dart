import 'package:flutter_demo/aplicacion/escaner/iniciar_busqueda_codigo_barras_use_case.dart';
import 'package:flutter_demo/aplicacion/escaner/detener_busqueda_codigo_barras_use_case.dart';
import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter_demo/infraestructura/escaner/escaner.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos_disponibles.dart';
import 'package:flutter_demo/infraestructura/widgets/cargando.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Camara extends StatefulWidget
{
  const Camara({super.key});

  @override
  State<Camara> createState() => _CamaraState();
}

class _CamaraState extends State<Camara>
{
  Escaner escaner = Escaner();
  bool ocupado = false;

  @override
  void initState()
  {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) => cargarCamara());

    _agregarListenerEventos();
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = ScaffoldBase(
        barraSuperior: traduccion(context, 'CamaralbEscaner'),
        cuerpo: Center(
          child: Cargando(),
        )
    );

    if (escaner.getWidgetCamara() != null)
    {
      scaffold = ScaffoldBase(
          barraSuperior: traduccion(context, 'CamaralbEscaner'),
          cuerpo: escaner.getWidgetCamara()
      );
    }

    return scaffold;
  }

  Future<void> cargarCamara() async
  {
    IniciarBusquedaCodigoBarrasUseCase configurarEscanerCodigoBarrasUseCase = IniciarBusquedaCodigoBarrasUseCase(escaner);
    await configurarEscanerCodigoBarrasUseCase.invoke();

    setState(() {});
  }

  void _agregarListenerEventos()
  {
    eventoCodigoBarras.subscribe((args)
    {
      _mostrarCodigoBarras(args!.valor);
    });
  }

  void _mostrarCodigoBarras(String valorCodigoBarras)
  {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Código detectado : " + valorCodigoBarras)));
  }

  @override
  Future<void> dispose() async
  {
    super.dispose();
    DetenerBusquedaCodigoBarrasUseCase detenerBusquedaCodigoBarrasUseCase = DetenerBusquedaCodigoBarrasUseCase(escaner);
    await detenerBusquedaCodigoBarrasUseCase.invoke();
  }

}