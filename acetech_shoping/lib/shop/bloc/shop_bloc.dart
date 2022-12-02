import 'package:acetech_shoping/helpers/catch_exceptions.dart';
import 'package:acetech_shoping/model/shop.dart';
import 'package:acetech_shoping/repository/shop_data_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopDataProvider shopDataProvider = ShopDataProvider();
  final shopRepository = ShopRepository();

  ShopBloc() : super(ShopInitial()) {
    on<ShopPageInitializedEvent>((event, emit) async {
      try {
        ShopData shopData = await shopDataProvider.getShopItems();
        // ShopData cartData = await shopDataProvider.getCartItems();
        List<ShopItem> cartData = await shopRepository.getAllCartItems();

        emit(GetShopItemState(
          shopData: shopData,
          cartData: cartData,
        ));
      } catch (e) {
        emit(GetShopItemErrorState(error: CatchException.convertException(e)));
      }
    });

    on<ItemAddingCartEvent>((event, emit) async {
      emit(ItemAddingCartState(cartItems: event.cartItems));
    });
    on<ItemAddedCartEvent>((event, emit) async {
      if (event.cartItem != null) {
        await shopRepository.insertCartItem(event.cartItem!);
      }

      emit(ItemAddedCartState(cartItems: event.cartItems));
    });
    on<ItemDeletingCartEvent>((event, emit) async {

      List<ShopItem> cartData = await shopRepository.getAllCartItems();

      emit(ItemDeletingCartState(cartItems: cartData));
    });

    on<ItemDeletedCartEvent>((event, emit) async {
      List<ShopItem> cartData = await shopRepository.getAllCartItems();

      emit(ItemDeletedCartState(cartItems: cartData));
    });
  }
}
