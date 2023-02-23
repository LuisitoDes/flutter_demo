import 'package:flutter_demo/aplicacion/escaner/configurar_escaner_codigo_barras_use_case.dart';
import 'package:flutter_demo/aplicacion/escaner/detener_busqueda_codigo_barras_use_case.dart';
import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter_demo/infraestructura/escaner/escaner.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos_disponibles.dart';
import 'package:flutter_demo/infraestructura/widgets/cargando.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class EscanerCodigoBarras extends StatefulWidget
{
  const EscanerCodigoBarras({super.key});

  @override
  State<EscanerCodigoBarras> createState() => _EscanerCodigoBarrasState();
}

class _EscanerCodigoBarrasState extends State<EscanerCodigoBarras>
{
  Escaner escaner = Escaner();
  bool ocupado = false;

  @override
  void initState()
  {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) => cargarEscanerCodigoBarras());

    _agregarListenerEventos();
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = ScaffoldBase(
        barraSuperior: traduccion(context, 'EscanerlbEscaner'),
        cuerpo: Center(
          child: Cargando(),
        )
    );

    if (escaner.getWidgetCamera() != null)
    {
      scaffold = ScaffoldBase(
          barraSuperior: traduccion(context, 'EscanerlbEscaner'),
          cuerpo: escaner.getWidgetCamera()
      );
    }

    return scaffold;
  }

  Future<void> cargarEscanerCodigoBarras() async
  {
    ConfigurarEscanerCodigoBarrasUseCase configurarEscanerCodigoBarrasUseCase = ConfigurarEscanerCodigoBarrasUseCase(escaner);
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