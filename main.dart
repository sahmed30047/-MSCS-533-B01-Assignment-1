import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ConversionScreen(),
    );
  }
}

class ConversionScreen extends StatefulWidget {
  @override
  _ConversionScreenState createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  String selectedMeasure = 'Length';
  String fromUnit = 'Miles';
  String toUnit = 'Kilometers';
  double inputValue = 0;
  String resultMessage = '';

  final Map<String, List<String>> unitOptions = {
    'Length': ['Miles', 'Kilometers'],
    'Weight': ['Pounds', 'Kilograms'],
    'Temperature': ['Celsius', 'Fahrenheit'],
  };

  void convert() {
    setState(() {
      double resultValue = 0;
      if (selectedMeasure == 'Length') {
        if (fromUnit == 'Miles' && toUnit == 'Kilometers') {
          resultValue = inputValue * 1.60934;
        } else if (fromUnit == 'Kilometers' && toUnit == 'Miles') {
          resultValue = inputValue / 1.60934;
        }
      } else if (selectedMeasure == 'Weight') {
        if (fromUnit == 'Pounds' && toUnit == 'Kilograms') {
          resultValue = inputValue * 0.453592;
        } else if (fromUnit == 'Kilograms' && toUnit == 'Pounds') {
          resultValue = inputValue / 0.453592;
        }
      } else if (selectedMeasure == 'Temperature') {
        if (fromUnit == 'Celsius' && toUnit == 'Fahrenheit') {
          resultValue = (inputValue * 9 / 5) + 32;
        } else if (fromUnit == 'Fahrenheit' && toUnit == 'Celsius') {
          resultValue = (inputValue - 32) * 5 / 9;
        }
      }
      resultMessage =
          '$inputValue $fromUnit is ${resultValue.toStringAsFixed(3)} $toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unit Converter')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text("Type of Unit:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedMeasure,
                  items: unitOptions.keys.map((String key) {
                    return DropdownMenuItem<String>(
                      value: key,
                      child: Text(key),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMeasure = value!;
                      fromUnit = unitOptions[value]![0];
                      toUnit = unitOptions[value]![1];
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("From:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: fromUnit,
                  items: unitOptions[selectedMeasure]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      fromUnit = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("To:", style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: toUnit,
                  items: unitOptions[selectedMeasure]!.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      toUnit = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Value'),
              onChanged: (value) {
                setState(() {
                  inputValue = double.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convert,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Text(
              resultMessage,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
