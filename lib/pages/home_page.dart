import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final int? userId; // Tambahkan userId sebagai parameter opsional

  const HomePage({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    // Mendapatkan lebar layar untuk membuat layout responsif
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = (screenWidth - 48) / 2; // Lebar kartu disesuaikan dengan layar, dikurangi padding
    final double cardHeight = cardWidth * 0.6; // Rasio tinggi:lebar = 0.6

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NutriLife',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset(
              'assets/images/search_icon.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.search,
                  color: Colors.white,
                  size: 24,
                );
              },
            ),
            onPressed: () {
              // Aksi untuk pencarian (bisa ditambahkan nanti)
            },
          ),
        ],
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Back (opsional: tampilkan nama pengguna jika userId tersedia)
              Text(
                'Welcome Back${userId != null ? '!' : ' '}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),
              // Menu dengan 4 tombol
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuButton(
                    icon: 'assets/images/history_icon.png',
                    label: 'Riwayat',
                    onTap: () {
                      Navigator.pushNamed(context, '/history');
                    },
                  ),
                  _buildMenuButton(
                    icon: 'assets/images/meal_plan_icon.png',
                    label: 'Meal Plan & Referensi Makanan',
                    onTap: () {
                      Navigator.pushNamed(context, '/meal_plan');
                    },
                  ),
                  _buildMenuButton(
                    icon: 'assets/images/exercise_icon.png',
                    label: 'Latihan Rutin',
                    onTap: () {
                      Navigator.pushNamed(context, '/recommendation');
                    },
                  ),
                  _buildMenuButton(
                    icon: 'assets/images/reminder_icon.png',
                    label: 'Pengingat',
                    onTap: () {
                      Navigator.pushNamed(context, '/reminder');
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Bagian Tantangan Harian
              const Text(
                'Tantangan Harian',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildChallengeCard(
                    image: 'assets/images/push_up_image.jpg',
                    title: 'Push Up Harian',
                    width: cardWidth,
                    height: cardHeight,
                    onTap: () {
                      // Aksi untuk tantangan Push Up
                    },
                  ),
                  _buildChallengeCard(
                    image: 'assets/images/steps_image.jpg',
                    title: '6000 Langkah',
                    width: cardWidth,
                    height: cardHeight,
                    onTap: () {
                      // Aksi untuk tantangan 6000 Langkah
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Bagian Latihan Otot Pemula
              const Text(
                'Latihan Otot Pemula',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildExerciseCard(
                    image: 'assets/images/muscle_exercise_image1.jpg',
                    title: 'Latihan Otot Kaki Pemula',
                    width: cardWidth,
                    height: cardHeight,
                    onTap: () {
                      // Aksi untuk latihan otot kaki pemula
                    },
                  ),
                  _buildExerciseCard(
                    image: 'assets/images/muscle_exercise_image2.jpg',
                    title: 'Latihan Yoga Pemula',
                    width: cardWidth,
                    height: cardHeight,
                    onTap: () {
                      // Aksi untuk latihan yoga pemula
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 40,
            height: 40,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.broken_image,
                size: 40,
                color: Colors.grey,
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center, // Pastikan teks rata tengah
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeCard({
    required String image,
    required String title,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Image.asset(
              image,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Pastikan teks tidak overflow
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseCard({
    required String image,
    required String title,
    required double width,
    required double height,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Image.asset(
              image,
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: width,
                  height: height,
                  color: Colors.grey[300],
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 40,
                    ),
                  ),
                );
              },
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Pastikan teks tidak overflow
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}