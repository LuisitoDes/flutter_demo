import 'package:flutter_demo/dominio/autenticacion/i_autenticar.dart';

class AutenticarUsuario
{
  IAutenticar autenticar;

  AutenticarUsuario(this.autenticar);

  Future<bool> invoke() async
  {
    return await autenticar.autenticarUsuario();
  }
}