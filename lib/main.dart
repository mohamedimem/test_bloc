import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:test_bloc/extensions/extensions.dart';

void main() => runApp(const MyApp());

const names = [
  'John',
  'Doe',
  'b',
  'd',
];
const numbers = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
];

class NamesCubit extends Cubit<String?> {
  NamesCubit() : super(null);

  void pickRandomName() {
    emit(names.getRandomElement());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final NamesCubit cubit;

  @override
  void initState() {
    cubit = NamesCubit();
    super.initState();
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            cubit.pickRandomName();
          },
          tooltip: 'Pick Random Name',
          child: const Icon(Icons.add),
        ),
        body: StreamBuilder(
          stream: cubit.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Random Name:',
                    ),
                    Text(
                      '${snapshot.data}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ],
                ),
              );
            } else
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
          },
        ),
      ),
    );
  }
}
