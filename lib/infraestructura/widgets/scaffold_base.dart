import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter_demo/infraestructura/estilos.dart';
import 'package:flutter_demo/infraestructura/medidas.dart';
import 'package:flutter_demo/infraestructura/paginas.dart';
import 'package:flutter_demo/infraestructura/traducciones.dart';
import 'package:flutter_demo/infraestructura/widgets/boton_primario.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ScaffoldBase extends StatelessWidget
{
  String ?barraSuperior;
  Widget ?cuerpo;
  Widget ?menuLateral;
  String ?error;

  ScaffoldBase({this.barraSuperior, this.cuerpo, this.menuLateral, this.error});

  @override
  Widget build(BuildContext context)
  {
    cuerpo ??= Container();

    Scaffold scaffold = Scaffold(
      body: cuerpo,
    );

    if (error != null && error!.isNotEmpty)
    {
      barraSuperior ??= Traducciones.of(context).traducir("ApplbNombre");
      return Scaffold(
          appBar: construirBarraSuperior(barraSuperior!),
          body: Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Padding(
                  padding: EdgeInsets.only(bottom: separacionPantallaError),
                  child: Text(error!, style: estiloTextoPantallaError),
                ),
                BotonPrimario(Traducciones.of(context).traducir('MenubtnReintentar'), ()
                {
                  recargarInicio(context);
                })
              ],
            ),
          )
      );
    }

    if (barraSuperior != null && menuLateral == null)
    {
      scaffold = Scaffold(
          appBar: construirBarraSuperior(barraSuperior!),
          body: cuerpo
      );
    }

    if (menuLateral != null)
    {
      barraSuperior ??= Traducciones.of(context).traducir("ApplbNombre");
      scaffold = Scaffold(
          appBar: construirBarraSuperior(barraSuperior!),
          drawer: menuLateral,
          drawerDragStartBehavior: DragStartBehavior.down,
          endDrawerEnableOpenDragGesture: true,
          body: cuerpo
      );
    }

    return scaffold;
  }

  AppBar construirBarraSuperior(String titulo)
  {
    return AppBar(
        centerTitle: true,
        title: Text(titulo, style: estiloTituloBarraSuperior),
        backgroundColor: Colores.principal,
        titleTextStyle: estiloTituloBarraSuperior
    );
  }

  void recargarInicio(BuildContext context)
  {
    Navigator.of(context).pushNamedAndRemoveUntil(menu, (route) => false);
  }
}