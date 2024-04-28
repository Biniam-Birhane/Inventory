import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/login/presentation/bloc/login_bloc.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF151D26),
        appBar: AppBar(
          backgroundColor: const Color(0xFF151D26),
          title: const Text("Board Inventory",
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          centerTitle: true,
        ),
        body: Container(
          child: loginBox(context),
        ));
  }

  Material loginBox(BuildContext context) {
    TextEditingController username = TextEditingController();
    TextEditingController password = TextEditingController();
    return Material(
        type: MaterialType.transparency,
        child: Builder(builder: (context) {
          return BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
            print(state.loginStatus);
            if (state.loginStatus.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Colors.red,
                content: Text(
                  state.errorMessage,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ));
            } else if (state.loginStatus.isSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const Dashboard()));
            }
          }, builder: (context, state) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                //
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          controller: username,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.blue),
                              labelText: 'Username',
                              hintText: "username or email",
                              hintStyle: const TextStyle(color: Colors.grey),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: password,
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.security,
                                  color: Colors.blue),
                              labelText: 'Password',
                              hintText: "Enter username",
                              hintStyle: const TextStyle(color: Colors.grey),
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 1.5,
                                ),
                              )),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 8.0,
                            ),
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginRequestedEvent(
                                  username: username.text,
                                  password: password.text));
                            },
                            child: const Text('login',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ]);
          });
        }));
  }
}
