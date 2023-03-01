import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';

class ObtenerUrlWhatsapp
{
  IDispositivo dispositivo;

  ObtenerUrlWhatsapp(this.dispositivo);

  Future<String> invoke() async
  {
    String urlW = "whatsapp://send?phone=+34637578823&text=Hello World!";

    if (await dispositivo.esIos())
    {
      urlW = "https://api.whatsapp.com/send?phone=+34637578823";
    }

    return urlW;
  }
}