import 'package:flutter_demo/dominio/i_dispositivo.dart';

class ComprobarConexionInternet
{
  IDispositivo iDispositivo;

  ComprobarConexionInternet(this.iDispositivo);

  Future<bool> invoke() async
  {
    return await iDispositivo.tieneConexionInternet();
  }
}