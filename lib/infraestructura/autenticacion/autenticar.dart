import 'package:flutter_demo/dominio/i_autenticar.dart';
import 'package:flutter_demo/infraestructura/traducciones.dart';
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
      localizedReason: Traducciones.of(context).traducir('AutenticarlbExplicacion'),
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
      signInTitle: Traducciones.of(context).traducir('AutenticarlbMensaje'),
      cancelButton: Traducciones.of(context).traducir('AutenticarbtnCancelar')
    );
  }

  IOSAuthMessages construirMensajeIos()
  {
    return IOSAuthMessages(
        cancelButton: Traducciones.of(context).traducir('AutenticarbtnCancelar')
    );
  }

}