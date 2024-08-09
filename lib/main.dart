import 'package:flutter/material.dart';

enum Gender { MALE, FEMALE }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BmrCalcScreen(),
    );
  }
}

class BmrCalcScreen extends StatefulWidget {
  const BmrCalcScreen({super.key});

  @override
  State<BmrCalcScreen> createState() => _BmrCalcScreenState();
}

class _BmrCalcScreenState extends State<BmrCalcScreen> {
  Gender selectedGender = Gender.MALE;
  double selectedHeight = 180;
  int weight = 70;
  int age = 25;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0E21),
        title: const Text("BMR CALCULATOR",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 30.0),
            child: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  buildGenderSelectionBox(
                    "MALE",
                    isSelected: selectedGender == Gender.MALE,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.MALE;
                      });
                    },
                  ),
                  const SizedBox(width: 20),
                  buildGenderSelectionBox(
                    "FEMALE",
                    isSelected: selectedGender == Gender.FEMALE,
                    onTap: () {
                      setState(() {
                        selectedGender = Gender.FEMALE;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: buildBoxDecoration(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        "HEIGHT",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            selectedHeight.toStringAsFixed(0),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                          const SizedBox(width: 5),
                          const Text(
                            "cm",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        min: 100,
                        max: 220,
                        value: selectedHeight,
                        onChanged: (val) {
                          setState(() {
                            selectedHeight = val;
                          });
                        },
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: buildWeightAgeBox("WEIGHT", weight, () {
                      setState(() {
                        weight++;
                      });
                    }, () {
                      setState(() {
                        weight--;
                      });
                    }),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: buildWeightAgeBox("AGE", age, () {
                      setState(() {
                        age++;
                      });
                    }, () {
                      setState(() {
                        age--;
                      });
                    }),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                double bmr = calculateBMR();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Your BMR"),
                      content: Text("BMR: ${bmr.toStringAsFixed(2)} kcal/day"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              color: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              height: 80,
              child: const Center(
                child: Text(
                  "CALCULATE",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGenderSelectionBox(
      String gender, {
        required bool isSelected,
        required void Function()? onTap,
      }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 200,
          decoration: buildBoxDecoration(
            color: isSelected ? Colors.red.withOpacity(0.2) : null,
          ),
          child: Center(
            child: Text(
              gender,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildWeightAgeBox(String label, int value, void Function()? increment, void Function()? decrement) {
    return Container(
      height: 200,
      decoration: buildBoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "$value",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: increment,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: decrement,
                child: const Icon(
                  Icons.remove,
                  color: Colors.white,
                ),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration({Color? color}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: color ?? const Color(0xFF252948),
    );
  }

  double calculateBMR() {
    if (selectedGender == Gender.MALE) {
      return 88.36 + (13.4 * weight) + (4.8 * selectedHeight) - (5.7 * age);
    } else {
      return 447.6 + (9.2 * weight) + (3.1 * selectedHeight) - (4.3 * age);
    }
  }
}
