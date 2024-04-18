// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_inventory/core/services/injection_container.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/products_sales/presentation/bloc/products_sales_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCqgURIOg7aqVIn_IXz76ygbFw0nyJHzoU",
        appId: "1:961256701262:web:7e7a6ca28784dce97eb21f",
        messagingSenderId: "961256701262",
        projectId: "simple-inventory-10154",
      ),
    );
  }
  // } else {
  //   await Firebase.initializeApp();
  // }
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<CustomersBloc>(
            create: (context) => sl<CustomersBloc>(),
          ),
          BlocProvider<ProductsSalesBloc>(
              create: (context) => sl<ProductsSalesBloc>())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: Dashboard()));
  }
}
