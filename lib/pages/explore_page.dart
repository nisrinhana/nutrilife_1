import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
         flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF800000), // Maroon
                Color(0xFF000080), // Navy
    ],
            ),
          ),
        ),
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildExploreItem(
            context,
            title: 'Healthy Recipes',
            subtitle: 'Discover new healthy meals to try this week.',
            image: 'assets/images/healthy_food.jpg',
          ),
          _buildExploreItem(
            context,
            title: 'Workout Plans',
            subtitle: 'Stay fit with our curated workout plans.',
            image: 'assets/images/workout_illustration.png',
          ),
          _buildExploreItem(
            context,
            title: 'Mindfulness Tips',
            subtitle: 'Learn how to reduce stress and stay calm.',
            image: 'assets/images/healthy_food.jpg',
          ),
        ],
      ),
    );
  }

  Widget _buildExploreItem(BuildContext context,
      {required String title, required String subtitle, required String image}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey),
        ),
        onTap: () {
          // Navigasi ke halaman detail (bisa ditambahkan nanti)
        },
      ),
    );
  }
}