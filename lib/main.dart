import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/screens/home/bloc/sort_numbers_bloc.dart';
import 'package:test/screens/home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<SortNumbersBloc>(
        create: (context) => SortNumbersBloc(),
        child: const HomeScreen(),
      ),
    );
  }
}
