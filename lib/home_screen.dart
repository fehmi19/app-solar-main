import 'package:flutter/material.dart';
import 'planet_card.dart';
import 'planet.dart';
import 'planet_detail_screen.dart';
import '../services/api_service.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'النظام الشمسي',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Couleur du texte modifiée en blanc
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue, // Couleur de fond modifiée en bleu
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/backend.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.5),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'مرحبا في تطبيق النظام الشمسي',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Texte en blanc
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlanetContentScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'انقر هنا لرؤية الكواكب',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    backgroundColor: Colors.blue, // Bouton bleu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PlanetContentScreen extends StatefulWidget {
  final ApiService apiService = ApiService();

  @override
  _PlanetContentScreenState createState() => _PlanetContentScreenState();
}

class _PlanetContentScreenState extends State<PlanetContentScreen> {
  late Future<List<Planet>> planets;

  @override
  void initState() {
    super.initState();
    planets = widget.apiService.fetchPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'صفحة الكواكب',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Texte en blanc
          ),
        ),
        backgroundColor: Colors.blue, // Couleur de fond de l'AppBar en bleu
      ),
      drawer: AppDrawer(),
      body: FutureBuilder<List<Planet>>(
        future: planets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Planet> planetsData = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: planetsData.length,
              itemBuilder: (context, index) {
                return PlanetCard(
                  planet: planetsData[index],
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PlanetDetailScreen(planet: planetsData[index]),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
                child: Text('صفحة الكواكب (المحتوى سيتم إضافة لاحقًا)'));
          }
        },
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color:
                  Colors.blue, // Couleur d'arrière-plan de l'en-tête du drawer
            ),
            child: Text(
              'قائمة النظام الشمسي',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Texte en blanc
              ),
            ),
          ),
          ListTile(
            title: Text('الصفحة الرئيسية'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
          ListTile(
            title: Text('صفحة الكواكب'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => PlanetContentScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
