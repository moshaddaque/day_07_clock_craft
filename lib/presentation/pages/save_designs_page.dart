import 'dart:ui';

import 'package:animated_bubble_background/animated_bubble_background.dart';
import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:day_07_clock_craft/presentation/pages/clock_customize_page.dart';
import 'package:day_07_clock_craft/presentation/widgets/analog_clock_widget.dart';
import 'package:day_07_clock_craft/presentation/widgets/digital_clock_widget.dart';
import 'package:day_07_clock_craft/provider/clock_provider.dart';
import 'package:day_07_clock_craft/services/widget_expert_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class SaveDesignsPage extends StatelessWidget {
  const SaveDesignsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Saved Designs',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
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
        animationDuration: Duration(seconds: 15),

        child: Consumer<ClockProvider>(
          builder: (context, provider, child) {
            if (provider.savedClock.isEmpty) {
              return Center(
                child: GlassmorphicContainer(
                  height: 300,
                  width: 300,
                  borderRadius: 25,
                  borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.2),
                    ],
                  ),
                  linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.15),
                      Colors.white.withOpacity(0.05),
                    ],
                    stops: const [0.1, 1],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: 80,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No Saved Designs Yet',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.8),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create your first clock design',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              offset: const Offset(1, 1),
                              blurRadius: 5,
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
            return ListView.builder(
              itemCount: provider.savedClock.length,
              padding: const EdgeInsets.fromLTRB(16, 100, 16, 16),
              itemBuilder: (context, index) {
                final clock = provider.savedClock[index];
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
                              child:
                                  clock.type == ClockType.digital
                                      ? DigitalClockWidget(clock: clock)
                                      : AnalogClockWidget(clock: clock),
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
                                label: 'Edit',
                                color: Colors.blue.shade300,
                                onTap: () {
                                  provider.setCurrentClock(clock);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) =>
                                              const ClockCustomizePage(),
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
                                icon: Icons.delete_outline,
                                label: 'Delete',
                                color: Colors.red.shade300,
                                onTap: () {
                                  _showDeleteConfirmation(
                                    context,
                                    provider,
                                    clock,
                                  );
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

  void _showDeleteConfirmation(
    BuildContext context,
    ClockProvider provider,
    ClockModel clock,
  ) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.grey.shade900,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              'Delete Clock Design',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: Text(
              'Are you sure you want to delete this clock design?',
              style: GoogleFonts.poppins(color: Colors.white70),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.poppins(color: Colors.blue.shade300),
                ),
              ),
              TextButton(
                onPressed: () async {
                  provider.deleteClock(clock);
                  
                  // Update home widget after deleting clock
                  await WidgetExpertService.updateAllSavedClocks(context);
                  
                  Navigator.pop(context);
                  
                  // Show success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Clock design deleted and widget updated!',
                        style: GoogleFonts.poppins(),
                      ),
                      backgroundColor: Colors.red.shade800,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Text(
                  'Delete',
                  style: GoogleFonts.poppins(color: Colors.red.shade300),
                ),
              ),
            ],
          ),
    );
  }
}

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final double blur;
  final AlignmentGeometry alignment;
  final double border;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;

  const GlassmorphicContainer({
    Key? key,
    required this.child,
    this.height = 200,
    this.width = double.infinity,
    this.borderRadius = 20,
    this.blur = 20,
    this.alignment = Alignment.center,
    this.border = 2,
    required this.linearGradient,
    required this.borderGradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: linearGradient,
        ),
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
              child: Container(),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: Border.all(
                  width: border,
                  color: Colors.white.withOpacity(0.2),
                ),
                gradient: borderGradient,
              ),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}
