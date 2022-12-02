// ignore_for_file: must_be_immutable

part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitializedEvent extends ShopEvent {}

class ItemAddingCartEvent extends ShopEvent {
  ShopItem? cartItem;
  List<ShopItem> cartItems;
  ItemAddingCartEvent({required this.cartItems, this.cartItem});
}

class ItemAddedCartEvent extends ShopEvent {
  List<ShopItem> cartItems;
  ShopItem? cartItem;
  ItemAddedCartEvent({required this.cartItems, this.cartItem});
}

class ItemDeletingCartEvent extends ShopEvent {
  List<ShopItem> cartItems;
  int? indexOfItem;
  ItemDeletingCartEvent({required this.cartItems, this.indexOfItem});
}

class ItemDeletedCartEvent extends ShopEvent {
  List<ShopItem> cartItems;
  ItemDeletedCartEvent({required this.cartItems});
}
