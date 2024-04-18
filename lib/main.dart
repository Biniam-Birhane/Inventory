// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_inventory/core/services/customer_injection_container.dart';
import 'package:simple_inventory/core/services/product_category_injection_container.dart';
import 'package:simple_inventory/customers/presentation/bloc/customers_bloc.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/product_category/presentation/bloc/product_category_bloc.dart';

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
      await Firebase.initializeApp(options:FirebaseOptions(apiKey:'AIzaSyA6d_XISeI6L2hI1Kwv4TJ9QVFKPnZVIWc',appId:'1:554272763565:android:50434184d201cf01802024',messagingSenderId:'554272763565',projectId:'simpleinventory-88d20') );
    }
    
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
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
          BlocProvider<ProductCategoryBloc>(
              create: (context) => pr<ProductCategoryBloc>())
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
