import 'package:flutter/material.dart';
import 'package:life_tracker/theme/colors.dart';
import 'interfaz_grafica/pantalla_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Life Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      // ThemeData(
      //   primarySwatch: Colors.blue, //todo aqui hay que hacer el theme y especificar los colores por defecto
      //   backgroundColor: background,
      // ),
      home: const Inicio(),
    );
  }
}
class Inicio extends StatefulWidget{
  const Inicio({Key? key}) : super(key: key);

  @override
  InicioState createState() => InicioState();
}

class InicioState extends State<Inicio>{

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.purple, //todo poner color
      body: Container(
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(
              color: Colors.black38,
              blurRadius: 20.0,
              spreadRadius: 5.0,
              offset: Offset(5.0, 5.0)
            )],
          color: Colors.purpleAccent, //todo poner color
          borderRadius: BorderRadius.circular(20)
        ),
        margin: const EdgeInsets.only(top: 50, left: 20, right: 20 ,bottom: 40),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo_transparent.png", height: 230,),

              Container(
                margin: const EdgeInsets.only(top: 60),
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.deepPurple, //todo poner color
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  child: const Text("Comenzar", style: TextStyle(color: Colors.white, fontSize: 20),),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>const PantallaMenu()));
                  },
                ),
              ),
              const SizedBox(height: 80,),
            ],
          ),
        ),
      ),
    );
  }
}

