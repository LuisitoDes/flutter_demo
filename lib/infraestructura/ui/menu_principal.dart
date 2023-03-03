import 'package:flutter_demo/infraestructura/widgets/menu_lateral.dart';
import 'package:flutter_demo/infraestructura/widgets/png_visor.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:flutter/material.dart';

class MenuPrincipal extends StatefulWidget
{
  const MenuPrincipal({super.key});

  @override
  State<MenuPrincipal> createState() => _MenuPrincipalState();
}

class _MenuPrincipalState extends State<MenuPrincipal>
{
  @override
  Widget build(BuildContext context)
  {
    return ScaffoldBase(
      menuLateral: MenuLateral(),
      cuerpo: SizedBox(
        width: double.infinity,
        child: Center(
          child: PngVisor('logo'),
        ),
      ),
    );
  }
}