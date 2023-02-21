import 'package:flutter/services.dart';
import 'package:flutter_demo/infraestructura/traducciones.dart';
import 'package:flutter_demo/infraestructura/widgets/cargando.dart';
import 'package:flutter_demo/infraestructura/widgets/scaffold_base.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class EscanerCodigoBarras extends StatefulWidget
{
  const EscanerCodigoBarras({super.key});

  @override
  State<EscanerCodigoBarras> createState() => _EscanerCodigoBarrasState();
}

class _EscanerCodigoBarrasState extends State<EscanerCodigoBarras>
{
  List<CameraDescription> camarasDisponibles = [];
  CameraController ?cameraController;
  String error = "";
  bool ocupado = false;

  late BarcodeScanner escaner;

  @override
  void initState()
  {
    super.initState();

    escaner = BarcodeScanner(formats: [BarcodeFormat.all]);

    SchedulerBinding.instance.addPostFrameCallback((_) => cargarCamaras());
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = ScaffoldBase(
      barraSuperior: Traducciones.of(context).traducir('EscanerlbEscaner'),
      cuerpo: Center(
        child: Cargando(),
      ),
      error: error,
    );

    if (cameraController != null)
    {
      scaffold = ScaffoldBase(
          barraSuperior: Traducciones.of(context).traducir('EscanerlbEscaner'),
          cuerpo: CameraPreview(cameraController!),
          error: error
      );
    }

    return scaffold;
  }

  Future<void> cargarCamaras() async
  {
    await availableCameras().then((value) {
      camarasDisponibles = value;
      cameraController = configurarControlador();
    })
    .catchError((e) {
      error = e;
    });

    setState(() {});
  }

  CameraController configurarControlador() {
    CameraController cameraController = CameraController(
        camarasDisponibles[0],
        ResolutionPreset.high,
        enableAudio: false
    );

    cameraController.initialize().then((_) {
      if (!mounted) {
        return;
      }

      cameraController.startImageStream(_procesarImagenes);

      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        error = e.code;
        setState(() {});
      }
    });

    return cameraController;
  }

  Future<void> _procesarImagenes(CameraImage image) async
  {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in image.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes
        .done()
        .buffer
        .asUint8List();

    final Size imageSize =
    Size(image.width.toDouble(), image.height.toDouble());

    final camera = camarasDisponibles[0];
    final imageRotation =
    InputImageRotationValue.fromRawValue(camera.sensorOrientation);
    if (imageRotation == null) return;

    final inputImageFormat =
    InputImageFormatValue.fromRawValue(image.format.raw);
    if (inputImageFormat == null) return;

    final planeData = image.planes.map(
          (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation,
      inputImageFormat: inputImageFormat,
      planeData: planeData,
    );

    final inputImage =
    InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    _obtenerCodigoBarras(inputImage);
  }

  Future<void> _obtenerCodigoBarras(InputImage inputImage) async
  {
    if (ocupado) return;
    ocupado = true;

    final barcodes = await escaner.processImage(inputImage);

    for (int i = 0; i < barcodes.length; i++)
    {
      if (barcodes[i].displayValue != null)
      {
        await escaner.close();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Código detectado : " + barcodes[i].displayValue!)));
        i = barcodes.length;
      }
    }
  }

}