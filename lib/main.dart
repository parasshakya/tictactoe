import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Tic Tac Toe'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  static const String playerX = 'X';
  static const String playerO = 'O';

 late String currentPlayer;
 late bool gameEnd;
  List<String> occupied = ['','','','','','','','',''];


  void initializeGame(){
   currentPlayer = playerX;
   gameEnd = false;

 }

 @override
  void initState() {
   initializeGame();

   // TODO: implement initState
    super.initState();

 }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Your Turn: $currentPlayer ',
                style: GoogleFonts.sono(
                  fontWeight: FontWeight.bold,
                  fontSize: 40
                ),

              ),
              SizedBox(height: 20,),
              gameContainer(),
              SizedBox(height: 10,),
              restartGameButton(),

            ],
          ),
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }

  Widget gameContainer(){

   return Container(
     height: MediaQuery.of(context).size.height / 2,
     margin: EdgeInsets.all(12.0),
     child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
       crossAxisCount: 3,

     ), itemBuilder: (context, index) {
       return box(index);
     },
       itemCount: 9,
     ),
   );

  }

  void changePlayer(){
   if(currentPlayer == playerX){
     setState(() {
       currentPlayer = playerO;
     });
   }else{
    setState(() {
      currentPlayer = playerX;
    });
   }
  }

  Widget box(int index){
    return InkWell(
      onTap: (){

        if(gameEnd  || occupied[index].isNotEmpty){
          return ;
        }else {
          setState(() {
            occupied[index] = currentPlayer;

          });
          checkWinner();
          changePlayer();


        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
        color: Colors.black26,
        child: Center(
          child: Text(occupied[index], style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),),

        ),
      ),
    );
  }

  void checkWinner(){
    List<List<int>> winningList = [[0,1,2], [3,4,5], [6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]];
    for(var winningPos in winningList){
        String playerPosition0 = occupied[winningPos[0]];
        String playerPosition1 = occupied[winningPos[1]];
        String playerPosition2 = occupied[winningPos[2]];

        if(playerPosition0.isNotEmpty) {
          if (playerPosition0 == playerPosition1 &&
              playerPosition0 == playerPosition2) {
            gameEnd = true;
            showGameOverMessage('Winner: $playerPosition0');

          }
        }



    }

  }

  void showGameOverMessage(String message){
       ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color.fromRGBO(0, 255, 0, 1),
          elevation: 10,
          content: Container(
          height: 120,
            child: Center(child: Text(message, style: GoogleFonts.sono(
                fontWeight: FontWeight.bold,
                fontSize: 50,
              color: Colors.black
            )))),
          duration: const Duration(seconds: 2),
        ));

  }

  Widget restartGameButton(){
   return SizedBox(
     height: 50,
     child: ElevatedButton(onPressed: (){

       setState(() {
         initializeGame();
         occupied = ['','','','','','','','',''];
       });

     },
         child:  Text('Restart',style: GoogleFonts.sono(
           fontWeight: FontWeight.bold,
           fontSize: 40
         ))),
   );

  }

}

