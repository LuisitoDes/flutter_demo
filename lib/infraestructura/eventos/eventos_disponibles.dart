import 'package:flutter_demo/infraestructura/eventos/codigo_barras.dart';
import 'package:flutter_demo/infraestructura/eventos/envio_url_fin.dart';
import 'package:flutter_demo/infraestructura/eventos/envio_url_inicio.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos.dart';

final eventoCodigoBarras = Event<CodigoBarras>();
final eventoEnvioUrlInicio = Event<EnvioUrlInicio>();
final eventoEnvioUrlFin = Event<EnvioUrlFin>();