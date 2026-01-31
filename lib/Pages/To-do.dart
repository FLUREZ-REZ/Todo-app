import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/Pages/TodoOf-pages/All.dart';
import 'package:todo/Pages/TodoOf-pages/ToDo.dart';
import 'package:todo/Pages/TodoOf-pages/completed.dart';
import 'package:todo/models/have-todo.dart';
import 'package:todo/models/save-todo.dart';


class todoList extends StatelessWidget {
   todoList({super.key});
   final scaffoldContext  = context;
  final controller = TextEditingController();

  static get context => null;



   final GlobalKey<ScaffoldMessengerState> scafoldKey = GlobalKey<ScaffoldMessengerState>();
   final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

  
  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_,themeMode,_){
        return MaterialApp(
          themeMode: themeMode,
          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue,brightness: Brightness.light),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.black,
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange ,
              foregroundColor: Colors.black
            ),



          ),

          darkTheme: ThemeData(

            brightness: Brightness.dark,
            useMaterial3: true ,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue , brightness: Brightness.dark),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
            ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple ,
                foregroundColor: Colors.white
              ),

          ),


          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: scafoldKey,
          home: Scaffold(

              appBar: AppBar(
                actions: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                ],
                leading: ValueListenableBuilder<ThemeMode>(
                  valueListenable: themeNotifier,
                  builder: (_,themeMode,_){
                    return IconButton(
                      tooltip: 'toggle theme',
                      icon: Icon(themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode),
                      onPressed: (){
                        themeNotifier.value = themeMode ==ThemeMode.dark ? ThemeMode.light : ThemeMode.dark ;

                      },
                    );
                  },
                ),

              ),

              floatingActionButton: FloatingActionButton(

                onPressed: (){
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Colors.orange.shade200,
                        title: Text("New reminder" , style: TextStyle(color: Colors.black , fontFamily: 'freak'),),
                        content: TextField(
                          decoration: InputDecoration(
                              fillColor: Colors.black54,
                              filled: true,
                              hintText: "Notes" ,
                              hintStyle: TextStyle(
                                color: Colors.white
                              ),
                              border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          )
                          ),

                          controller: controller,
                          autofocus: true,
                          keyboardType: TextInputType.text,

                        ),
                        actions: [
                          ElevatedButton(onPressed: (){
                            Navigator.of(context).pop();
                          }, child: Text("cancel" , style: TextStyle(color: Colors.white),)),
                          ElevatedButton(onPressed: (){

                            if(controller.text.isEmpty){

                              scafoldKey.currentState!.showSnackBar(
                                  SnackBar(
                                    content: Text("You cant add empty note" , style: TextStyle(color: Colors.black , fontSize: 16),),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.orange.shade200,


                                  )
                              );

                            }
                            else{

                              context.read<saveTask>().Addjob(

                                  Task(job:  controller.text , Done: false)

                              );

                                  print(controller.value.text);
                            }

                            Navigator.of(context).pop();
                            controller.clear();

                          }, child: Text("Add" , style: TextStyle(color: Colors.black),),

                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(Colors.orange.shade700)
                            ),

                          ),


                        ],

                      ));

                },
                child: Icon(Icons.add),
              ),

              body: Builder(
                builder: (context) {
                  return Container(
                    child: Column(
                      children: [
                        //containers todoshow
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 1,

                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => pageAll()));
                                    },
                                    child: Container(
                                      height: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.blue ,
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                      ),

                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text( '${context.watch<saveTask>().tasks.length}' , style: TextStyle(fontSize: 30 , fontFamily: 'roboto'),),
                                              )),
                                          Positioned(
                                              bottom: 0,
                                              left: 0,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text("All" , style: TextStyle(fontSize: 20 , fontFamily: 'roboto' ,),),
                                              )),
                                        ],
                                      )
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                  flex: 1,

                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage()));
                                    },
                                    child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.green ,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),

                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Consumer<saveTask>(
                                                      builder: (context , saveTask , child){
                                                        final doneTasks = saveTask.doneTasks.length ;
                                                        
                                                        return Text('$doneTasks' , style: TextStyle(fontSize: 30),);
                                                      })
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text( "ToDo" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500),),
                                                )),
                                          ],
                                        )
                                    ),
                                  )),

                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Flexible(
                                  flex: 1,

                                  child: InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent ,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),

                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Consumer<saveTask>(
                                                      builder: (context , saveTask , child){

                                                        return Text('${saveTask.deletedCounter}' , style: TextStyle(fontSize: 30),);

                                                      })
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Deleted" , style: TextStyle(fontSize: 20),)
                                                )),
                                          ],
                                        )
                                    ),
                                  )),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                  flex: 1,

                                  child: InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) => completedPage()));
                                    },
                                    child: Container(
                                        height: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),

                                        child: Stack(
                                          children: [
                                            Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Consumer<saveTask>(
                                                      builder: (context , saveTask , child){
                                                        final compelet = saveTask.completeTasks.length ;

                                                        return Text('$compelet' , style: TextStyle(fontSize: 30),);
                                                      })
                                                )),
                                            Positioned(
                                                bottom: 0,
                                                left: 0,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Completed" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w500),),
                                                )),
                                          ],
                                        )
                                    ),
                                  )),

                            ],
                          ),
                        ),

                        Expanded(
                          child: Consumer<saveTask>(builder: (context , task , child){

                            return ListView.builder(
                                itemCount: task.tasks.length,
                                itemBuilder: (BuildContext  context , index){

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(

                                      decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius: BorderRadius.all(Radius.circular(15))
                                      ),
                                      child: ListTile(
                                        title: Text(task.tasks[index].job,
                                          style: TextStyle(

                                              fontFamily: 'roboto',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,

                                              decoration: task.tasks[index].Done ? TextDecoration.lineThrough : TextDecoration.none
                                          ),
                                        ),

                                        trailing: Wrap(

                                          children: [

                                            Checkbox(
                                                value: task.tasks[index].Done,
                                                onChanged: (_){

                                                  context.read<saveTask>().CheckTask(index);

                                                }),
                                            IconButton(onPressed: (){
                                              context.read<saveTask>().Deletejob(task.tasks[index]);
                                            }, icon: Icon(Icons.delete))

                                          ],

                                        ),

                                      ),
                                    ),
                                  );

                                });

                          }),
                        ),
                      ],
                    ),
                  );
                }
              )
          ),
        );
      },

    );



  }

}
