import 'package:flutter_demo/dominio/escaner/detener_busqueda_codigo_barras.dart';
import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class DetenerBusquedaCodigoBarrasUseCase
{
  late DetenerBusquedaCodigoBarras detenerBusquedaCodigoBarras;

  DetenerBusquedaCodigoBarrasUseCase(IEscaner escaner)
  {
    detenerBusquedaCodigoBarras = DetenerBusquedaCodigoBarras(escaner);
  }

  Future<void> invoke() async
  {
    await detenerBusquedaCodigoBarras.invoke();
  }
}