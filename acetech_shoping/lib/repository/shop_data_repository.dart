import 'package:acetech_shoping/model/shop.dart';
import '../service/shop_service.dart';

class ShopDataProvider {
  Future<ShopData> getShopItems() async {
    List<ShopItem> shopItems = [
      ShopItem(id: 1, title: "BMW E39", price: 1500, quantity: 1),
      ShopItem(id: 2, title: "BMW E30", price: 500, quantity: 1),
      ShopItem(id: 3, title: "BMW E60", price: 300, quantity: 1),
      ShopItem(id: 4, title: "BMW E90", price: 6000, quantity: 1)
    ];

    return ShopData(shopitems: shopItems);
  }

  Future<ShopData> getCartItems() async {
    List<ShopItem> shopItems = [];

    return ShopData(shopitems: shopItems);
  }
}

class ShopRepository {
  final shopService = ShopService();

  Future getAllShopItems({String? query}) =>
      shopService.getShopItems(query: query);
  Future updateShopItem(ShopItem shopItem) =>
      shopService.updateShopItem(shopItem);

  Future getAllCartItems({String? query}) =>
      shopService.getCartItems(query: query);
  Future insertCartItem(ShopItem shopItem) =>
      shopService.createCartItem(shopItem);
  Future updateCartItem(ShopItem shopItem) =>
      shopService.updateCartItem(shopItem);
  Future deleteCartItemById(int id) => shopService.deleteCartItem(id);
  Future deleteCartShopItems() => shopService.deleteAllCartItem();
}
