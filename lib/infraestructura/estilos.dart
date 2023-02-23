import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter_demo/infraestructura/dispositivo/medidas.dart';
import 'package:flutter/material.dart';

ButtonStyle estiloBotonPrincipal = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: tamanioLetra),
    minimumSize: const Size(altoBoton, altoBoton),
    backgroundColor: Colores.principal
);

TextStyle estiloTituloBarraSuperior = EstiloTextoBase(tamanioLetra, Colores.textoBarraSuperior);

TextStyle estiloTextoPantallaError = EstiloTextoBase(tamanioLetra, Colores.textoPrincipal);

class EstiloTextoBase extends TextStyle
{
  EstiloTextoBase(double tamanioLetra, colorPrincipal) :
        super(fontSize: tamanioLetra, color: colorPrincipal, fontWeight: FontWeight.bold);
}