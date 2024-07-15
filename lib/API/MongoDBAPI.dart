import 'package:ideal_meal/constant.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:developer';

class MealsDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    inspect(db);

    var status = db.serverStatus();
    print(status);

    var collection = db.collection(MEALS_COLLECTION);
    print(await collection.find().toList());
  }

  Future<Map<String, dynamic>> getMeals() async {
    connect();
    
  }
}

class UsersDatabase {
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();

    inspect(db);

    var status = db.serverStatus();
    print(status);

    var collection = db.collection(USERS_COLLECTION);
    print(await collection.find().toList());
  }
}
