import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';

class ObtenerUrlWhatsapp
{
  IDispositivo dispositivo;

  ObtenerUrlWhatsapp(this.dispositivo);

  Future<String> invoke() async
  {
    String urlW = "whatsapp://send?phone=+34637637637&text=Hello World!";

    if (await dispositivo.esIos())
    {
      urlW = "https://wa.me/+34637637637?text=${Uri.parse('Hi, I need some help')}";
    }

    return urlW;
  }
}