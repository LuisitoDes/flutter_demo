import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/dominio/escaner/i_escaner.dart';
import 'package:permission_handler/permission_handler.dart';

class Escaner extends IEscaner
{
  CameraController ?controlador;
  CameraDescription ?camera;

  bool bloqueado = false;

  @override
  Future obtenerCamaraDisponible() async
  {
    List<CameraDescription> camaras = await availableCameras();
    CameraDescription ?camara;

    if (camaras.isNotEmpty)
    {
      camara = camaras[0];
    }

    return camara;
  }

  @override
  Future<void> iniciarServicioEscaner() async
  {

  }

  @override
  Future<void> detenerServicioEscaner() async
  {

  }

  @override
  Future crearControladorCamara(camara) async
  {
    controlador = CameraController(
        camara,
        ResolutionPreset.medium,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420
    );

    await controlador!.initialize().then((_)
    {
      controlador!.startImageStream(_procesarImagenes);
    }).catchError((Object e) {

    });
  }

  Future<void> _procesarImagenes(image) async
  {

  }

  Widget? getWidgetCamara()
  {
    Widget ?camara;

    if (controlador != null)
    {
      camara = CameraPreview(controlador!);
    }

    return camara;
  }

  @override
  Future<bool> comprobarPermisos() async
  {
    PermissionStatus estado = await Permission.camera.status;
    return estado.isGranted;
  }

  @override
  Future<bool> pedirPermisos() async
  {
    PermissionStatus estado = await Permission.camera.request();
    return estado.isGranted;
  }
}