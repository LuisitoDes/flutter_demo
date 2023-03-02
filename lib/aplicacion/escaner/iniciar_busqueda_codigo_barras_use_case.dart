import 'package:flutter_demo/dominio/escaner/comprobar_permisos_camara.dart';
import 'package:flutter_demo/dominio/escaner/iniciar_busqueda_codigo_barras.dart';
import 'package:flutter_demo/dominio/escaner/i_escaner.dart';
import 'package:flutter_demo/dominio/escaner/obtener_camara_disponible.dart';
import 'package:flutter_demo/dominio/escaner/solicitar_permisos_camara.dart';

class IniciarBusquedaCodigoBarrasUseCase
{
  late ComprobarPermisosCamara comprobarPermisosCamara;
  late SolicitarPermisosCamara solicitarPermisos;
  late ObtenerCamaraDisponible obtenerCamaraDisponible;
  late ConfigurarEscaner configurarEscaner;

  IniciarBusquedaCodigoBarrasUseCase(IEscaner escaner)
  {
    comprobarPermisosCamara = ComprobarPermisosCamara(escaner);
    solicitarPermisos = SolicitarPermisosCamara(escaner);
    obtenerCamaraDisponible = ObtenerCamaraDisponible(escaner);
    configurarEscaner = ConfigurarEscaner(escaner);
  }

  Future<void> invoke() async
  {
    bool tienePermiso = await comprobarPermisosCamara.invoke();

    if (!tienePermiso)
    {
      tienePermiso = await solicitarPermisos.invoke();
    }

    var camara = await obtenerCamaraDisponible.invoke();

    if (camara != null)
    {
      await configurarEscaner.invoke(camara);
    }
  }
}