import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:numerical_methods_mathematics/screens/secant_info.dart';

class Secant extends StatefulWidget {
  const Secant({super.key});

  @override
  State<Secant> createState() => _SecantState();
}

class _SecantState extends State<Secant> {
  final _textController = TextEditingController();
  final _errorController = TextEditingController();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String output = 'Result will appear here';
  String iterations = 'No. of iterations will appear here';
  String timeTaken = "Algorithm's execution time will appear here";
  bool takeApproximate = false;
  Color buttonNotSelectedColor = Colors.green;
  Color buttonSelectedColor = Colors.grey;
  Color buttonColor = Colors.green;

  List bisection(String func, double a, double b,
      {int maxIterations = 500, double tolerance = 1e-12}) {
    //final stopwatch = Stopwatch()..start();
    Parser p1 = Parser();
    Expression exp = p1.parse(func);
    ContextModel cm1 = ContextModel();
    ContextModel cm2 = ContextModel();
    ContextModel cm3 = ContextModel();
    ContextModel cm4 = ContextModel();
    cm3.bindVariableName('x', Number(a));
    cm4.bindVariableName('x', Number(b));
    double c = 0;
    int iter = 0;
    List valuesListC = [];
    List valuesListB = [];
    List valuesListA = [];
    List valuesListBADiff = [];
    if (exp.evaluate(EvaluationType.REAL, cm3) *
            exp.evaluate(EvaluationType.REAL, cm4) <
        0) {
      while ((b - a).abs() > tolerance) {
        c = (a + b) / 2;
        cm1.bindVariableName('x', Number(c));
        if (exp.evaluate(EvaluationType.REAL, cm1).abs() < tolerance) {
          return [
            c,
            iter.toDouble(),
            valuesListA,
            valuesListB,
            valuesListC,
            valuesListBADiff
          ];
        }
        cm2.bindVariableName('x', Number(a));
        valuesListA.add(a);
        valuesListB.add(b);
        valuesListBADiff.add((b - a));
        if (exp.evaluate(EvaluationType.REAL, cm1) *
                exp.evaluate(EvaluationType.REAL, cm2) <
            0) {
          b = c;
        } else {
          a = c;
        }
        valuesListC.add(c);
        iter++;
      }
      //stopwatch.stop();
      return [
        c,
        iter.toDouble(),
        valuesListA,
        valuesListB,
        valuesListC,
        valuesListBADiff
      ];
    } else {
      //stopwatch.stop();
      return [-1, 0, valuesListA, valuesListB, valuesListC, valuesListBADiff];
    }
  }

  List ans = [];
  String valuesC = '';
  String valuesA = '';
  String valuesB = '';
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
        title: const Text('Secant Method'),
        actions: [
          IconButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/bisection_info');
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: ((context, animation, secondaryAnimation) =>
                        const SecantInfo()),
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
                      final startTime = DateTime.now();
                      ans = bisection(
                          _textController.text,
                          double.parse(_aController.text),
                          double.parse(_bController.text),
                          tolerance: double.parse(_errorController.text));
                      final endTime = DateTime.now();
                      timeTaken =
                          'Execution Time:- ${endTime.difference(startTime).inMicroseconds} μs';
                      output = takeApproximate
                          ? 'Result:- ${ans[0].toStringAsFixed(5)}'
                          : 'Result:- ${ans[0].toString()}';
                      iterations = 'Iterations:- ${ans[1].toInt().toString()}';
                      valuesA = ans[2].toString();
                      valuesB = ans[3].toString();
                      valuesC = ans[4].toString();
                      valuesBADiff = ans[5].toString();
                      row1 = displayRow(ans);
                      column1 = displayColumn(ans);
                      //timeTaken = 'Execution Time:- ${ans[2].toString()}';
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
            // )
            //* Uncomment for each list
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesA,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesB,
            //       // style: Theme.of(context).textTheme.headlineSmall,
            //     )),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Container(
            //     child: Center(
            //         child: Text(
            //       valuesC,
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
              DataCell(SelectableText(ans[2][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[3][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[4][i].toStringAsFixed(5))),
              DataCell(SelectableText(ans[5][i].toStringAsFixed(5))),
            ])
          : DataRow(cells: [
              DataCell(SelectableText((i + 1).toString())),
              DataCell(SelectableText(ans[2][i].toString())),
              DataCell(SelectableText(ans[3][i].toString())),
              DataCell(SelectableText(ans[4][i].toString())),
              DataCell(SelectableText(ans[5][i].toString()))
            ]));
    }
    return row;
  }

  List<DataColumn> displayColumn(List<dynamic> ans) {
    return const [
      DataColumn(label: Text('Iteration No.')),
      DataColumn(label: Text('a')),
      DataColumn(label: Text('b')),
      DataColumn(label: Text('c')),
      DataColumn(label: Text('b  -  a'))
    ];
  }
}
