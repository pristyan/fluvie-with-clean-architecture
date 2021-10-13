import 'package:flutter/material.dart';
import 'package:fluvie/factory/core_factory.dart';
import 'package:fluvie/presentation/moviedetail/movie_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: CoreFactory.initializeDatabase(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const MovieDetailScreen(),
          );
        } else {
          return Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
          );
        }
      },
    );
  }
}
