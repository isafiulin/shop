// ignore_for_file: must_be_immutable

part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class GetShopItemState extends ShopState {
  ShopData shopData;
  // ShopData cartData;
  List<ShopItem> cartData;

  GetShopItemState({required this.cartData, required this.shopData});
}

class ItemAddingCartState extends ShopState {
  // ShopData? cartData;
  List<ShopItem> cartItems;

  ItemAddingCartState({required this.cartItems});
  @override
  List<Object> get props => [cartItems];
}

class ItemAddedCartState extends ShopState {
  // ShopData? carData;
  List<ShopItem> cartItems;

  ItemAddedCartState({required this.cartItems});
}

class ItemDeletingCartState extends ShopState {
  List<ShopItem> cartItems;

  ItemDeletingCartState({required this.cartItems});
}

class ItemDeletedCartState extends ShopState {
  List<ShopItem> cartItems;

  ItemDeletedCartState({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class GetShopItemErrorState extends ShopState {
  final CatchException error;

  const GetShopItemErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
