import 'package:flutter_demo/dominio/i_autenticar.dart';

class ComprobarPosibleAutenticacion
{
  IAutenticar autenticar;

  ComprobarPosibleAutenticacion(this.autenticar);

  Future<bool> invoke() async
  {
    return await autenticar.puedeAutenticarseConBiometria();
  }
}