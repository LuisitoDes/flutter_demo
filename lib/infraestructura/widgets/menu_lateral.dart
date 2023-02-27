import 'package:flutter_demo/infraestructura/app.dart';
import 'package:flutter_demo/infraestructura/dispositivo/medidas.dart';
import 'package:flutter_demo/infraestructura/paginas.dart';
import 'package:flutter_demo/infraestructura/widgets/boton_con_icono.dart';
import 'package:flutter_demo/infraestructura/widgets/png_visor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MenuLateral extends Drawer
{
  late BuildContext context;

  @override
  Drawer build(BuildContext context)
  {
    this.context = context;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(separacion),
        children: [
          DrawerHeader(
              child: PngVisor('logo')
          ),
          BotonMenuLateral(traduccion(context, 'MenubtnEscaner'), Icons.barcode_reader, _accederCamara),
          BotonMenuLateral(traduccion(context, 'MenubtnWhatsapp'), Icons.message, _enviarWhatsapp),
          BotonMenuLateral(traduccion(context, 'MenubtnAcceder'), Icons.person, _accederPortal),
          BotonMenuLateral(traduccion(context, 'MenubtnAutenticar'), Icons.security, _autenticar)
        ],
      ),
    );
  }

  void _accederCamara()
  {
    Navigator.pushNamed(context, escanerCodigoBarras);
  }

  Future<void> _enviarWhatsapp() async
  {
    await launchUrlString("https://wa.me/15551234567?text=I'm%20interested%20in%20your%20car%20for%20sale");
  }

  void _accederPortal()
  {
    Navigator.pushNamed(context, visor);
  }

  void _autenticar()
  {
    Navigator.pushNamed(context, autenticar);
  }
}