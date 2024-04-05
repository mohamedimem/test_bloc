import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'dart:math' as math show Random;

void main() => runApp(const MyApp());

const names = [
  'John',
  'Doe',
  'b',
  'd',
];

extension RandomElement<T> on Iterable<T> {
  T getRandomElement() => elementAt(math.Random().nextInt(length));
}

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
    // TODO: implement initState
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
            onPressed: cubit.pickRandomName,
            tooltip: 'Pick Random Name',
            child: const Icon(Icons.add),
          ),
          body: StreamBuilder(
            stream: cubit.stream,
            builder: (context, snapshot) {
              print(snapshot.connectionState);
              if (snapshot.connectionState == ConnectionState.active)
                return Center(
                  child: Text('No data'),
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
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
            },
          )),
    );
  }
}
