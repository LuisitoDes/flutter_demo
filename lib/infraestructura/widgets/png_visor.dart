import 'package:flutter/material.dart';

class PngVisor extends StatelessWidget
{
  String nombreFichero;
  
  PngVisor(this.nombreFichero);

  @override
  Widget build(BuildContext context) 
  {
    return Image.asset("assets/images/" + nombreFichero + ".png");
  }
  
  
  
  
}