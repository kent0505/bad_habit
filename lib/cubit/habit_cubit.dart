import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class HabitCubit extends Cubit<String> {
  HabitCubit(super.initialState);

  String habit = '';

  void restoreData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    habit = prefs.getString('habit') ?? 'emptyHabit'.tr();
    if (habit.isEmpty) {
      habit = 'emptyHabit'.tr();
    }
    print(habit);
    emit(habit);
  }

  void changeHabit(String text) async {
    if (text != '') {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('habit', text);
      emit(text);
    }
  }
}
