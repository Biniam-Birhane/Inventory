import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:simple_inventory/bottomPage/bottom_items_list.dart';
import 'package:simple_inventory/bottomPage/bottom_logic.dart';
import 'package:simple_inventory/bottomPage/common_bottom_bar.dart';
import 'package:simple_inventory/login/presentation/bloc/login_bloc.dart';
import 'package:simple_inventory/login/presentation/pages/login_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  int selectedIndex = 2;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    bottomLogic(selectedIndex, context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF151D26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151D26),
        title: Text("Profile",
            style: TextStyle(
                fontFamily: 'Quicksand',
                color: Colors.white,
                fontSize: size.width * 0.05)),
      ),
      body: BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
        if (state.addUserStatus.isSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                'user created successfuly',
                style: TextStyle(color: Colors.white),
              )));
          Navigator.pop(context);
        } else if (state.addUserStatus.isFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.white),
              )));
        }
      }, builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              backgroundImage(size,state.loggedInUsername),
              SizedBox(
                height: size.height * 0.02,
              ),
              // Text(state.loggedInUsername,
              //     style: const TextStyle(
              //         color: Colors.green,
              //         fontFamily: 'Quicksand',
              //         fontSize: 20)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListTile(
                    horizontalTitleGap: 30,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return addUser(context, state);
                        },
                      );
                    },
                    leading: const CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      "Add User",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: size.width * 0.05),
                    ),
                    trailing: const Icon(
                      Icons.forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListTile(
                    horizontalTitleGap: 30,
                    leading: const CircleAvatar(
                      child: Icon(Icons.local_activity),
                    ),
                    title: Text(
                      "Recent activities",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: size.width * 0.05),
                    ),
                    trailing: const Icon(
                      Icons.local_activity,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: ListTile(
                    horizontalTitleGap: 30,
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                      // context.read<LoginBloc>().add(LogOutEvent());
                    },
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      "Logout ",
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.red,
                          fontSize: size.width * 0.05),
                    ),
                    trailing: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
      bottomNavigationBar: CommonBottomBar(
          items: bottomBarItems,
          currentIndex: selectedIndex,
          onTap: _onItemTapped),
    );
  }

  Material addUser(BuildContext context, LoginState state) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          // height: 200,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(5),
          decoration: const BoxDecoration(
              color: Color(0xFF151D26),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Register user',
                    style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.white,
                        fontSize: 20)),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  controller: email,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.blue),
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
                      prefixIcon:
                          const Icon(Icons.security, color: Colors.blue),
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
                  onPressed: () {
                    if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      context.read<LoginBloc>().add(AddUserEvent(
                          email: email.text, password: password.text));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('The fields are required',
                              style: TextStyle(color: Colors.white))));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFE8A00),
                      padding: const EdgeInsetsDirectional.symmetric(
                        vertical: 10,
                        horizontal: 60,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  child: state.addUserStatus.isInProgress
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: "Quicksand",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Stack backgroundImage(Size size, String loggedInUsername) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/background.jpg',
          width: size.width,
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
        const Positioned(
          bottom: 10,
          left: 20,
          child: CircleAvatar(
            foregroundImage: AssetImage('assets/images/logo.png'),
            radius: 40,
          ),
        ),
        Positioned(
            width: size.width * 0.7,
            bottom: 10,
            left: 100,
            child: ListTile(
              title: Text(
                loggedInUsername,
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: size.width * 0.05),
              ),
              subtitle: Text(
                "Manager",
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    color: Colors.white,
                    fontSize: size.width * 0.05),
              ),
              trailing: IconButton(
                  onPressed: () {}, color: Colors.grey, icon: Icon(Icons.edit)),
            ))
      ],
    );
  }
}
