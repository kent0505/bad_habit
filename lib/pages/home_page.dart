import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:animated_button/animated_button.dart';

import '../cubit/time_cubit.dart';
import '../cubit/habit_cubit.dart';
import '../widgets/alert.dart';
import '../widgets/drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TimeCubit>();
    final alert = Alerts();

    return BlocBuilder<TimeCubit, int>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text('Bad Habit'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<HabitCubit, String>(
                builder: (context, state) {
                  return text(state);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  numbers('month'.tr(), cubit.month.toString().padLeft(2, '0')),
                  numbers('week'.tr(), cubit.week.toString().padLeft(2, '0')),
                  emptySpace(),
                  emptySpace()
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  numbers('day'.tr(), cubit.day.toString().padLeft(2, '0')),
                  numbers('hour'.tr(), cubit.hour.toString().padLeft(2, '0')),
                  numbers('min'.tr(), cubit.minute.toString().padLeft(2, '0')),
                  numbers('sec'.tr(), cubit.second.toString().padLeft(2, '0')),
                ],
              ),
              button('button'.tr(), () {
                alert.showAlertDialog(
                  context,
                  () {
                    cubit.button();
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget text(String text) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  Widget numbers(String date, String number) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          date,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }

  Widget button(String text, VoidCallback func) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: AnimatedButton(
        color: Colors.redAccent,
        height: 60,
        width: 140,
        onPressed: func,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget emptySpace() {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: SizedBox(width: 60, height: 60),
    );
  }
}
