// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:acetech_shoping/model/shop.dart';
import 'package:acetech_shoping/shop/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<ShopItem> cartItems = [];
  double totalAmount = 0;
  void funTotalAmount(List<ShopItem> list) {
    double amount = 0;
    for (var element in list) {
      amount = amount + element.price * element.quantity;
    }

    totalAmount = amount;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {
        if (state is GetShopItemState) {
          // cartItems = state.cartData.shopitems;
          cartItems = state.cartData;
        }
        if (state is ItemAddedCartState) {
          cartItems = state.cartItems;
        }
        if (state is ItemDeletingCartState) {
          cartItems = state.cartItems;
        }
        if (state is ItemDeletedCartState) {
          cartItems = state.cartItems;
        }
        if (state is ItemAddingCartState) {
          cartItems = state.cartItems;
        }
      },
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ItemAddedCartState) {
            cartItems = state.cartItems;
            funTotalAmount(cartItems);
          }

          if (state is GetShopItemState) {
            // cartItems = state.cartData.shopitems;
            cartItems = state.cartData;

            funTotalAmount(cartItems);
          }

          if (state is ItemDeletingCartState) {
            cartItems = state.cartItems;
            funTotalAmount(cartItems);
          }
          if (state is ItemDeletedCartState) {
            cartItems = state.cartItems;
            funTotalAmount(cartItems);
          }
          if (state is ItemAddingCartState) {
            cartItems = state.cartItems;
            funTotalAmount(cartItems);
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text("Корзина"),
              backgroundColor: Colors.grey,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.orange,
            body: cartItems.isEmpty
                ? const Center(child: Text("Ваша корзина пуста"))
                : ListView.builder(
                    key: Key(cartItems.length.toString()),
                    itemCount: cartItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(cartItems[index].title),
                                      Text('\$${cartItems[index].price}'),
                                    ],
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          // print("${cartItems[index].id}");
                                          // print("$index");

                                          if (state is GetShopItemState) {
                                            // cartItems.remove(index);
                                            funTotalAmount(cartItems);

                                            ShopBloc()
                                                .shopRepository
                                                .deleteCartItemById(
                                                    cartItems[index].id);

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemDeletingCartEvent(
                                              cartItems: cartItems,
                                            ));
                                          } else if (state
                                              is ItemAddedCartState) {
                                            funTotalAmount(cartItems);

                                            ShopBloc()
                                                .shopRepository
                                                .deleteCartItemById(
                                                    cartItems[index].id);

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemDeletingCartEvent(
                                              cartItems: cartItems,
                                            ));
                                          } else if (state
                                              is ItemAddingCartState) {
                                            funTotalAmount(cartItems);

                                            ShopBloc()
                                                .shopRepository
                                                .deleteCartItemById(
                                                    cartItems[index].id);

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemDeletingCartEvent(
                                              cartItems: cartItems,
                                            ));
                                          } else if (state
                                              is ItemDeletingCartState) {
                                            funTotalAmount(cartItems);
                                            ShopBloc()
                                                .shopRepository
                                                .deleteCartItemById(
                                                    cartItems[index].id);

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemDeletedCartEvent(
                                              cartItems: cartItems,
                                            ));
                                          } else if (state
                                              is ItemDeletedCartState) {
                                            funTotalAmount(cartItems);

                                            ShopBloc()
                                                .shopRepository
                                                .deleteCartItemById(
                                                    cartItems[index].id);
                                            // ShopBloc()
                                            //     .shopRepository
                                            //     .deleteCartShopItems();

                                            BlocProvider.of<ShopBloc>(context)
                                                .add(ItemDeletingCartEvent(
                                              cartItems: cartItems,
                                            ));
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.cancel))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        if (cartItems[index].quantity > 0) {
                                          setState(() {
                                            cartItems[index].quantity--;
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
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: Text(
                                          cartItems[index].quantity.toString()),
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        setState(() {
                                          cartItems[index].quantity++;
                                        });
                                      },
                                      icon: const Icon(Icons.add)),
                                  Text(
                                      '\$${cartItems[index].price * cartItems[index].quantity}')
                                ],
                              ),
                            ]),
                          ),
                        ),
                      );
                    },
                  ),
            bottomNavigationBar: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 1),
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.20)),
                    BoxShadow(
                        offset: const Offset(0, -1),
                        blurRadius: 3,
                        color: Colors.black.withOpacity(0.20)),
                    BoxShadow(
                        offset: const Offset(0, -1),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.14)),
                  ],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(children: [
                  const Text(
                    "Итого",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "\$${totalAmount.toStringAsFixed(2)}",
                    style: const TextStyle(color: Colors.white),
                  )
                ]),
              ),
            ),
          );
        },
      ),
    );
  }
}
