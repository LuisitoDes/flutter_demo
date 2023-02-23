import 'package:flutter_demo/infraestructura/eventos/eventos_argumento.dart';

class CodigoBarras extends EventArgs
{
  String _valor;

  CodigoBarras(this._valor);

  String get valor => _valor;
}