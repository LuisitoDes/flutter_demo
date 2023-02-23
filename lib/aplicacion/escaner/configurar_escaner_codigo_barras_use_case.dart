import 'package:flutter_demo/dominio/escaner/configurar_escaner.dart';
import 'package:flutter_demo/dominio/escaner/i_escaner.dart';
import 'package:flutter_demo/dominio/escaner/obtener_camara_disponible.dart';

class ConfigurarEscanerCodigoBarrasUseCase
{
  late ObtenerCamaraDisponible obtenerCamaraDisponible;
  late ConfigurarEscaner configurarEscaner;

  ConfigurarEscanerCodigoBarrasUseCase(IEscaner escaner)
  {
    obtenerCamaraDisponible = ObtenerCamaraDisponible(escaner);
    configurarEscaner = ConfigurarEscaner(escaner);
  }

  Future<void> invoke() async
  {
    var camara = await obtenerCamaraDisponible.invoke();

    if (camara != null)
    {
      await configurarEscaner.invoke(camara);
    }
  }
}