import 'package:flutter_demo/infraestructura/eventos/eventos_argumento.dart';

class EnvioUrlFin extends EventArgs
{
  String _valor;

  EnvioUrlFin(this._valor);

  String get valor => _valor;
}