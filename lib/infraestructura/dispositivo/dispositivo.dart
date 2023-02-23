import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_demo/dominio/dispositivo/i_dispositivo.dart';

class Dispositivo implements IDispositivo
{
  @override
  Future<bool> esAndroid() async
  {
    return Platform.isAndroid;
  }

  @override
  Future<bool> esIos() async
  {
    return Platform.isIOS;
  }

  @override
  Future<bool> tieneConexionInternet() async
  {
    final resultadoConexion = await Connectivity().checkConnectivity();

    return resultadoConexion == ConnectivityResult.mobile || resultadoConexion == ConnectivityResult.wifi;
  }


}