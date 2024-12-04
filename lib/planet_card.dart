import 'package:flutter/material.dart';
import 'planet.dart'; // Import the Planet model

class PlanetCard extends StatelessWidget {
  final Planet planet;
  final VoidCallback onTap;

  PlanetCard({required this.planet, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 15, // Increased elevation for a deeper shadow effect
        shadowColor: Colors.black, // Added shadow color
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Stack(
          clipBehavior: Clip.none, // Adjusted to match code2
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                planet.image,
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black54,
                    Colors.transparent
                  ], // Adjusted gradient for better visibility
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                planet.name,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [Shadow(blurRadius: 10, color: Colors.black)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
