import 'package:flutter_demo/dominio/portal/i_navegador.dart';

class ConfigurarNavegador
{
  INavegador navegador;

  ConfigurarNavegador(this.navegador);

  void invoke()
  {
    navegador.configurarNavegador();
  }
}