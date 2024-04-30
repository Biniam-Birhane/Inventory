// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_inventory/core/services/customer_injection_container.dart';
import 'package:simple_inventory/core/services/product_category_injection_container.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/login/presentation/bloc/login_bloc.dart';
import 'package:simple_inventory/login/presentation/pages/login_page.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';
import 'package:simple_inventory/products/presentation/bloc/products_bloc.dart';
import 'package:simple_inventory/profile/profile.dart';
import 'package:simple_inventory/reports/presentation/bloc/reports_bloc.dart';
import 'package:simple_inventory/reports/presentation/pages/report_generating_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await init();
    await productCategoryInjection();

    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyAwfWrerAUtv26xYLlMAzLm6Xe0EU1x-yk",
              authDomain: "simpleinventory-88d20.firebaseapp.com",
              projectId: "simpleinventory-88d20",
              storageBucket: "simpleinventory-88d20.appspot.com",
              messagingSenderId: "554272763565",
              appId: "1:554272763565:web:1e5e7cf87313ff8b802024"));
    } else {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: 'AIzaSyA6d_XISeI6L2hI1Kwv4TJ9QVFKPnZVIWc',
              appId: '1:554272763565:android:50434184d201cf01802024',
              messagingSenderId: '554272763565',
              projectId: 'simpleinventory-88d20'));
    }
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CustomersBloc>(
            create: (context) => sl<CustomersBloc>(),
          ),
          BlocProvider<ProductsSalesBloc>(
            create: (context) => sl<ProductsSalesBloc>(),
          ),
          BlocProvider<ReportsBloc>(create: (context) => sl<ReportsBloc>()),
          BlocProvider<LoginBloc>(create: (context) => sl<LoginBloc>()),
          BlocProvider<ProductCategoryBloc>(
              create: (context) => pr<ProductCategoryBloc>()),
          BlocProvider<ProductsBloc>(create: (context) => pr<ProductsBloc>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const Dashboard()));
  }
}
//0995616725
