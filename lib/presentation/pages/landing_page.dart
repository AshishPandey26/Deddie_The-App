import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFFFFF4D4),
              const Color(0xFFFFE4A3).withOpacity(0.7),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeroSection(),
                _buildFeatureSection(),
                _buildTestimonialSection(),
                _buildCallToAction(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 40),
      child: Column(
        children: [
          // App Logo/Icon
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: const Icon(
              Icons.task_alt_rounded,
              size: 50,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 40),
          // Main Heading
          const Text(
            "Deddie",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF2D2D2D),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              "Task Accountability Reinvented",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Miss your deadline, and we'll let your network know about it 😈",
            style: TextStyle(
              fontSize: 16,
              color: const Color(0xFF2D2D2D).withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          _buildFeatureCard(
            "Smart Task Management",
            "Create and organize tasks with intelligent deadline tracking",
            Icons.task_alt_rounded,
            const Color(0xFF91C483),
          ),
          _buildFeatureCard(
            "Social Accountability",
            "Automatic posts to your social networks when deadlines are missed",
            Icons.share_rounded,
            const Color(0xFF6E85B7),
          ),
          _buildFeatureCard(
            "Real-time Notifications",
            "Get timely reminders as your deadlines approach",
            Icons.notifications_active_rounded,
            const Color(0xFFFF8C8C),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, size: 30, color: color),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color(0xFF2D2D2D).withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Join thousands of productive people",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          _buildTestimonialCard(
            'Finally, an app that keeps me accountable!',
            'Sarah Johnson',
            'Product Manager',
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard(String quote, String name, String role) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Icon(
            Icons.format_quote_rounded,
            size: 40,
            color: Color(0xFFFFE4A3),
          ),
          const SizedBox(height: 16),
          Text(
            quote,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF2D2D2D),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D2D2D),
            ),
          ),
          Text(
            role,
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF2D2D2D).withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToAction(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Navigate to login/signup
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D2D2D),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                "Get Started",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              // Navigate to login
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: RichText(
              text: const TextSpan(
                text: "Already have an account? ",
                style: TextStyle(fontSize: 16, color: Color(0xFF2D2D2D)),
                children: [
                  TextSpan(
                    text: "Log in",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
