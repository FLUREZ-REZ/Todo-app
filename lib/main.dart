import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Pages/To-do.dart';
import 'package:todo/models/save-todo.dart';
import 'package:shared_preferences/shared_preferences.dart';



Future<void> main() async {


  runApp(ChangeNotifierProvider(
      create: (context) => saveTask(),
      child: Myapp()));
  
}



class Myapp extends StatefulWidget {
  const Myapp({super.key});

  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark
      ),
     initialRoute: '/',
     routes: {

        '/': (_) =>  todoList(),


     },
    );
  }
}
