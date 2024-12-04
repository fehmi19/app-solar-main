import 'package:flutter/material.dart';
import '../planet.dart';

class PlanetDetailScreen extends StatelessWidget {
  final Planet planet;

  PlanetDetailScreen({required this.planet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Image de fond avec filtre sombre pour le corps principal
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bac.jpg'), // Image de fond
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken, // Filtre pour un effet assombri
            ),
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image de la planète avec animation Hero
              Hero(
                tag: planet.name,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    planet.image,
                    fit: BoxFit.cover,
                    height: 250, // Taille d’image plus grande
                    width: double.infinity,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Conteneur pour la description avec fond blanc semi-transparent
              Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.75), // Fond semi-transparent
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  planet.description,
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Titre pour les faits amusants avec typographie ombrée
              Text(
                ':حقائق ممتعة',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
              SizedBox(height: 10),
              // Liste des faits amusants avec effet de carte
              ...planet.funFacts.map((fact) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Card(
                      color:
                          Colors.white.withOpacity(0.85), // Cartes translucides
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          fact,
                          style: TextStyle(fontSize: 16, color: Colors.black87),
                        ),
                      ),
                    ),
                  )),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
      // AppBar transparente pour laisser transparaître le fond
      appBar: AppBar(
        title: Text(
          planet.name,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [Shadow(blurRadius: 5, color: Colors.black)],
          ),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0, // Supprimer l'ombre pour une transparence totale
      ),
    );
  }
}
