// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:acetech_shoping/UI/product_page.dart';
import 'package:acetech_shoping/shop/bloc/shop_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: BlocProvider(
        create: (context) => ShopBloc()..add(ShopPageInitializedEvent()),
        lazy: true,
        child: const ProductPage(),
      ),
    );
  }
}
