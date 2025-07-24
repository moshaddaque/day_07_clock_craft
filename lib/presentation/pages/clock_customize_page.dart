import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:day_07_clock_craft/provider/clock_provider.dart';
import 'package:day_07_clock_craft/services/widget_expert_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ClockCustomizePage extends StatefulWidget {
  const ClockCustomizePage({super.key});

  @override
  State<ClockCustomizePage> createState() => _ClockCustomizePageState();
}

class _ClockCustomizePageState extends State<ClockCustomizePage> {
  late ClockModel _editedClock;
  final List<Color> _presetColors = [
    Colors.white,
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize with the current clock from provider
    final provider = Provider.of<ClockProvider>(context, listen: false);
    _editedClock = provider.currentClock ?? 
        ClockModel(type: ClockType.digital, style: ClockStyle.minimal);
  }

  void _saveChanges() async {
    print('Saving changes');
    final provider = Provider.of<ClockProvider>(context, listen: false);
    print('Current clock: ${provider.currentClock?.type}, ${provider.currentClock?.style}, ${provider.currentClock?.needleColor}');
    print('Edited clock: ${_editedClock.type}, ${_editedClock.style}, ${_editedClock.needleColor}');
    
    // Always save as a new design
    print('Saving as new clock design');
    provider.saveClock(_editedClock);
    
    // Update the home widget with the new clock design
    await WidgetExpertService.updateClockWidget(_editedClock);
    await WidgetExpertService.updateAllSavedClocks(context);
    
    // Force a rebuild of the UI
    setState(() {});
    
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Clock design saved and widget updated!',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.green.shade800,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      ),
    );
    
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Customize Clock',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
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
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Clock Type'),
                _buildClockTypeSelector(),
                
                _buildSectionTitle('Clock Style'),
                _buildClockStyleSelector(),
                
                _buildSectionTitle('Background Color'),
                _buildColorSelector(
                  selectedColor: _editedClock.backgroundColor,
                  onColorSelected: (color) {
                    setState(() {
                      _editedClock = _editedClock.copyWith(
                        backgroundColor: color,
                      );
                    });
                  },
                ),
                
                _buildSectionTitle('Needle/Text Color'),
                _buildColorSelector(
                  selectedColor: _editedClock.needleColor,
                  onColorSelected: (color) {
                    setState(() {
                      _editedClock = _editedClock.copyWith(
                        needleColor: color,
                      );
                    });
                  },
                ),
                
                if (_editedClock.type == ClockType.analog) ...[                
                  _buildSectionTitle('Dial Color'),
                  _buildColorSelector(
                    selectedColor: _editedClock.dialColor,
                    onColorSelected: (color) {
                      setState(() {
                        _editedClock = _editedClock.copyWith(
                          dialColor: color,
                        );
                      });
                    },
                  ),
                  
                  _buildSectionTitle('Hour Number Color'),
                  _buildColorSelector(
                    selectedColor: _editedClock.hourNumberColor,
                    onColorSelected: (color) {
                      setState(() {
                        _editedClock = _editedClock.copyWith(
                          hourNumberColor: color,
                        );
                      });
                    },
                  ),
                  
                  _buildSectionTitle('Center Point Color'),
                  _buildColorSelector(
                    selectedColor: _editedClock.centerPointColor,
                    onColorSelected: (color) {
                      setState(() {
                        _editedClock = _editedClock.copyWith(
                          centerPointColor: color,
                        );
                      });
                    },
                  ),
                ],
                
                _buildSectionTitle('Font Family'),
                _buildFontFamilySelector(),
                
                _buildSectionTitle('Additional Options'),
                _buildSwitchOption(
                  title: '24-Hour Format',
                  value: _editedClock.is24hour,
                  onChanged: (value) {
                    setState(() {
                      _editedClock = _editedClock.copyWith(
                        is24hour: value,
                      );
                    });
                  },
                ),
                
                _buildSwitchOption(
                  title: 'Show Weather',
                  value: _editedClock.showWeather,
                  onChanged: (value) {
                    setState(() {
                      _editedClock = _editedClock.copyWith(
                        showWeather: value,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildClockTypeSelector() {
    return Row(
      children: [
        Expanded(
          child: _buildSelectionTile(
            title: 'Digital',
            isSelected: _editedClock.type == ClockType.digital,
            onTap: () {
              setState(() {
                _editedClock = _editedClock.copyWith(
                  type: ClockType.digital,
                );
              });
            },
          ),
        ),
        Expanded(
          child: _buildSelectionTile(
            title: 'Analog',
            isSelected: _editedClock.type == ClockType.analog,
            onTap: () {
              setState(() {
                _editedClock = _editedClock.copyWith(
                  type: ClockType.analog,
                );
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildClockStyleSelector() {
    final styles = _editedClock.type == ClockType.digital
        ? [ClockStyle.flip, ClockStyle.neon, ClockStyle.minimal, ClockStyle.modern, ClockStyle.classic]
        : [ClockStyle.transparent, ClockStyle.neon, ClockStyle.wooden, ClockStyle.modern, ClockStyle.classic];

    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: styles.map((style) {
        return _buildStyleChip(
          label: style.toString().split('.').last,
          isSelected: _editedClock.style == style,
          onTap: () {
            setState(() {
              _editedClock = _editedClock.copyWith(style: style);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildColorSelector({
    required Color selectedColor,
    required Function(Color) onColorSelected,
  }) {
    return Wrap(
      spacing: 12.0,
      runSpacing: 12.0,
      children: _presetColors.map((color) {
        return GestureDetector(
          onTap: () => onColorSelected(color),
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: selectedColor == color
                    ? Colors.white
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildFontFamilySelector() {
    final fonts = ['Roboto', 'Poppins', 'Lato', 'Montserrat', 'OpenSans'];
    
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: fonts.map((font) {
        return _buildStyleChip(
          label: font,
          isSelected: _editedClock.fontFamily == font,
          onTap: () {
            setState(() {
              _editedClock = _editedClock.copyWith(fontFamily: font);
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildSelectionTile({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildStyleChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withOpacity(0.2)
              : Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected
                ? Colors.white.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchOption({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.tealAccent,
          ),
        ],
      ),
    );
  }
}
