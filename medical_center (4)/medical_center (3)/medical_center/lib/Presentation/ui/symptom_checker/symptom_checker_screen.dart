import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DiseasePredictionPage extends StatefulWidget {
  @override
  _DiseasePredictionPageState createState() => _DiseasePredictionPageState();
}

class _DiseasePredictionPageState extends State<DiseasePredictionPage> {
  List<String> symptoms = [];
  List<String> selectedSymptoms = [];
  String predictionResult = "";
  bool isLoading = true;
  bool isPredicting = false;
  bool hasError = false;

  final Color primaryColor = Color(0xFF199A8E);

  @override
  void initState() {
    super.initState();
    loadSymptoms();
  }

  Future<void> loadSymptoms() async {
    setState(() {
      isLoading = true;
      hasError = false;
    });

    try {
      final response = await http.get(
        Uri.parse("http://192.168.1.115:5000/symptoms"),
      );

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          symptoms = List<String>.from(data);
          isLoading = false;
        });
      } else {
        setState(() {
          predictionResult = "⚠️ No symptoms available.";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
        predictionResult = "❌ Failed to load symptoms! Check your connection.";
      });
    }
  }

  Future<void> predictDisease() async {
    if (selectedSymptoms.isEmpty) {
      setState(() {
        predictionResult = "⚠️ Please select at least five symptoms!";
      });
      return;
    }

    final url = Uri.parse("http://192.168.1.115:5000/predict");

    setState(() {
      isPredicting = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "symptoms": selectedSymptoms.map((s) => s.replaceAll(" ", "_")).toList(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictionResult = "🩺 Possible Diagnosis: ${data["prediction"] ?? "Unknown"}";
        });
      } else {
        setState(() {
          predictionResult = "❌ An error occurred while predicting!";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "⚠️ Failed to connect to the server! Ensure it is running.";
      });
    } finally {
      setState(() {
        isPredicting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("🔍 Disease Diagnosis"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator(color: primaryColor))
            : hasError
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        predictionResult,
                        style: TextStyle(fontSize: 16, color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: loadSymptoms,
                        child: Text("🔄 Retry"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: Colors.black,
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        "📋 Select Symptoms:",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: symptoms.length,
                          itemBuilder: (context, index) {
                            final symptom = symptoms[index];
                            return CheckboxListTile(
                              title: Text(
                                symptom.replaceAll("_", " "),
                                style: TextStyle(fontSize: 16),
                              ),
                              value: selectedSymptoms.contains(symptom),
                              activeColor: primaryColor,
                              onChanged: (bool? value) {
                                setState(() {
                                  if (value == true) {
                                    selectedSymptoms.add(symptom);
                                  } else {
                                    selectedSymptoms.remove(symptom);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: isPredicting ? null : predictDisease,
                            child: isPredicting
                                ? SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text("🔍 Predict Disease"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              backgroundColor: primaryColor,
                              foregroundColor: Colors.black,
                            ),
                          ),
                          SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                selectedSymptoms.clear();
                                predictionResult = "";
                              });
                            },
                            child: Text("♻️ Reset"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        predictionResult,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
