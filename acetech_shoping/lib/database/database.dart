import 'dart:io';
import 'dart:async';

import 'package:acetech_shoping/model/shop.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

const shopTable = "ShopItem";
const cartTable = "CartItem";

class DataBaseProvider {
  DataBaseProvider._();
  static final DataBaseProvider dbProvider = DataBaseProvider._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await createDatabase();
    return _database!;
  }

  createDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "AceTechShop.db");

    return await openDatabase(path, version: 1, onOpen: (database) {},
        onCreate: (Database database, int version) async {
      await database.execute("CREATE TABLE $cartTable ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "price DOUBLE,"
          "quantity INTEGER"
          ")");
    });
  }

  Future<ShopItem> insert(ShopItem shopItem) async {
    var dbClient = await database;
    await dbClient.insert('shopItem', shopItem.toJson());
    return shopItem;
  }

  Future<List<ShopItem>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult =
        await dbClient.query('shopItem');
    return queryResult.map((result) => ShopItem.fromJson(result)).toList();
  }

  Future<int> updateQuantity(ShopItem shopItem) async {
    var dbClient = await database;
    return await dbClient.update('shopItem', shopItem.quantityMap(),
        where: "productId = ?", whereArgs: [shopItem.id]);
  }

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient.delete('shopItem', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<ShopItem>> getCartId(int id) async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryIdResult =
        await dbClient.query('cart', where: 'id = ?', whereArgs: [id]);
    return queryIdResult.map((e) => ShopItem.fromJson(e)).toList();
  }
}
