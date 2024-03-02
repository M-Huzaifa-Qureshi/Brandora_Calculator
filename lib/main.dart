import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String equation = "0";
  String result = "0";
  String expression ="";
  double equationFontSize = 38.0;
  double resultSize =50;
  ButtonPressed(String buttonText){
    setState(() {
      if(buttonText=="c"){
        equation = "0";
        result = "0";
         equationFontSize = 38.0;
         resultSize =50;

      }else if(buttonText=="⌫"){
        equationFontSize = 50.0;
        resultSize =38;
        equation = equation.substring(0,equation.length-1);
        if(equation=="0"){
          equation="0";
        }

      }else if(buttonText=="="){
        expression =equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try{

          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm =  ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';


        }catch(e){
        result = "error";
        }


      }else{
        if(equation=="0"){
          equation = buttonText;
        }else{
        equation = equation+buttonText;
      }
      }
    });

  }
  Widget buildBtton(String buttonText, double btnHeight, Color buttonColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
      child: Container(
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(40)
        ),

        height: MediaQuery.of(context).size.height * 0.1*btnHeight,
        child: TextButton(
          onPressed: () => ButtonPressed(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              alignment: Alignment.centerRight,
              height: 100,
              width: double.infinity,
              child: Text(equation,style: TextStyle(fontSize: equationFontSize),),
            ),
            Container(
              alignment: Alignment.centerRight,
              height: 100,
              width: double.infinity,
              child: Text(result,style: TextStyle(fontSize: resultSize),),
            ),
            Expanded(child: Divider()),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*.68,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                          buildBtton("c", 1, Color(0xfff70757a)),
                          buildBtton("⌫", 1, Color(0xfff70757a)),
                          buildBtton("+", 1, Colors.orange),

                        ],
                      ),
                      TableRow(
                        children:
                          [
                            buildBtton("7", 1, Colors.black54),
                            buildBtton("8", 1, Colors.black54),
                            buildBtton("9", 1, Colors.black54),
                          ]
                      ),
                      TableRow(
                          children:
                          [
                            buildBtton("4", 1, Colors.black54),
                            buildBtton("5", 1, Colors.black54),
                            buildBtton("6", 1, Colors.black54),
                          ]
                      ),
                      TableRow(
                          children:
                          [
                            buildBtton("1", 1, Colors.black54),
                            buildBtton("2", 1, Colors.black54),
                            buildBtton("3", 1, Colors.black54),
                          ]
                      ),
                      TableRow(
                          children:
                          [
                            buildBtton(".", 1, Colors.black87),
                            buildBtton("0", 1, Colors.black54),
                            buildBtton("00", 1, Colors.black54),
                          ]
                      )

                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width*.20,
                  child: Table(
                    children: [
                      TableRow(
                        children: [
                           buildBtton('×', 1, Colors.orange)

                        ]
                      ),
                      TableRow(
                          children: [
                            buildBtton('-', 1, Colors.orange)

                          ]
                      ),
                      TableRow(
                          children: [
                            buildBtton('÷', 1,Colors.orange)

                          ]
                      ),
                      TableRow(
                          children: [
                            buildBtton('=', 2, Colors.orange)

                          ]
                      ),


                    ],
                  ),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
