import 'package:flutter/material.dart';

class AboutUsApp extends StatefulWidget {
  @override
  State<AboutUsApp> createState() => AboutUsPage();
}

class AboutUsPage extends State<AboutUsApp> {
  final List<Map<String, String>> teamMembers = [
    {
      'name': 'Divyabhavani',
      'description':
          'Developed our image classification model for food detection using TensorFlow and Keras, ensuring accurate food identification.',
      'image': 'lib/images/divya.jpg',
    },
    {
      'name': 'Chetana',
      'description':
          'Leveraged the model to analyze the identified food classes to provide precise nutritional information, helping you make informed dietary choices.',
      'image': 'lib/images/chetana.jpg',
    },
    {
      'name': 'Deeksha',
      'description':
          'Focused on predicting leukemia and thyroid diseases, delivering critical health assessments and guidance.',
      'image': 'lib/images/deeksha.jpg',
    },
    {
      'name': 'Bipin',
      'description':
          'Specialized in disease prediction, focusing on anemia and diabetes to offer proactive health insights.',
      'image': 'lib/images/bipin.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff003c3a),
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Our Team',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.surface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: teamMembers.length,
                itemBuilder: (context, index) {
                  final member = teamMembers[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(
                            0xff003c3a), // Base color for neumorphic effect
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          // Simulating inner shadow effect
                          BoxShadow(
                            color: Color(0xff002a29), // Dark shadow color
                            offset: Offset(4, 4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: Color(0xff004b49), // Light highlight color
                            offset: Offset(-4, -4),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Color(0xff002a29), // Dark shadow color
                                    offset: Offset(-4, -4),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                  BoxShadow(
                                    color: Color(
                                        0xff004b49), // Light highlight color
                                    offset: Offset(4, 4),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  member['image']!,
                                  height: 100,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              member['name']!,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              member['description']!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
