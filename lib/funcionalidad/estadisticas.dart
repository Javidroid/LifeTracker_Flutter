import 'package:flutter/material.dart';
import 'package:life_tracker/funcionalidad/accion.dart';
import 'package:life_tracker/funcionalidad/elementos_estado_animo.dart';
import 'package:life_tracker/funcionalidad/formulario.dart';

import 'categoria.dart';

/// Clase que gestiona lo relacionado con las estadísticas de usuario para
/// facilitar la recopilación de datos en la BD y mostrar las estadisticas
/// del propio usuario
class Estadisticas {

  int nFormularios          = 0;
  Map <String, String> mapaMediables = {
  "Estado de ánimo" : "-",
  "Horas de sueño" : "-",
  "Calidad de sueño" : "-",
  "Autoestima" : "-",
  "Productividad" : "-",
  };
  Map <String, String> mapaMinMax = {
    "Mínimo Quehaceres" : "-",
    "Máximo Quehaceres" : "-",
    "Mínimo Comida" : "-",
    "Máximo Comida" : "-",
    "Mínimo Entretenimiento" : "-",
    "Máximo Entretenimiento" : "-",
    "Mínimo Tiempo" : "-",
    "Máximo Tiempo" : "-",
  };

  /// Atributos referentes a valores "mediables"
  /// mediaEstadoAnimo es String porque se redondea el valor al estado
  /// discreto más cercano
  /// Valores negativos significa que no hay datos
  String mediaEstadoAnimoStr  = "";
  double mediaEstadoAnimo     = 0;
  double mediaSueno           = 0;
  double mediaCalidadSueno    = 0;
  double mediaAutoestima      = 0;
  double mediaProductividad   = 0;

  /// Atributos referentes a valores mínimos/máximos
  String minQuehaceres = "";
  String maxQuehaceres = "";
  String minComida = "";
  String maxComida = "";
  String minEntretenimiento = "";
  String maxEntretenimiento = "";
  String minTiempo = "";
  String maxTiempo = "";

  // todo métodos:
    /*
      Calcular el número de formularios
      Calcular la media de ánimo
      Calcular la media de cada categoría mesurable
      De las categorías múltiples: calcular lo que más y lo que menos

     */

  void actualizarEstadisticas(List <Formulario> listaF){
    actualizarNumFormularios(listaF);

    actualizarMediaEstadoAnimo(listaF);
    actualizarMediaSueno(listaF);
    actualizarMediaCalidadSueno(listaF);
    actualizarMediaAutoestima(listaF);
    actualizarMediaProductividad(listaF);

    actualizarMinMaxQuehaceres(listaF);
    actualizarMinMaxComida(listaF);
    actualizarMinMaxEntretenimiento(listaF);
    actualizarMinMaxTiempo(listaF);

    _actualizarMapas(); //Actualizamos los mapas para poder mostrar los cambios
  }

  void _actualizarMapas(){
    if (mediaEstadoAnimo != -1){
      mapaMediables["Estado de ánimo"] = mediaEstadoAnimoStr + " (" + mediaEstadoAnimo.toStringAsFixed(1) + "/5)";
    } else {mapaMediables["Estado de ánimo"] = "Sin datos";}

    if (mediaSueno != -1) {
      mapaMediables["Horas de sueño"] = mediaSueno.toStringAsFixed(1) + " h aprox.";
    } else {mapaMediables["Horas de sueño"] = "Sin datos";}

    if(mediaCalidadSueno != -1){
      mapaMediables["Calidad de sueño"] = mediaCalidadSueno.toStringAsFixed(1) + "/5";
    } else {mapaMediables["Calidad de sueño"] = "Sin datos";}

    mapaMediables["Autoestima"]       = mediaAutoestima.toStringAsFixed(1);
    mapaMediables["Productividad"]    = mediaProductividad.toStringAsFixed(1);

    mapaMinMax["Mínimo Quehaceres"]       = minQuehaceres.toString();
    mapaMinMax["Máximo Quehaceres"]       = maxQuehaceres.toString();
    mapaMinMax["Mínimo Comida"]           = minComida.toString();
    mapaMinMax["Máximo Comida"]           = maxComida.toString();
    mapaMinMax["Mínimo Entretenimiento"]  = minEntretenimiento.toString();
    mapaMinMax["Máximo Entretenimiento"]  = maxEntretenimiento.toString();
    mapaMinMax["Mínimo Tiempo"]           = minTiempo.toString();
    mapaMinMax["Máximo Tiempo"]           = maxTiempo.toString();
  }
  /// Método para obtener el número de formularios
  void actualizarNumFormularios(List<Formulario> listForm){
    nFormularios = listForm.length;
  }

  /// Este método guarda el String asociado al numero entero
  /// más cercano a la media obtenida, además de guardar el número
  /// sin redondear para dar más detalles
  void actualizarMediaEstadoAnimo(List<Formulario> listForm){
    double media = 0;
    if(nFormularios > 0){
      double suma = 0;
      for (Formulario f in listForm) {
        suma += f.estadoAnimo;
      }
      media = suma/nFormularios;

      mediaEstadoAnimo = media;
      mediaEstadoAnimoStr = estadosAnimo[media.round()-1].nombre;
    }
    else {
      mediaEstadoAnimo = -1; // -1 significa sin datos
      mediaEstadoAnimoStr = "";
    }
  }

  /// Este método guarda la media de sueño teniendo en cuenta el index de cada
  /// acción de la categoría ¿Cuánto has dormido?. Siendo el valor asociado
  /// a cada Acción uno intermedio (para 1-3, tenemos en cuenta 2)
  ///
  /// Si la categoría está vacía, no cuenta para la media.
  /// Si hay dos valores en un mismo form, se suman los valores y cuenta como uno
  ///
  /// Esto es porque si se rellenan varias horas en un día, se considera una
  /// siesta o un sueño partido, pero siguen siendo horas de sueño el mismo día
  ///
  /// todo mirar si es mejor dividir entre los días que han pasado o entre formularios
  void actualizarMediaSueno(List<Formulario> listForm){
    int counter = 0; // Contador por cada formulario con esta categoría rellena
    int suma = 0;

    if(nFormularios > 0){
      for (Formulario f in listForm) {
        if(!f.listaCategorias.elementAt(0).isRespuestasVacio){
          counter++;
          for (Accion a in f.listaCategorias.elementAt(0).respuestas){
            suma += a.value;
          }
        }
      }
      if (counter > 0){
        mediaSueno = suma/counter;
      } else { // si hay formularios pero ninguno con esta categoria rellena
        mediaSueno = -1;
      }
    }
    else {
      mediaSueno = -1;
    }
  }

  /// Método que calcula la media de la calidad de sueño
  ///
  /// Si la categoría está vacía, no cuenta para la media.
  /// Si hay dos valores en un mismo form, cuentan como dos valores distintos
  void actualizarMediaCalidadSueno(List<Formulario> listForm){
    int counter = 0; // Contador por cada acción marcada
    int suma = 0;
    if(nFormularios > 0){
      for (Formulario f in listForm) {
        if(!f.listaCategorias.elementAt(1).isRespuestasVacio){
          for (Accion a in f.listaCategorias.elementAt(1).respuestas){
            if (a.value != 0){ // si vale 0 es Dormir acompañado: ese dato no lo contamos
              counter++;
              suma += a.value;
            }
          }
        }
      }
      if (counter > 0){
        mediaCalidadSueno = suma/counter;
      } else { // si hay formularios pero ninguno con esta categoria rellena
        mediaCalidadSueno = -1;
      }
    }
    else {
      mediaCalidadSueno = -1;
    }
  }
  void actualizarMediaAutoestima(List<Formulario> listForm){
    double media = 0;
    for (Formulario f in listForm) {
      for (Categoria c in f.listaCategorias){

      }
    }
  }
  void actualizarMediaProductividad(List<Formulario> listForm){
    double media = 0;
    for (Formulario f in listForm) {
      for (Categoria c in f.listaCategorias){

      }
    }
  }

  void actualizarMinMaxQuehaceres(List<Formulario> listForm){
  }

  void actualizarMinMaxComida(List<Formulario> listForm){
  }

  void actualizarMinMaxEntretenimiento(List<Formulario> listForm){
  }

  void actualizarMinMaxTiempo(List<Formulario> listForm){
  }
}