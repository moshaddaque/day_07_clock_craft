import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:flutter/material.dart';

class ClockProvider extends ChangeNotifier {
  final List<ClockModel> _savedClocks = [];
  ClockModel? _currentClock;

  List<ClockModel> get savedClock => _savedClocks;
  ClockModel? get currentClock => _currentClock;

  // set
  void setCurrentClock(ClockModel clock) {
    _currentClock = clock;
    notifyListeners();
  }

  void saveClock(ClockModel clock) {
    _savedClocks.add(clock);
    notifyListeners();
  }

  void deleteClock(ClockModel clock) {
    _savedClocks.remove(clock);
    notifyListeners();
  }

  void updateClock(ClockModel oldClock, ClockModel newClock) {
    print('Updating clock: oldClock == newClock: ${oldClock == newClock}');
    print('Old clock: ${oldClock.type}, ${oldClock.style}, ${oldClock.needleColor}');
    print('New clock: ${newClock.type}, ${newClock.style}, ${newClock.needleColor}');
    
    final index = _savedClocks.indexOf(oldClock);
    print('Index in savedClocks: $index');
    
    if (index != -1) {
      _savedClocks[index] = newClock;
      
      // Also update current clock if it's the one being modified
      if (_currentClock == oldClock) {
        print('Updating current clock');
        _currentClock = newClock;
      }
      
      notifyListeners();
    } else {
      print('Clock not found in savedClocks');
      // If the clock is not found in savedClocks, it might be a new clock
      // or the equality comparison might be failing
      if (_currentClock != null && _currentClock!.type == oldClock.type && 
          _currentClock!.style == oldClock.style) {
        print('Forcing update of current clock');
        _currentClock = newClock;
        notifyListeners();
      }
    }
  }
}
