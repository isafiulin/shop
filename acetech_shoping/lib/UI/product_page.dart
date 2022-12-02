// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'product_detail.dart';
import 'shopping_cart.dart';
import 'package:acetech_shoping/model/shop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shop/bloc/shop_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool loadingData = true;
  List<ShopItem> _cartItems = [];
  late List<ShopItem> shopItems;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is ShopInitial) {
          loadingData = true;
        }
        if (state is GetShopItemState) {
          shopItems = state.shopData.shopitems;
          // _cartItems = state.cartData.shopitems;
          _cartItems = state.cartData;

          loadingData = false;
        }
        if (state is ItemAddedCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
        if (state is ItemDeletingCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
        if (state is ItemDeletedCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
        if (state is ItemAddingCartState) {
          _cartItems = state.cartItems;
          loadingData = false;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                "Каталог товаров",
                style: TextStyle(fontSize: 10),
              ),
              backgroundColor: Colors.grey,
              elevation: 0,
            ),
            backgroundColor: Colors.orange,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                              value: BlocProvider.of<ShopBloc>(context),
                              child: ShoppingCart(),
                            )));
              },
              child: Text(_cartItems.length.toString()),
            ),
            body: loadingData
                ? Center(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : SingleChildScrollView(
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: shopItems.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlocProvider.value(
                                              value: BlocProvider.of<ShopBloc>(
                                                  context)
                                                ..add(ItemAddingCartEvent(
                                                    cartItems: _cartItems)),
                                              child: ProductDetail(
                                                  shopItem: shopItems[index],
                                                  index: index),
                                            )));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: 250,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0, 30),
                                              blurRadius: 60,
                                              color: const Color(0xFF393939)
                                                  .withOpacity(.1))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(children: const []),
                                  ),
                                  Positioned(
                                      top: 10,
                                      right: 15,
                                      child: Text(shopItems[index].title)),
                                  Positioned(
                                      top: 30,
                                      right: 15,
                                      child:
                                          Text('\$${shopItems[index].price}')),
                                  Positioned(
                                    bottom: 20,
                                    right: 8,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(6),
                                        foregroundColor: Colors.white,
                                        backgroundColor: Colors.blue,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          // _cartItems.any((element) => element.id == shopItems[index].id
                                          if (_cartItems.any((element) =>
                                              element.id ==
                                              shopItems[index].id)) {
                                          } else {
                                            _cartItems.add(shopItems[index]);

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemAddedCartEvent(
                                                    cartItems: _cartItems,
                                                    cartItem:
                                                        shopItems[index]));
                                          }
                                        });
                                      },
                                      child: const Text(
                                        "Добавить в корзину",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
          );
        },
      ),
    );
  }
}
