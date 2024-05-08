import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/dashboard/dashbord.dart';
import 'package:simple_inventory/login/presentation/bloc/login_bloc.dart';
import 'package:simple_inventory/login/presentation/widgets/password_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obsecure = true;
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
        ),
        body: SingleChildScrollView(child: Center(child: loginBox())));
  }

  Material loginBox() {
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
                  Padding(
                      padding: EdgeInsets.only(top: 80),
                      child: Image.asset(
                        "assets/images/lock1.png",
                        height: 160,
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text("Login Page",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Quicksand",
                          fontSize: 30,
                          fontWeight: FontWeight.bold)),
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
                            labelText: "Username",
                            hintText: "Enter username or email",
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
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.green, width: 2),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        PasswordFormField(
                          controller: password,
                          obscure: obsecure,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFE8A00),
                                padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 15,
                                  horizontal: 60,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              context.read<LoginBloc>().add(LoginRequestedEvent(
                                  username: username.text,
                                  password: password.text));
                            },
                            child: state.loginStatus.isInProgress
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text('Login',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Quicksand",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold))),
                      ],
                    ),
                  ),
                ]);
          });
        }));
  }
}
