import 'package:flutter/material.dart';
import 'package:life_tracker/funcionalidad/usuario.dart';
import 'package:life_tracker/main.dart';

///Este fichero sirve para crear la parte gráfica a la hora de
///editar el perfil de usuario

class PantallaPerfilUsuario extends StatefulWidget{
  const PantallaPerfilUsuario({Key? key}) : super(key: key);

  @override
  _PantallaPerfilUsuarioState createState() => _PantallaPerfilUsuarioState();
}

class _PantallaPerfilUsuarioState extends State<PantallaPerfilUsuario>{

  GestorUsuario gestor = GestorUsuario.instance;

  @override
  Widget build(BuildContext context){
    return Center(
      child: Scaffold(
          appBar: AppBar(title: const Text("Configuración"),),
          body: Column(
            children: [

              Text("Username:\n" + gestor.currentUser!.user, style: const TextStyle(color: Colors.white, fontSize: 20),),

              TextButton(
                child: const Text("Cerrar Sesión", style: TextStyle(color: Colors.white, fontSize: 20),), // todo poner un botón de asegurarse
                onPressed: (){
                  GestorUsuario.instance.cerrarSesion();
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>const Inicio())); // todo arreglar para que no se pueda hacer pop
                },
              ),
            ],
          )
      ),
    );
  }
}