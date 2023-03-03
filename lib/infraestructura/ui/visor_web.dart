import 'package:flutter_demo/aplicacion/portal/obtener_url_visor_web_use_case.dart';
import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter_demo/infraestructura/dispositivo/dispositivo.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos_disponibles.dart';
import 'package:flutter_demo/infraestructura/portal/navegador.dart';
import 'package:flutter_demo/infraestructura/widgets/cargando.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class VisorWeb extends StatefulWidget
{
  const VisorWeb({super.key});

  @override
  State<VisorWeb> createState() => _VisorWebState();
}

class _VisorWebState extends State<VisorWeb>
{
  Navegador navegador = Navegador();
  String error = "";
  String urlPortal = "";
  
  @override
  void initState()
  {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) => _iniciarNavegacion());

    _agregarListenerEventos();
  }

  @override
  Widget build(BuildContext context)
  {
    Widget scaffold = ScaffoldBase(
      barraSuperior: traduccion(context, 'Visorlbvisor'),
      cuerpo: Center(
        child: Cargando(),
      ),
      error: error,
    );

    if (urlPortal.isNotEmpty)
    {
      scaffold = WillPopScope(onWillPop: _onWillPop,
          child: ScaffoldBase(
            barraSuperior: traduccion(context, 'Visorlbvisor'),
            error: error,
            cuerpo: navegador.obtenerNavegador(urlPortal),
          )
      );
    }
    return scaffold;
  }

  Future<void> _iniciarNavegacion() async
  {
    ObtenerUrlVisorWebUseCase obtenerUrlVisorWebUseCase = ObtenerUrlVisorWebUseCase(Dispositivo(), navegador);
    urlPortal = await obtenerUrlVisorWebUseCase.invoke();

    if (urlPortal.isEmpty)
    {
      error = traduccion(context, 'VisorlbNoHayConexion');
    }

    setState(() {});
  }

  Future<bool> _onWillPop() async
  {
    bool volver = true;

    if (await navegador.atras())
    {
      volver = !volver;
    }

    return volver;
  }

  void _agregarListenerEventos()
  {
    eventoEnvioUrlInicio.subscribe((args)
    {
      print("OnPageStarted -> " + args!.valor);
    });

    eventoEnvioUrlFin.subscribe((args)
    {
      print("OnPageFinished -> " + args!.valor);
    });
  }
}