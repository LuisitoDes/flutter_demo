import 'package:flutter_demo/aplicacion/dispositivo/obtener_idiomas_soportados_use_case.dart';
import 'package:flutter_demo/infraestructura/paginas.dart';
import 'package:flutter_demo/infraestructura/dispositivo/traducciones.dart';
import 'package:flutter_demo/infraestructura/ui/autenticacion.dart';
import 'package:flutter_demo/infraestructura/ui/escaner_codigo_barras.dart';
import 'package:flutter_demo/infraestructura/ui/inicio.dart';
import 'package:flutter_demo/infraestructura/ui/menu_principal.dart';
import 'package:flutter_demo/infraestructura/ui/visor_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FlutterDemoApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: const PantallaInicio(),
      supportedLocales: _obtenerIdiomasSoportados(),
      localizationsDelegates: const [
        Traducciones.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routes:
      {
        splash: (context) => const PantallaInicio(),
        menu: (context) => const MenuPrincipal(),
        visor: (context) => const VisorWeb(),
        escanerCodigoBarras: (context) => const EscanerCodigoBarras(),
        autenticar: (context) => const Autenticacion()
      },
    );
  }

  List<Locale> _obtenerIdiomasSoportados()
  {
    List<String> idiomasApp = ObtenerIdiomasSoportadosUseCase().invoke();

    List<Locale> listaIdiomasSoportados = [];
    idiomasApp.forEach((element)
    {
      listaIdiomasSoportados.add(Locale(element));
    });

    return listaIdiomasSoportados;
  }
}

String traduccion(BuildContext context, String clave)
{
  return Traducciones.of(context).traducir(clave);
}