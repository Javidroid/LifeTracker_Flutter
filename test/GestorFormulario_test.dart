import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:practica2_ds/accion.dart';
import 'package:practica2_ds/categoria.dart';
import 'package:practica2_ds/formulario.dart';

/// En este fichero se incluirán las pruebas unitarias de GestorFormulario

void main() {
  group('GestorFormulario', () {
    test('los campos se han guardado bien y que la lista de formularios tiene el numero de formularios', (){
      final gestor = GestorFormulario.instance;

      //Creamos una lista de categorías para poder llamar al método
      List<Categoria> lCategorias = [Categoria(enunciado: '¿Qué has comido?', acciones: [
        Accion("fruta", false),
        Accion("verdura", false),
        Accion("carne", false),
        Accion("pollo", false),
        Accion("pasta", false)
      ])];

      expect(gestor.listaFormularios.length, 0); //comprobamos que se inicializa a 0 formularios

      //USAMOS EL MÉTODO Y CREAMOS EL FORMULARIO
      gestor.crearFormulario(3, lCategorias, "hola muy buenas");

      Formulario f = gestor.listaFormularios.last;

      expect(f.estadoAnimo, 3);
      expect(f.listaCategorias, lCategorias);
      expect(f.campoTexto, "hola muy buenas");
      expect(gestor.listaFormularios.length, 1); //comprobamos que solo hay un formulario
    });


    test('el numero de formularios debe reducirse en 1 si se llama al metodo borrarFormulario()', (){
      final gestor = GestorFormulario.instance;

      //Creamos una lista de categorías para poder llamar al método
      List<Categoria> lCategorias = [Categoria(enunciado: '¿Qué has comido?', acciones: [
        Accion("fruta", false),
        Accion("verdura", false),
        Accion("carne", false),
        Accion("pollo", false),
        Accion("pasta", false)
      ])];

      // Añadimos un par de formularios
      gestor.crearFormulario(3, lCategorias, "1");
      gestor.crearFormulario(5, lCategorias, "2");

      //llamamos al método:
      gestor.borrarFormulario(gestor.listaFormularios.first);

      expect(gestor.listaFormularios.length, 1); //comprobamos que solo hay un formulario
    });
  });
}