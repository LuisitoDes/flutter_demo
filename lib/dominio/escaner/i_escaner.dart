abstract class IEscaner
{
  Future obtenerCamaraDisponible();

  Future crearControladorCamara(camara);

  Future<void> iniciarServicioEscaner();

  Future<void> detenerServicioEscaner();

  Future<bool> comprobarPermisos();

  Future<bool> pedirPermisos();
}