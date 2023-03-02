import 'package:flutter_demo/infraestructura/eventos/eventos_argumento.dart';

class EnvioUrlInicio extends EventArgs
{
  String _valor;

  EnvioUrlInicio(this._valor);

  String get valor => _valor;
}