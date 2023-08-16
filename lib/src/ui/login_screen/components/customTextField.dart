import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? inicialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final Key? key;
  final TextInputType keyboardType;

  const CustomTextField({
    required this.icon,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.inicialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.key,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    isObscure = widget.isSecret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: TextFormField(
        key: widget.key,
        controller: widget.controller,
        readOnly: widget.readOnly,
        initialValue: widget.inicialValue,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        obscureText: isObscure,
        validator: widget.validator,
        decoration: InputDecoration(
          prefixIcon: Icon(widget.icon),
          suffixIcon: widget.isSecret
              ? IconButton(
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon:
            Icon(isObscure ? Icons.visibility_off : Icons.visibility),
          )
              : null,
          labelText: widget.label,
          isDense: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        ),
      ),
    );
  }
}