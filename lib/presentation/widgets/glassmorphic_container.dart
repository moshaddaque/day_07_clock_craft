// Glass effect container widget without BackdropFilter for better Impeller performance
import 'package:flutter/material.dart';

class GlassmorphicContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final double blur; // Kept for API compatibility but not used with BackdropFilter
  final AlignmentGeometry alignment;
  final double border;
  final LinearGradient linearGradient;
  final LinearGradient borderGradient;
  final List<BoxShadow>? boxShadow;

  const GlassmorphicContainer({
    super.key,
    required this.child,
    this.height = 200,
    this.width = double.infinity,
    this.borderRadius = 20,
    this.blur = 20, // Kept for API compatibility
    this.alignment = Alignment.center,
    this.border = 2,
    required this.linearGradient,
    required this.borderGradient,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    // Instead of using BackdropFilter which causes Impeller performance issues,
    // we'll use a combination of opacity and gradients to simulate the glass effect
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: linearGradient,
          boxShadow: boxShadow ?? [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              width: border,
              color: Colors.white.withOpacity(0.2),
            ),
            gradient: borderGradient,
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.05),
                blurRadius: 5,
                spreadRadius: 1,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
