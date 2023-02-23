import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';

class ComprobarConexionInternet
{
  IDispositivo iDispositivo;

  ComprobarConexionInternet(this.iDispositivo);

  Future<bool> invoke() async
  {
    return await iDispositivo.tieneConexionInternet();
  }
}