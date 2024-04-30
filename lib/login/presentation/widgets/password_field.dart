import "package:flutter/material.dart";

class PasswordFormField extends StatefulWidget {
  final TextEditingController controller;
   bool obscure;

   PasswordFormField({
    Key? key,
    required this.controller,
    required this.obscure,
  }) : super(key: key);

  @override
  _PasswordFormFieldState createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: const TextStyle(color: Colors.white),
      obscureText: widget.obscure,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.security, color: Colors.blue),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              widget.obscure = !widget.obscure;
            });
          },
          icon: Icon(
            widget.obscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.blue,
          ),
        ),
        labelText: 'Password',
        hintText: "Enter password",
        hintStyle: const TextStyle(color: Colors.grey),
        labelStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.grey.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.green, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

// Usage in LoginPage
// Replace the TextFormField for the password with PasswordFormField

