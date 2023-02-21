abstract class IAutenticar
{
  Future<bool> puedeAutenticarseConBiometria();

  Future<bool> autenticarUsuario();
}