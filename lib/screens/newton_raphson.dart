import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
//import 'package:numerical_methods_mathematics/screens/bisection_info.dart';
import 'package:numerical_methods_mathematics/screens/newton_raphson_info.dart';

class NewtonRaphson extends StatefulWidget {
  const NewtonRaphson({super.key});

  @override
  State<NewtonRaphson> createState() => _NewtonRaphsonState();
}

class _NewtonRaphsonState extends State<NewtonRaphson> {
  final _textController = TextEditingController();
  final _errorController = TextEditingController();
  final _aController = TextEditingController();
  //final _bController = TextEditingController();
  String output = 'Result will appear here';
  String iterations = 'No. of iterations will appear here';
  String timeTaken = "Algorithm's execution time will appear here";
  bool takeApproximate = false;
  Color buttonNotSelectedColor = Colors.green;
  Color buttonSelectedColor = Colors.grey;
  Color buttonColor = Colors.green;

  List newtonRaphson(String func, double x0,
      {int maxIterations = 500, double tolerance = 1e-12}) {
    //final stopwatch = Stopwatch()..start();
    Parser p1 = Parser();
    Expression exp = p1.parse(func);
    ContextModel cm1 = ContextModel();
    ContextModel cm2 = ContextModel();
    ContextModel cm3 = ContextModel();
    // ContextModel cm4 = ContextModel();
    cm1.bindVariableName('x', Number(x0));
    double fx0 = exp.evaluate(EvaluationType.REAL, cm1); // f(x)
    int iter = 0;
    List valuesListX0 = [];
    List valuesListFX0 = [];
    List valuesListF1X0 = [];
    List valuesListBADiff = [];
    //Expression expression = Parser().parse(func);
    //Expression evaluator = expression.simplify();
    Expression derivative = Parser().parse(func).simplify().derive('x');
    cm2.bindVariableName('x', Number(x0));
    double f1x0 = derivative.evaluate(EvaluationType.REAL, cm2); //f1(x)
    //double x = -1;
    double nextGuess = (x0 - (fx0 / f1x0));
    valuesListBADiff.add((nextGuess - x0).abs());
    //print(nextGuess);
    //print(f1x0);
    //print(nextGuess - x0);
    while (f1x0 != 0 && (nextGuess - x0).abs() > tolerance) {
      x0 = nextGuess;
      cm3.bindVariableName('x', Number(x0));
      //cm4.bindVariableName('x', Number(x0));
      ContextModel cm5 = ContextModel();
      cm5.bindVariableName('x', Number(x0));
      fx0 = exp.evaluate(EvaluationType.REAL, cm3);
      //f1x0 = derivative.evaluate(EvaluationType.REAL, cm4);
      f1x0 = derivative.evaluate(EvaluationType.REAL, cm5);
      valuesListX0.add(x0);
      valuesListFX0.add(fx0);
      valuesListF1X0.add(f1x0);
      nextGuess = (x0 - (fx0 / f1x0));
      valuesListBADiff.add((nextGuess - x0).abs());
      iter++;
      if (iter > 500) {
        break; // Prevent infinite loop
      }
    }
    return [
      x0,
      iter.toDouble(),
      valuesListX0,
      valuesListFX0,
      valuesListF1X0,
      valuesListBADiff
    ];
  }

  List ans = [];
  String valuesX0 = '';
  String valuesFX0 = '';
  String valuesF1X0 = '';
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
        title: const Text('Newton Raphson Method'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/bisection_info');
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) =>
                        const NewtonRaphsonInfo()),
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
                            content: Text(
                                "The results will be approximate. Please click 'Solve the equation' again!"),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "The results will be accurate. Please click 'Solve the equation' again!"),
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
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     keyboardType: TextInputType.number,
            //     decoration: InputDecoration(
            //         hintText: 'Enter b',
            //         border: const OutlineInputBorder(),
            //         suffixIcon: IconButton(
            //             onPressed: () {
            //               _bController.clear();
            //             },
            //             icon: const Icon(Icons.clear))),
            //     controller: _bController,
            //   ),
            // ),
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
                      final startTime = DateTime.now();
                      ans = newtonRaphson(
                          _textController.text, double.parse(_aController.text),
                          tolerance: double.parse(_errorController.text));
                      final endTime = DateTime.now();
                      timeTaken =
                          'Execution Time:- ${endTime.difference(startTime).inMicroseconds} μs';
                      output = takeApproximate
                          ? 'Result:- ${ans[0].toStringAsFixed(5)}'
                          : 'Result:- ${ans[0].toString()}';
                      iterations = 'Iterations:- ${ans[1].toInt().toString()}';
                      valuesX0 = ans[2].toString();
                      valuesFX0 = ans[3].toString();
                      valuesF1X0 = ans[4].toString();
                      valuesBADiff = ans[5].toString();
                      row1 = displayRow(ans);
                      column1 = displayColumn(ans);
                    } catch (e) {
                      output = "Please enter double values only";
                    }
                  });
                },
                child: const Text('Solve the equation')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: SelectableText(
                output,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Text(
                iterations,
                style: Theme.of(context).textTheme.headlineSmall,
              )),
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Text(
                  timeTaken,
                  style: Theme.of(context).textTheme.headlineSmall,
                ))),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       timeTaken,
            //       style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            //* Uncomment for each list
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesX0,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesFX0,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesF1X0,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesBADiff,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DataTable(columns: column1, rows: row1),
              ),
            )
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
              DataCell(SelectableText(ans[3][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[4][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[2][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[5][i].toStringAsFixed(5))),
            ])
          : DataRow(cells: [
              DataCell(SelectableText((i + 1).toString())),
              DataCell(SelectableText(ans[3][i].toString())),
              DataCell(SelectableText(ans[4][i].toString())),
              DataCell(SelectableText(ans[2][i].toString())),
              DataCell(SelectableText(ans[5][i].toString()))
            ]));
    }
    return row;
  }

  List<DataColumn> displayColumn(List<dynamic> ans) {
    return const [
      DataColumn(label: Text('Iteration No.')),
      DataColumn(label: Text('f(x)')),
      DataColumn(label: Text('f1(x)')),
      DataColumn(label: Text('x0')),
      DataColumn(label: Text('x1  -  x0'))
    ];
  }
}
