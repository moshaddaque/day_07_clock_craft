import 'dart:ui';

import 'package:animated_bubble_background/animated_bubble_background.dart';
import 'package:day_07_clock_craft/presentation/pages/analog_clock_gallery.dart';
import 'package:day_07_clock_craft/presentation/pages/digital_clock_gallery.dart';
import 'package:day_07_clock_craft/presentation/pages/save_designs_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clock Design', style: GoogleFonts.poppins()),
        backgroundColor: Colors.transparent,
      ),
      body: AnimatedBubbleBackground(
        bubbleCount: 50,
        bubbleColors: [
          Colors.blue,
          Colors.purple,
          Colors.pink,
          Colors.cyan,
          Colors.teal,
        ],
        minBubbleSize: 40.0,
        maxBubbleSize: 120.0,
        animationDuration: Duration(seconds: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Welcome to click Design',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  children: [
                    _buildNavButton(
                      context,
                      'Digital Clocks',
                      const DigitalClockGallery(),
                    ),
                    _buildNavButton(
                      context,
                      'Analog Clocks',
                      const AnalogClockGallery(),
                    ),
                    _buildNavButton(
                      context,
                      'Saved Designs',
                      const SaveDesignsPage(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //==================================

  Widget _buildNavButton(BuildContext context, String title, Widget page) {
    return GlassmorphicContainer(
      height: 150,
      width: double.infinity,
      borderRadius: 15,
      blur: 10,
      alignment: Alignment.center,
      border: 1.5,
      linearGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Colors.white.withOpacity(0.15),
          Colors.white.withOpacity(0.05),
        ],
        stops: const [0.1, 1],
      ),
      borderGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.white.withOpacity(0.5), Colors.white.withOpacity(0.2)],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          },
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.8),
                    offset: const Offset(1, 1),
                    blurRadius: 5,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
