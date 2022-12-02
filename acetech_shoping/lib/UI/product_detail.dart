// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:acetech_shoping/UI/shopping_cart.dart';
import 'package:acetech_shoping/shop/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/shop.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({super.key, required this.shopItem, required this.index});
  final ShopItem shopItem;
  final int index;

  @override
  // ignore: library_private_types_in_public_api
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<ShopItem> cartItems = [];
  bool _itemSelected = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is GetShopItemState) {
          cartItems = state.cartData;
          // cartItems = state.cartData.shopitems;
          if (cartItems.any((element) => element.id == widget.shopItem.id)) {
            _itemSelected = true;
          }
        }
        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;

          if (cartItems.any((element) => element.id == widget.shopItem.id)) {
            _itemSelected = true;
          }
        }
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
          if (cartItems.any((element) => element.id == widget.shopItem.id)) {
            _itemSelected = true;
          }
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
          if (cartItems.any((element) => element.id == widget.shopItem.id)) {
            _itemSelected = true;
          }
        }
        if (state is ItemDeletedCartState) {
          cartItems = state.cartItems;
          if (cartItems.any((element) => element.id == widget.shopItem.id)) {
            _itemSelected = true;
          }
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.shopItem.title,
                style: const TextStyle(fontSize: 10),
              ),
              backgroundColor: Colors.grey,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.center,
                child: Center(
                  child: SizedBox(
                    height: 500,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.shopItem.title),
                          Text('\$${widget.shopItem.price}'),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text('Количество'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                if (widget.shopItem.quantity > 0) {
                                  setState(() {
                                    widget.shopItem.quantity--;
                                  });
                                }
                              },
                              icon: const Icon(Icons.remove)),
                          SizedBox(
                            height: 20,
                            width: 30,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black)),
                              child: Text(widget.shopItem.quantity.toString()),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.shopItem.quantity++;
                                });
                              },
                              icon: const Icon(Icons.add)),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.all(5),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                          ),
                          onPressed: () {
                            if (_itemSelected == false) {
                              if (cartItems.contains(widget.shopItem)) {
                                cartItems[widget.index].quantity +
                                    widget.shopItem.quantity;
                              } else {
                                cartItems.add(widget.shopItem);
                              }

                              BlocProvider.of<ShopBloc>(context).add(
                                  ItemAddedCartEvent(
                                      cartItems: cartItems,
                                      cartItem: widget.shopItem));

                              setState(() {
                                _itemSelected = true;
                              });
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => BlocProvider.value(
                                            value: BlocProvider.of<ShopBloc>(
                                                context)
                                              ..add(ItemAddedCartEvent(
                                                  cartItems: cartItems)),
                                            child: const ShoppingCart(),
                                          )));
                            }
                          },
                          child: Text(
                            _itemSelected ? "В корзину" : "Добавить в корзину",
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
