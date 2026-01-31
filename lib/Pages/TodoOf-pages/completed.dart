import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/have-todo.dart';
import 'package:todo/models/save-todo.dart';




class completedPage extends StatelessWidget {
   completedPage({super.key});


   final controller = TextEditingController();
   final GlobalKey<ScaffoldMessengerState> scafoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {

    final undoneTasks = context.watch<saveTask>().completeTasks ;

    return Scaffold(

        appBar: AppBar(
          title: Text("Completed-Archive"),
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

        body: undoneTasks.isEmpty ? Center(child: Text("no data to show"),)
            :
        ListView.builder(
            itemCount: undoneTasks.length,
            itemBuilder: (context , index){

              final task = undoneTasks[index] ;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black12 ,
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                  child: ListTile(
                    title: Text(task.job , style: TextStyle(fontSize: 18 , fontFamily: 'roboto' , fontWeight: FontWeight.w700),),


                  ),
                ),
              );

            })

    );
  }
}


