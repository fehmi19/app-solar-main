import 'package:flutter/material.dart';
import 'services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar System App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(apiService: apiService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ApiService apiService;

  MyHomePage({required this.apiService});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<dynamic>> planets;
  late Future<List<dynamic>> quizQuestions;

  @override
  void initState() {
    super.initState();
    planets = widget.apiService.getPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solar System App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Planets:'),
            FutureBuilder<List<dynamic>>(
              future: planets,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        var planet = snapshot.data![index];
                        return ListTile(
                          leading: Image.asset(
                            planet[
                                'image'], // Use 'Image.asset' since the image is local
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(planet['name']),
                          onTap: () {
                            // When tapped, navigate to the planet details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PlanetDetailPage(planet: planet),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class PlanetDetailPage extends StatelessWidget {
  final dynamic planet;

  PlanetDetailPage({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(planet['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              planet['image'], // Display the planet image (local asset)
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Text(planet['description'] ?? 'No description available.'),
            SizedBox(height: 16),
            Text(
              'Fun Facts:',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: planet['funFacts']
                  .map<Widget>((fact) => Text('• $fact'))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
