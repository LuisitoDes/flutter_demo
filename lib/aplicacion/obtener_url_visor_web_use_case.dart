import 'package:flutter_demo/dominio/comprobar_conexion_internet.dart';
import 'package:flutter_demo/dominio/i_dispositivo.dart';
import 'package:flutter_demo/dominio/obtener_url_portal_seguros.dart';

class ObtenerUrlVisorWebUseCase
{
  late ComprobarConexionInternet comprobarConexionInternet;
  
  ObtenerUrlVisorWebUseCase(IDispositivo dispositivo)
  {
    comprobarConexionInternet = ComprobarConexionInternet(dispositivo);
  }

  Future<String> invoke() async
  {
    String urlPortal = "";

    if (await comprobarConexionInternet.invoke())
    {
      urlPortal = ObtenerUrlPortalSeguros().invoke();
    }

    return urlPortal;
  }
}