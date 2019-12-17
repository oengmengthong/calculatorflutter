import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenUI();
  }
}

class ScreenUI extends State<CalculatorScreen> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            _areaResult(),
            _key()
          ],
        ),
      ),
    );
  }

  Widget _areaResult() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 90, color: Colors.white),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _key() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn('C', Colors.grey[300]),
            _btn('+/-', Colors.grey[300]),
            _btn('%', Colors.grey[300]),
            _btn('÷', Colors.orange, Colors.white),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn('7', Colors.grey[700], Colors.white),
            _btn('8', Colors.grey[700], Colors.white),
            _btn('9', Colors.grey[700], Colors.white),
            _btn('x', Colors.orange, Colors.white),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn('4', Colors.grey[700], Colors.white),
            _btn('5', Colors.grey[700], Colors.white),
            _btn('6', Colors.grey[700], Colors.white),
            _btn('-', Colors.orange, Colors.white),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn('1', Colors.grey[700], Colors.white),
            _btn('2', Colors.grey[700], Colors.white),
            _btn('3', Colors.grey[700], Colors.white),
            _btn('+', Colors.orange, Colors.white),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _btn0('0', Colors.grey[700], Colors.white),
            _btn('.', Colors.grey[700], Colors.white),
            _btn('=', Colors.orange, Colors.white),
          ],
        )
      ],
    );
  }

  Widget _btn(String btnText, Color color, [Color colortext]) {
    return MaterialButton(
      color: color,
      height: 100,
      shape: CircleBorder(
        side: BorderSide(
          color: color,
          width: 2,
        ),
      ),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 35, color: colortext),
      ),
      onPressed: () {
        calculation(btnText);
      },
    );
  }

  Widget _btn0(String btnText, Color color, [Color colortext]) {
    return MaterialButton(
      color: color,
      height: 85,
      shape: StadiumBorder(),
      padding: EdgeInsets.only(
          left: 32, right: MediaQuery.of(context).size.width - 275),
      child: Text(
        btnText,
        style: TextStyle(fontSize: 35, color: colortext),
      ),
      onPressed: () {
        calculation(btnText);
      },
    );
  }

  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '÷') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '÷' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '÷') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }

    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
