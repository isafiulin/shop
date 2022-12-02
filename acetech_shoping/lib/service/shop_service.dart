import 'dart:async';
import 'package:acetech_shoping/database/database.dart';
import 'package:acetech_shoping/model/shop.dart';

class ShopService {
  final dbProvider = DataBaseProvider.dbProvider;

  Future<int> createShopItem(ShopItem shopItem) async {
    final db = await dbProvider.database;
    var result = db.insert(shopTable, shopItem.toJson());
    return result;
  }

  Future<List<ShopItem>> getShopItems(
      {List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(shopTable,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(shopTable, columns: columns);
    }

    List<ShopItem> shopItems = result.isNotEmpty
        ? result.map((item) => ShopItem.fromJson(item)).toList()
        : [];
    return shopItems;
  }

  Future<int> updateShopItem(ShopItem shopItem) async {
    final db = await dbProvider.database;

    var result = await db.update(shopTable, shopItem.toJson(),
        where: "id = ?", whereArgs: [shopItem.id]);

    return result;
  }

  Future<int> createCartItem(ShopItem shopItem) async {
    final db = await dbProvider.database;
    var result = db.insert(cartTable, shopItem.toJson());
    return result;
  }

  Future<List<ShopItem>> getCartItems(
      {List<String>? columns, String? query}) async {
    final db = await dbProvider.database;

    late List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty) {
        result = await db.query(cartTable,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
      }
    } else {
      result = await db.query(cartTable, columns: columns);
    }

    List<ShopItem> shopItems = result.isNotEmpty
        ? result.map((item) => ShopItem.fromJson(item)).toList()
        : [];
    return shopItems;
  }

  Future<int> updateCartItem(ShopItem shopItem) async {
    final db = await dbProvider.database;

    var result = await db.update(cartTable, shopItem.toJson(),
        where: "id = ?", whereArgs: [shopItem.id]);

    return result;
  }

  Future<int> deleteCartItem(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(cartTable, where: 'id = ?', whereArgs: [id]);

    return result;
  }

  Future deleteAllCartItem() async {
    final db = await dbProvider.database;
    var result = await db.delete(
      cartTable,
    );

    return result;
  }
}
