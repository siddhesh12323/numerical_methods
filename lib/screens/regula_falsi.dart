import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_methods_mathematics/screens/regula_falsi_info.dart';

class RegulaFalsi extends StatefulWidget {
  const RegulaFalsi({super.key});

  @override
  State<RegulaFalsi> createState() => _RegulaFalsiState();
}

class _RegulaFalsiState extends State<RegulaFalsi> {
  final _textController = TextEditingController();
  final _errorController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String output = 'Result will appear here';
  String iterations = 'No. of iterations will appear here';
  String timeTaken = "Algorithm's will appear here";
  bool takeApproximate = false;
  Color buttonNotSelectedColor = Colors.green;
  Color buttonSelectedColor = Colors.grey;
  Color buttonColor = Colors.green;

  List regulaFalsi(String func, double a, double b,
      {int maxIterations = 500, double tolerance = 1e-12}) {
    //final stopwatch = Stopwatch()..start();
    Parser p1 = Parser();
    Expression exp = p1.parse(func);
    ContextModel cm1 = ContextModel();
    ContextModel cm2 = ContextModel();
    ContextModel cm3 = ContextModel();
    ContextModel cm4 = ContextModel();
    ContextModel cm5 = ContextModel();
    ContextModel cm6 = ContextModel();
    cm3.bindVariableName('x', Number(a));
    cm4.bindVariableName('x', Number(b));
    double c = 0;
    int iter = 0;
    List valuesListC = [];
    List valuesListfC = [];
    List valuesListfB = [];
    List valuesListfA = [];
    List valuesListBADiff = [];
    if (exp.evaluate(EvaluationType.REAL, cm3) *
            exp.evaluate(EvaluationType.REAL, cm4) <
        0) {
      while ((b - a).abs() > tolerance) {
        c = ((a * exp.evaluate(EvaluationType.REAL, cm4)) -
                (b * exp.evaluate(EvaluationType.REAL, cm3))) /
            (exp.evaluate(EvaluationType.REAL, cm4) -
                exp.evaluate(EvaluationType.REAL, cm3));
        cm1.bindVariableName('x', Number(c));
        if (exp.evaluate(EvaluationType.REAL, cm1).abs() < tolerance) {
          return [
            c,
            iter.toDouble(),
            valuesListfA,
            valuesListfB,
            valuesListfC,
            valuesListC,
            valuesListBADiff
          ];
        }
        cm2.bindVariableName('x', Number(a));
        cm5.bindVariableName('x', Number(b));
        valuesListfA.add(exp.evaluate(EvaluationType.REAL, cm2));
        valuesListfB.add(exp.evaluate(EvaluationType.REAL, cm5));
        valuesListBADiff.add((b - a));
        if (exp.evaluate(EvaluationType.REAL, cm1) *
                exp.evaluate(EvaluationType.REAL, cm2) <
            0) {
          b = c;
        } else {
          a = c;
        }
        valuesListfC.add(exp.evaluate(EvaluationType.REAL, cm1));
        valuesListC.add(c);
        iter++;
      }
      //cm6.bindVariableName('x', Number(c));
      // valuesListfC.add(exp.evaluate(EvaluationType.REAL, cm6));
      // valuesListC.add(c);
      //stopwatch.stop();
      return [
        c,
        iter.toDouble(),
        valuesListfA,
        valuesListfB,
        valuesListfC,
        valuesListC,
        valuesListBADiff
      ];
    } else {
      //stopwatch.stop();
      return [
        -1,
        0,
        valuesListfA,
        valuesListfB,
        valuesListfC,
        valuesListC,
        valuesListBADiff
      ];
    }
  }

  List ans = [];
  String valuesfA = '';
  String valuesfB = '';
  String valuesfC = '';
  String valuesC = '';
  String valuesBADiff = '';
  List<DataRow> row1 = [];
  List<DataColumn> column1 = [
    const DataColumn(label: Text('')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Regula Falsi Method'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/regula_falsi_info');
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) =>
                        const RegulaFalsiInfo()),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      const begin = Offset(0, 1);
                      const end = Offset.zero;
                      var curve = Curves.easeIn;
                      var curveTween = CurveTween(curve: curve);
                      final tween =
                          Tween(begin: begin, end: end).chain(curveTween);
                      final offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    }));
              },
              icon: const Icon(Icons.info_rounded))
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        titleTextStyle: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        takeApproximate = !takeApproximate;
                        if (takeApproximate) {
                          buttonColor = buttonSelectedColor;
                        } else {
                          buttonColor = buttonNotSelectedColor;
                        }
                      });
                      if (takeApproximate) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("The results will be approximate. Please click 'Solve the equation' again!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("The results will be accurate. Please click 'Solve the equation' again!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    child: Container(
                      width: 200,
                      height: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: buttonColor),
                      // onTap: () {
                      //   takeApproximate = !takeApproximate;
                      //   if (takeApproximate) {
                      //     buttonColor = buttonNotSelectedColor;
                      //   } else {
                      //     buttonColor = buttonSelectedColor;
                      //   }
                      // },
                      child: takeApproximate
                          ? const Center(child: Text('Values approximated!'))
                          : const Center(
                              child: Text('Approximate the values?')),
                    )),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter the equation',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _textController.clear();
                        },
                        icon: const Icon(Icons.clear))),
                controller: _textController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter a',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _aController.clear();
                        },
                        icon: const Icon(Icons.clear))),
                controller: _aController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter b',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _bController.clear();
                        },
                        icon: const Icon(Icons.clear))),
                controller: _bController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: 'Enter the error factor',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          _errorController.clear();
                        },
                        icon: const Icon(Icons.clear))),
                controller: _errorController,
              ),
            ),
            TextButton(
                style: Theme.of(context).textButtonTheme.style,
                onPressed: () {
                  setState(() {
                    try {
                      ans = regulaFalsi(
                          _textController.text,
                          double.parse(_aController.text),
                          double.parse(_bController.text),
                          tolerance: double.parse(_errorController.text));
                      output = takeApproximate ? 'Result:- ${ans[0].toStringAsFixed(5)}' : 'Result:- ${ans[0].toString()}';
                      iterations = 'Iterations:- ${ans[1].toInt().toString()}';
                      valuesfA = ans[2].toString();
                      valuesfB = ans[3].toString();
                      valuesfC = ans[4].toString();
                      valuesC = ans[5].toString();
                      valuesBADiff = ans[6].toString();
                      row1 = displayRow(ans);
                      column1 = displayColumn(ans);
                      //timeTaken = 'Execution Time:- ${ans[2].toString()}';
                    } catch (e) {
                      print('Error:- $e');
                      output = "Please enter double values only";
                    }
                  });
                },
                child: const Text('Solve the equation')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: SelectableText(
                  output,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Center(
                    child: Text(
                  iterations,
                  style: Theme.of(context).textTheme.headlineSmall,
                )),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       timeTaken,
            //       style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // )
            //* Uncomment for each list
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesfA,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesfB,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesfC,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesC,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesBADiff,
            //     )),
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(columns: column1, rows: row1),
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }

  List<DataRow> displayRow(List<dynamic> ans) {
    List<DataRow> row = [];
    for (int i = 0; i < ans[1].toInt(); i++) {
      row.add(takeApproximate
          ? DataRow(cells: [
              DataCell(SelectableText((i + 1).toString())),
              DataCell(SelectableText(ans[2][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[3][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[4][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[5][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[6][i].toStringAsFixed(5))),
            ])
          : DataRow(cells: [
              DataCell(SelectableText((i + 1).toString())),
              DataCell(SelectableText(ans[2][i].toString())),
              DataCell(SelectableText(ans[3][i].toString())),
              DataCell(SelectableText(ans[4][i].toString())),
              DataCell(SelectableText(ans[5][i].toString())),
              DataCell(SelectableText(ans[6][i].toString()))
            ]));
    }
    return row;
  }

  List<DataColumn> displayColumn(List<dynamic> ans) {
    return const [
      DataColumn(label: Text('Iteration No.')),
      DataColumn(label: Text('f(a)')),
      DataColumn(label: Text('f(b)')),
      DataColumn(label: Text('f(c)')),
      DataColumn(label: Text('c')),
      DataColumn(label: Text('b  -  a'))
    ];
  }
}
