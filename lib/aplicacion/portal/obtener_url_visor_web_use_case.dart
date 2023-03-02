import 'package:flutter_demo/dominio/dispositivo/comprobar_conexion_internet.dart';
import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';
import 'package:flutter_demo/dominio/portal/configurar_navegador.dart';
import 'package:flutter_demo/dominio/portal/i_navegador.dart';
import 'package:flutter_demo/dominio/portal/obtener_url_portal_seguros.dart';

class ObtenerUrlVisorWebUseCase
{
  late ComprobarConexionInternet comprobarConexionInternet;
  late ConfigurarNavegador configurarNavegador;
  late ObtenerUrlPortalSeguros obtenerUrlPortalSeguros;
  
  ObtenerUrlVisorWebUseCase(IDispositivo dispositivo, INavegador navegador)
  {
    comprobarConexionInternet = ComprobarConexionInternet(dispositivo);
    configurarNavegador = ConfigurarNavegador(navegador);
    obtenerUrlPortalSeguros = ObtenerUrlPortalSeguros();
  }

  Future<String> invoke() async
  {
    String urlPortal = "";

    if (await comprobarConexionInternet.invoke())
    {
      configurarNavegador.invoke();

      urlPortal = obtenerUrlPortalSeguros.invoke();
    }

    return urlPortal;
  }
}