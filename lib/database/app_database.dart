import 'dart:async';
import 'package:floor/floor.dart';
import 'package:fluvie/data/dao/movie_dao.dart';
import 'package:fluvie/model/db/movie_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [MovieEntity])
abstract class AppDatabase extends FloorDatabase {
  MovieDao get movieDao;
}
