import 'package:c2w_food_factory/GetStarted.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'order_page.dart';

dynamic database;
List<FoodItemModel> adminItemList = [];
List<FoodItemModel> itemList = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = await openDatabase(
    join(await getDatabasesPath(), 'foodAppDB.db'),
    version: 1,
    onCreate: (db, version) {
      db.execute('''CREATE TABLE food_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT,
        price REAL,
        category TEXT
      )''');
      db.execute('''CREATE TABLE user_info(
        username TEXT PRIMARY KEY,
        password TEXT
      )''');
    },
  );

  adminItemList = await getItemList();
  // itemList = await getItemFromCategory(OrderPage.selected);
  runApp(const MainApp());
}

// Returns Items list from the database
Future<List<FoodItemModel>> getItemList() async {
  final Database localDB = await database;

  List<Map<String, dynamic>> list = await localDB.query('food_items');

  return List.generate(list.length, (index) {
    return FoodItemModel(
        id: list[index]['id'],
        foodName: list[index]['name'],
        foodDescription: list[index]['description'],
        price: list[index]['price'],
        category: list[index]['category']);
  });
}

// Get Item from category
Future<List<FoodItemModel>> getItemFromCategory(String selectedCategory) async {
  final Database localDB = await database;

  List<Map<String, dynamic>> list = await localDB.query('food_items',
      where: 'category = ?', whereArgs: [selectedCategory]);

  return List.generate(list.length, (index) {
    return FoodItemModel(
        id: list[index]['id'],
        foodName: list[index]['name'],
        foodDescription: list[index]['description'],
        price: list[index]['price'],
        category: list[index]['category']);
  });
}

// Insert Food item (Only admin can insert into the databsae)
Future<void> insertFoodItem(FoodItemModel foodItem) async {
  final Database localDB = await database;

  await localDB.insert('food_items', foodItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// SignUp values (insert username and password into the database)
Future<void> insertUserInfo(String username, String password) async {
  final Database localDB = await database;

  await localDB.insert(
      'user_info', {'username': username, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<String> getUsername() async {
  final Database localDB = await database;

  List<Map<String, dynamic>> list = await localDB.query('user_info');

  return list[0]['username'];
}

Future<String> getPass() async {
  final Database localDB = await database;

  List<Map<String, dynamic>> list = await localDB.query('user_info');

  return list[0]['password'];
}

// Delete Item
Future<void> deleteItem(FoodItemModel obj) async {
  final Database localDB = await database;

  await localDB.delete('food_items', where: 'id = ?', whereArgs: [obj.id]);

  adminItemList = await getItemList();
}

// update
Future<void> updateItem(FoodItemModel obj) async {
  final Database localDB = await database;

  await localDB
      .update('food_items', obj.toMap(), where: 'id = ?', whereArgs: [obj.id]);

  adminItemList = await getItemList();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: startPage(),
    );
  }
}
