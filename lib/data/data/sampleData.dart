import 'package:day_07_clock_craft/data/models/clock_model.dart';
import 'package:flutter/material.dart';

final List<ClockModel> digitalClocks = [
  ClockModel(
    type: ClockType.digital,
    style: ClockStyle.flip,
    backgroundColor: Colors.black,
    needleColor: Colors.cyan,
    dialColor: Colors.grey.shade800,
    hourNumberColor: Colors.cyan,
    centerPointColor: Colors.cyan.shade700,
  ),
  ClockModel(
    type: ClockType.digital,
    style: ClockStyle.neon,
    backgroundColor: Colors.blue,
    needleColor: Colors.yellow,
    dialColor: Colors.blue.shade900,
    hourNumberColor: Colors.yellow,
    centerPointColor: Colors.orange,
  ),
  ClockModel(
    type: ClockType.digital,
    style: ClockStyle.minimal,
    backgroundColor: Colors.white,
    needleColor: Colors.black,
    dialColor: Colors.grey.shade100,
    hourNumberColor: Colors.black,
    centerPointColor: Colors.grey,
  ),
  ClockModel(
    type: ClockType.digital,
    style: ClockStyle.modern,
    backgroundColor: Colors.grey,
    needleColor: Colors.purple,
    dialColor: Colors.grey.shade300,
    hourNumberColor: Colors.purple,
    centerPointColor: Colors.purple.shade800,
  ),
  ClockModel(
    type: ClockType.digital,
    style: ClockStyle.classic,
    backgroundColor: Colors.green,
    needleColor: Colors.white,
    dialColor: Colors.green.shade200,
    hourNumberColor: Colors.white,
    centerPointColor: Colors.green.shade900,
  ),
];

// ===============================
// analog clocks

final List<ClockModel> analogClocks = [
  ClockModel(
    type: ClockType.analog,
    style: ClockStyle.transparent,
    backgroundColor: Colors.white,
    needleColor: Colors.blue,
    dialColor: Colors.grey.shade200,
    hourNumberColor: Colors.blue.shade800,
    centerPointColor: Colors.blue,
  ),
  ClockModel(
    type: ClockType.analog,
    style: ClockStyle.neon,
    backgroundColor: Colors.blue,
    needleColor: Colors.pink,
    dialColor: Colors.black,
    hourNumberColor: Colors.pink,
    centerPointColor: Colors.yellow,
  ),
  ClockModel(
    type: ClockType.analog,
    style: ClockStyle.wooden,
    backgroundColor: Colors.brown,
    needleColor: Colors.amber,
    dialColor: Colors.brown.shade300,
    hourNumberColor: Colors.brown.shade900,
    centerPointColor: Colors.amber,
  ),
  ClockModel(
    type: ClockType.analog,
    style: ClockStyle.modern,
    backgroundColor: Colors.black,
    needleColor: Colors.green,
    dialColor: Colors.grey.shade900,
    hourNumberColor: Colors.white,
    centerPointColor: Colors.green,
  ),
  ClockModel(
    type: ClockType.analog,
    style: ClockStyle.classic,
    backgroundColor: Color(0xffFFD700),
    needleColor: Colors.red,
    dialColor: Colors.amber.shade100,
    hourNumberColor: Colors.brown,
    centerPointColor: Colors.red,
  ),
];
