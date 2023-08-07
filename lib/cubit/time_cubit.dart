import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TimeCubit extends Cubit<int> {
  TimeCubit(super.initialState);

  int timestamp = 0;
  int duration = 0;

  late int month = 0;
  late int week = 0;
  late int day = 0;
  late int hour = 0;
  late int minute = 0;
  late int second = 0;

  Timer? timer;

  void restoreData() async {
    // получить тот timestamp который хранится в локальном хранилище
    SharedPreferences prefs = await SharedPreferences.getInstance();
    timestamp = prefs.getInt('timestamp') ?? 1691394875000;

    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // получить текущий timestamp когда пользователь запустил приложение
      DateTime now = DateTime.now();
      int current = now.millisecondsSinceEpoch;
      // создать 2 переменных с типом DateTime
      DateTime t1 = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
      DateTime t2 = DateTime.fromMicrosecondsSinceEpoch(current * 1000);
      // сравнить эти переменные
      Duration difference = t2.difference(t1);
      // для нужного отображения
      month = (difference.inDays / 30).floor();
      week = (difference.inDays / 7).floor();
      day = difference.inDays;
      hour = difference.inHours.remainder(24);
      minute = difference.inMinutes.remainder(60);
      second = difference.inSeconds.remainder(60);
      emit(second);
    });
  }

  void button() async {
    timer!.cancel();
    second = 0;
    emit(second);
    // получить текущий timestamp
    DateTime now = DateTime.now();
    timestamp = now.millisecondsSinceEpoch;
    // сохранить в локальном хранилище
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('timestamp', timestamp);
    restoreData();
  }
}
