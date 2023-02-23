import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class DetenerBusquedaCodigoBarras
{
  IEscaner escaner;

  DetenerBusquedaCodigoBarras(this.escaner);

  Future<void> invoke() async
  {
    await escaner.detenerServicioEscaner();
  }
}