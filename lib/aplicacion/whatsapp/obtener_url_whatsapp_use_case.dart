import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';
import 'package:flutter_demo/dominio/whatsapp/obtener_url_whatsapp.dart';

class ObtenerUrlWhatsappUseCase
{
  late ObtenerUrlWhatsapp obtenerUrlWhatsapp;

  ObtenerUrlWhatsappUseCase(IDispositivo dispositivo)
  {
    obtenerUrlWhatsapp = ObtenerUrlWhatsapp(dispositivo);
  }

  Future<String> invoke(String telefono) async
  {
    return await obtenerUrlWhatsapp.invoke(telefono);
  }
}