abstract class IDispositivo
{
  Future<bool> tieneConexionInternet();

  Future<bool> esAndroid();

  Future<bool> esIos();
}