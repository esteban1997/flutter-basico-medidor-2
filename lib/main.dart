import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  final List<String> _measure = [
    "metros",
    "kilometros",
    "gramos",
    "kilogramos",
    "pies",
    "millas",
    "libras",
    "onzas"
  ];

  late String _startM;
  late String _endM;

  final valueController = TextEditingController();

  late int _startI;
  late int _endI;

  late String endValue;

  final _formulas = [
    [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    [0, 0, 1, 0.0001, 0, 0, 0.0022, 0.035274],
    [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    [0, 0, 28.3495, 0, 02835, 3.28084, 0, 0.0625, 1],
  ];

  @override
  void initState() {
    _startM = _measure[0];
    _endM = _measure[0];
    _startI = 0;
    _endI = 0;
    endValue = "0";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(color: Colors.grey, fontSize: 20);
    var measureStyle = TextStyle(color: Colors.blue[700], fontSize: 20);

    const boxBetween = SizedBox(
      height: 8,
    );

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: const Text("medidor app 2")),
      // ignore: avoid_unnecessary_containers
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                boxBetween,
                const Text(
                  "CONVERTIR",
                  style: labelStyle,
                ),
                boxBetween,
                TextField(
                  controller: valueController,
                  decoration: const InputDecoration(
                      hintText: "Valor Inicial",
                      contentPadding: EdgeInsets.all(8.0)),
                ),
                boxBetween,
                boxBetween,
                const Text(
                  "DE",
                  style: labelStyle,
                ),
                DropdownButton<dynamic>(
                    isExpanded: true,
                    value: _startM,
                    items: _measure.map((String e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e,
                              style: measureStyle,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      _startM = value;
                      _startI = _measure.indexOf(_startM);
                      setState(() {});
                    }),
                boxBetween,
                const Text(
                  "A",
                  style: labelStyle,
                ),
                DropdownButton<dynamic>(
                    isExpanded: true,
                    value: _endM,
                    items: _measure.map((String e) {
                      return DropdownMenuItem(
                          value: e,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              e,
                              style: measureStyle,
                            ),
                          ));
                    }).toList(),
                    onChanged: (value) {
                      _endM = value;
                      _endI = _measure.indexOf(_endM);
                      setState(() {});
                    }),
                boxBetween,
                ElevatedButton(
                    onPressed: () async {
                      try {
                        var value = double.parse(valueController.text.trim());

                        endValue = "${value * _formulas[_startI][_endI]}";
                        setState(() {});
                      } on FormatException {
                        debugPrint("problemas con la conversión");
                      }
                    },
                    child: const Text("CONVERTIR")),
                //const Spacer(),
                Text(
                  "resultado $endValue",
                  style: labelStyle,
                ),
              ],
            )),
      ),
    ));
  }
}
