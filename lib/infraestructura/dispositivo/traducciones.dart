import 'dart:convert';

import 'package:flutter_demo/aplicacion/dispositivo/obtener_idiomas_soportados_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Traducciones
{
  final Locale locale;
  late Map<String, String> _listadoTextos;

  Traducciones(this.locale);

  static Traducciones of(BuildContext context)
  {
    return Localizations.of(context, Traducciones);
  }

  static const LocalizationsDelegate<Traducciones> delegate = _TraduccionesDelegate();

  Future<bool> load() async
  {
    String jsonString = await rootBundle.loadString('lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _listadoTextos = jsonMap.map((key, value)
    {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  String traducir(String key)
  {
    String texto = key;

    if (_listadoTextos.containsKey(key))
    {
      texto = _listadoTextos[key]!;
    }

    return texto;
  }
}

class _TraduccionesDelegate extends LocalizationsDelegate<Traducciones>
{
  const _TraduccionesDelegate();

  @override
  Future<Traducciones> load(Locale locale) async
  {
    Traducciones traducciones = Traducciones(locale);
    await traducciones.load();
    return traducciones;
  }

  @override
  bool shouldReload(_TraduccionesDelegate old) => false;

  @override
  bool isSupported(Locale locale)
  {
    return ObtenerIdiomasSoportadosUseCase().invoke().contains(locale.languageCode);
  }
}