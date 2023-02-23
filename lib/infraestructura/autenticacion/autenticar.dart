import 'package:flutter_demo/dominio/autenticacion/i_autenticar.dart';
import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class Autenticar implements IAutenticar
{
  final LocalAuthentication authentication = LocalAuthentication();
  BuildContext context;

  Autenticar(this.context);

  @override
  Future<bool> puedeAutenticarseConBiometria() async
  {
    return await authentication.canCheckBiometrics || await authentication.isDeviceSupported();
  }

  @override
  Future<bool> autenticarUsuario() async
  {
    bool autenticado = await authentication.authenticate(
      localizedReason: traduccion(context, 'AutenticarlbExplicacion'),
      authMessages: [
        construirMensajeAndroid(),
        construirMensajeIos()
      ],
      options: const AuthenticationOptions(useErrorDialogs: true)
    );

    return autenticado;
  }

  AndroidAuthMessages construirMensajeAndroid()
  {
    return AndroidAuthMessages(
      signInTitle: traduccion(context, 'AutenticarlbMensaje'),
      cancelButton: traduccion(context, 'AutenticarbtnCancelar')
    );
  }

  IOSAuthMessages construirMensajeIos()
  {
    return IOSAuthMessages(
        cancelButton: traduccion(context, 'AutenticarbtnCancelar')
    );
  }

}