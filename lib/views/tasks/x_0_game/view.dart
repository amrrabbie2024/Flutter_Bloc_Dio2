import 'package:flutter/material.dart';


class MyXOGame extends StatefulWidget {
  const MyXOGame({super.key});

  @override
  State<MyXOGame> createState() => _MyXOGameState();
}

String player="X";
String lastPlayer="";
List<String> labels=List.filled(9, "");
List<int> checks=List.filled(9, 0);
bool iswinner=false;
List<int> sums=List.filled(8, 0);

class _MyXOGameState extends State<MyXOGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      /*appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Tic Toc Game"),
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 21,fontWeight: FontWeight.w600),
      ),*/
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /*Text("IT'S  $player  TURN", style: TextStyle(color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),),*/
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: "IT'S  ",style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                    TextSpan(text: "$player  ",style: TextStyle(color: player=="X"?Color(0xff40c1ff): Color(0xfff13d83), fontSize: 26, fontWeight: FontWeight.bold),),
                    TextSpan(text: "TURN",style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),),
                  ]
                )
              ),
              SizedBox(height: 36,),
              SizedBox(
                height: 540,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: GestureDetector(
                        onTap: iswinner ? null : () {
                          setState(() {
                            iswinner = isWinner(index);
                            if (labels[index].isEmpty) {
                              if (player == "X") {
                                labels[index] = "X";
                                player = "O";
                                lastPlayer="X";
                                checks[index]=1;
                              } else {
                                labels[index] = "O";
                                player = "X";
                                lastPlayer="O";
                                checks[index]=0;
                              }
                            }
                          });
                        },
                        child: Container(
                          width: 90,
                          height: 90,
                          color: Color(0xff663cb5),
                          child: Center(child: Text(labels[index],
                            style: TextStyle(
                                color: checks[index]==1 ? Color(0xff40c1ff) : Color(
                                    0xfff13d83),
                                fontSize: 28,
                                fontWeight: FontWeight.w900),)),
                        ),
                      ),
                    );
                  },
                  itemCount: 9,
                ),
              ),
              SizedBox(height: 24,),
              lastPlayer != "" && iswinner ? Text("The winner is $lastPlayer",
                style: TextStyle(color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),) : SizedBox.shrink(),
              SizedBox(height: 24,),
              SizedBox(
                height: 40,
                child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfff6f3fb),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(34),
                            side: BorderSide(color: Color(0xfff6f3fb))
                        )
                    ),
                    onPressed: () {
                      setState(() {
                        player = "x";
                        labels = List.filled(9, "");
                        iswinner = false;
                        sums = List.filled(8, 0);
                        lastPlayer = "";
                        checks=List.filled(9, 0);
                      });
                    },
                    icon: Icon(Icons.repeat, color: Color(0xffb7b3bd),),
                    label: Text("Repeat The Game",
                      style: TextStyle(color: Color(0xffb7b3bd)),)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isWinner(int i) {
    int sum = player == "X" ? 1 : -1;
    int row = i ~/ 3;
    int col = i % 3;
    sums[row] += sum;
    sums[col + 3] += sum;
    if (row == col) {
      sums[6] += sum;
    }
    if (row == 2 - col) {
      sums[7] += sum;
    }

    if (sums.contains(3) || sums.contains(-3)) {
      return true;
    } else {
      return false;
    }
  }
}
