import 'package:flutter_demo/dominio/autenticacion/autenticar_usuario.dart';
import 'package:flutter_demo/dominio/autenticacion/comprobar_posible_autenticacion.dart';
import 'package:flutter_demo/dominio/autenticacion/i_autenticar.dart';

class IniciarAutenticacionUseCase
{
  late ComprobarPosibleAutenticacion comprobarPosibleAutenticacion;
  late AutenticarUsuario autenticarUsuario;

  IniciarAutenticacionUseCase(IAutenticar autenticar)
  {
    comprobarPosibleAutenticacion = ComprobarPosibleAutenticacion(autenticar);
    autenticarUsuario = AutenticarUsuario(autenticar);
  }

  Future<bool> invoke() async
  {
    bool resultado = false;

    if (await comprobarPosibleAutenticacion.invoke())
    {
      resultado = await autenticarUsuario.invoke();
    }

    return resultado;
  }
}