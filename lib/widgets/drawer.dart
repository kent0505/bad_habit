import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/habit_cubit.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final textCon = TextEditingController();

  @override
  void dispose() {
    textCon.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitCubit>();

    return BlocBuilder<HabitCubit, String>(
      builder: (context, state) {
        return Drawer(
          backgroundColor: Colors.blueGrey[300],
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              drawerHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    textField(),
                    const SizedBox(width: 10),
                    BlocBuilder<HabitCubit, String>(
                      builder: (context, state) {
                        return saveButton(() {
                          cubit.changeHabit(textCon.text);
                          FocusManager.instance.primaryFocus?.unfocus();
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'lang'.tr(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  language('en'),
                  language('ru'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget drawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blueGrey,
      ),
      child: Column(
        children: [
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset('lib/assets/icon.png', width: 70),
          ),
          const SizedBox(height: 10),
          const Text(
            'Bad Habit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget textField() {
    return Expanded(
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          controller: textCon,
          maxLength: 40,
          textCapitalization: TextCapitalization.sentences,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.grey[800],
          ),
          decoration: InputDecoration(
            counterText: '',
            contentPadding: const EdgeInsets.only(left: 10),
            border: InputBorder.none,
            hintText: 'hintText'.tr(),
            hintStyle: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget saveButton(VoidCallback func) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashFactory: InkRipple.splashFactory,
        radius: 500,
        onTap: func,
        child: Ink(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blueGrey,
          ),
          child: const Icon(
            Icons.save,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget language(String locale) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.locale == Locale(locale) ? Colors.blueGrey : Colors.blueGrey[300]!,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: GestureDetector(
            onTap: () async {
              await context.setLocale(Locale(locale));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'lib/assets/$locale.png',
                height: 50,
              ),
            ),
          ),
        ),
        Text(
          locale.toUpperCase(),
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
