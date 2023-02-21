import 'package:flutter/scheduler.dart';
import 'package:flutter_demo/aplicacion/obtener_url_visor_web_use_case.dart';
import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter_demo/infraestructura/dispositivo.dart';
import 'package:flutter_demo/infraestructura/traducciones.dart';
import 'package:flutter_demo/infraestructura/widgets/cargando.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VisorWeb extends StatefulWidget
{
  const VisorWeb({super.key});

  @override
  State<VisorWeb> createState() => _VisorWebState();
}

class _VisorWebState extends State<VisorWeb>
{
  late WebViewController controller;
  String error = "";
  bool mostrarNavegador = false;
  
  @override
  void initState()
  {
    super.initState();

    controller = configurarControlador();

    SchedulerBinding.instance.addPostFrameCallback((_) => _iniciarNavegacion());
  }

  @override
  Widget build(BuildContext context)
  {
    Widget scaffold = ScaffoldBase(
      barraSuperior: Traducciones.of(context).traducir('Visorlbvisor'),
      cuerpo: Center(
        child: Cargando(),
      ),
      error: error,
    );

    if (mostrarNavegador)
    {
      scaffold = WillPopScope(onWillPop: _onWillPop,
          child: ScaffoldBase(
            barraSuperior: Traducciones.of(context).traducir('Visorlbvisor'),
            error: error,
            cuerpo: WebViewWidget(
              controller: controller,
            ),
          )
      );
    }
    return scaffold;
  }

  Future<void> _iniciarNavegacion() async
  {
    ObtenerUrlVisorWebUseCase obtenerUrlVisorWebUseCase = ObtenerUrlVisorWebUseCase(Dispositivo());
    String urlPortal = await obtenerUrlVisorWebUseCase.invoke();

    if (urlPortal.isNotEmpty)
    {
      controller.loadRequest(Uri.parse(urlPortal));
      mostrarNavegador = true;
    }
    else
    {
      error = Traducciones.of(context).traducir('VisorlbNoHayConexion');
    }
    setState(() {});
  }
  
  WebViewController configurarControlador()
  {
    WebViewController wc = WebViewController();
    wc.setJavaScriptMode(JavaScriptMode.unrestricted);
    wc.setBackgroundColor(Colores.fondo);
    wc.setNavigationDelegate(configurarNavegador());

    return wc;
  }

  NavigationDelegate configurarNavegador()
  {
    NavigationDelegate navigationDelegate = NavigationDelegate(
      onPageStarted: onPageStarted,
      onPageFinished: onPageFinished
    );

    return navigationDelegate;
  }

  Future<bool> _onWillPop() async
  {
    bool volver = true;

    if (await controller.canGoBack())
    {
      controller.goBack();
      volver = !volver;
    }

    return volver;
  }


  void onPageStarted(String url)
  {
    print("OnPageStarted -> " + url);
  }

  void onPageFinished(String url)
  {
    print("OnPageFinished -> " + url);
  }
}