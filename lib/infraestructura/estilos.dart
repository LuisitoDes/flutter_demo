import 'package:flutter_demo/infraestructura/colores.dart';
import 'package:flutter_demo/infraestructura/medidas.dart';
import 'package:flutter/material.dart';

ButtonStyle estiloBotonPrincipal = ElevatedButton.styleFrom(
    textStyle: const TextStyle(fontSize: tamanioLetra),
    minimumSize: const Size(altoBoton, altoBoton),
    backgroundColor: Colores.principal
);

TextStyle estiloTituloBarraSuperior = const TextStyle(
    fontSize: tamanioLetra,
    color: Colores.textoBarraSuperior, 
    fontWeight: FontWeight.bold
);

TextStyle estiloTextoPantallaError = const TextStyle(
    fontSize: tamanioLetra,
    color: Colores.textoPrincipal,
    fontWeight: FontWeight.bold
);