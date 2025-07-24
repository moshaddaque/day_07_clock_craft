import 'dart:ui';

import 'package:day_07_clock_craft/data/data/sampleData.dart';
import 'package:day_07_clock_craft/presentation/pages/analog_clock_gallery.dart';
import 'package:day_07_clock_craft/presentation/pages/clock_customize_page.dart';
import 'package:day_07_clock_craft/presentation/pages/save_designs_page.dart';
import 'package:day_07_clock_craft/presentation/widgets/digital_clock_widget.dart';
import 'package:day_07_clock_craft/provider/clock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DigitalClockGallery extends StatelessWidget {
  const DigitalClockGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Digital Clock Gallery',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.indigo.shade800,
              Colors.purple.shade900,
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: digitalClocks.length,
          padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
          itemBuilder: (context, index) {
            final clock = digitalClocks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GlassmorphicContainer(
                height: 220,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.center,
                border: 1.5,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                  stops: const [0.1, 1],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.5),
                    Colors.white.withOpacity(0.2),
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          child: DigitalClockWidget(clock: clock),
                        ),
                      ),
                    ),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildActionButton(
                            icon: Icons.edit_outlined,
                            label: 'Customize',
                            color: Colors.blue.shade300,
                            onTap: () {
                              Provider.of<ClockProvider>(
                                context,
                                listen: false,
                              ).setCurrentClock(clock);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ClockCustomizePage(),
                                ),
                              );
                            },
                          ),
                          Container(
                            height: 30,
                            width: 1,
                            color: Colors.white30,
                          ),
                          _buildActionButton(
                            icon: Icons.save_outlined,
                            label: 'Save',
                            color: Colors.green.shade300,
                            onTap: () {
                              Provider.of<ClockProvider>(
                                context,
                                listen: false,
                              ).saveClock(clock);
                              _showSavedMessage(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSavedMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Clock design saved successfully!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
