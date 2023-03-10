import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo/dominio/escaner/i_escaner.dart';
import 'package:flutter_demo/infraestructura/eventos/codigo_barras.dart';
import 'package:flutter_demo/infraestructura/eventos/eventos_disponibles.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';
import 'package:permission_handler/permission_handler.dart';

class Escaner extends IEscaner
{
  CameraController ?controlador;
  CameraDescription ?camera;
  late BarcodeScanner escaner;

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
    try
    {
      escaner = BarcodeScanner(formats: [BarcodeFormat.all]);
    }
    catch(exception)
    {

    }
  }

  @override
  Future<void> detenerServicioEscaner() async
  {
    try
    {
      await escaner.close();
      await controlador!.stopImageStream();
    }
    catch(exception)
    {

    }
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
    if (bloqueado) return;
    bloqueado = true;

    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes
        .done()
        .buffer
        .asUint8List();

    final Size imageSize = Size(image.width.toDouble(), image.height.toDouble());

    final camera = await obtenerCamaraDisponible();
    final imageRotation = InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat = InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    List<InputImagePlaneMetadata> listaPlaneData = [];

    image.planes.map((Plane plane)
    {
        listaPlaneData.add(InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        ));
      },
    );

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: listaPlaneData,
    );

    final inputImage = InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);
    final barcodes = await escaner.processImage(inputImage);

    String barcode = "";

    for (int i = 0; i < barcodes.length; i++)
    {
      if (barcodes[i].displayValue != null)
      {
        barcode = barcodes[i].displayValue!;
        await escaner.close();
        i = barcodes.length;
      }
    }
    if (barcode.isNotEmpty)
    {
      eventoCodigoBarras.broadcast(CodigoBarras(barcode));
    }
    else
    {
      bloqueado = false;
    }
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