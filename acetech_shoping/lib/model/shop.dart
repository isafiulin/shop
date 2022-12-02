
class ShopData{
  List<ShopItem> shopitems;
  ShopData({required this.shopitems});



  void addProduct(ShopItem p) {
    shopitems.add(p);
  }

  void removeProduct(ShopItem p) {
    shopitems.remove(p);
  }
}

class ShopItem {
  int id;
  String title;
  double price;
  int quantity;

  ShopItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantity});



  factory ShopItem.fromJson(Map<String, dynamic> data) => ShopItem(
        id: data['id'],
        title: data['title'],
        price: data['price'],
        quantity: data['quantity'],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "quantity": quantity,
      };

  Map<String, dynamic> quantityMap() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }
}
