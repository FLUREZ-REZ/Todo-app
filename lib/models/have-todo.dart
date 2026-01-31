

class Task {

  final String job ;
  bool Done ;

  Task(
      {
        required this.job ,
        required this.Done
      }
      );

  void iscompleted (){

 Done = !Done ;

  }




}