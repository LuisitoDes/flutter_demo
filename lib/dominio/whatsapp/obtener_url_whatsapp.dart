import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';

class ObtenerUrlWhatsapp
{
  IDispositivo dispositivo;

  ObtenerUrlWhatsapp(this.dispositivo);

  Future<String> invoke(String telefono) async
  {
    String urlW = "whatsapp://send?phone=+34";

    if (await dispositivo.esIos())
    {
      urlW = "https://api.whatsapp.com/send?phone=+34";
    }

    urlW += telefono;

    return urlW;
  }
}