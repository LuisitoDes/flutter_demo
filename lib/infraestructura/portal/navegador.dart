import 'package:flutter/material.dart';
import 'package:flutter_demo/dominio/portal/i_navegador.dart';
import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter_demo/infraestructura/eventos/envio_url_fin.dart';
import 'package:flutter_demo/infraestructura/eventos/envio_url_inicio.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos_disponibles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Navegador implements INavegador
{
  late WebViewController webViewController;

  void configurarNavegador()
  {
    webViewController = WebViewController();
    webViewController.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController.setBackgroundColor(Colores.fondo);
    webViewController.clearCache();

    NavigationDelegate navigationDelegate = NavigationDelegate(
        onPageStarted: onPageStarted,
        onPageFinished: onPageFinished
    );

    webViewController.setNavigationDelegate(navigationDelegate);
  }

  void onPageStarted(String url)
  {
    eventoEnvioUrlInicio.broadcast(EnvioUrlInicio(url));
  }

  void onPageFinished(String url)
  {
    eventoEnvioUrlFin.broadcast(EnvioUrlFin(url));
  }

  Widget obtenerNavegador(String url)
  {
    webViewController.loadRequest(Uri.parse(url));
    return WebViewWidget(
      controller: webViewController,
    );
  }

  Future<bool> atras() async
  {
    bool resultado = false;

    if (await webViewController.canGoBack())
    {
      webViewController.goBack();

      resultado = !resultado;
    }

    return resultado;
  }
}