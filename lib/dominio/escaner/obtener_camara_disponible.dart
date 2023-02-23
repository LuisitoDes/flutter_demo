import 'package:flutter_demo/dominio/escaner/i_escaner.dart';

class ObtenerCamaraDisponible
{
  IEscaner escaner;

  ObtenerCamaraDisponible(this.escaner);

  Future invoke() async
  {
    return escaner.obtenerCamaraDisponible();
  }
}