import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class ComprobarPermisosCamara
{
  IEscaner escaner;

  ComprobarPermisosCamara(this.escaner);

  Future<bool> invoke() async
  {
    return await escaner.comprobarPermisos();
  }
}