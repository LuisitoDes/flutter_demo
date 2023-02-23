import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class ConfigurarEscaner
{
  IEscaner escaner;

  ConfigurarEscaner(this.escaner);

  Future<void> invoke(camara) async
  {
    await escaner.crearControladorCamara(camara);

    await escaner.iniciarServicioEscaner();
  }
}