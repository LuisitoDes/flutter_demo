import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class SolicitarPermisosCamara
{
  IEscaner escaner;

  SolicitarPermisosCamara(this.escaner);

  Future<bool> invoke() async
  {
    return await escaner.pedirPermisos();
  }
}