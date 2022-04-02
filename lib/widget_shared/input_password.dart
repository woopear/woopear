import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class InputPassword extends ConsumerStatefulWidget {
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 20.0);
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0);
  String labelText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;
  bool obscureText;
  void Function()? onTap;
  TextEditingController controller;
  String? initialValue;


  InputPassword({
    Key? key,
    this.margin = const EdgeInsets.only(top: 20.0),
    this.padding = const EdgeInsets.all(0.0),
    required this.labelText,
    this.onChanged,
    this.validator,
    this.obscureText = true,
    this.onTap,
    required this.controller,
    this.initialValue,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputPasswordState();
}

class _InputPasswordState extends ConsumerState<InputPassword> {
  EdgeInsetsGeometry? _margin;
  EdgeInsetsGeometry? _padding;
  String? _labelText;
  void Function(String)? _onChanged;
  String? Function(String?)? _validator;
  void Function()? _onTap;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin;
    _padding = widget.padding;
    _labelText = widget.labelText;
    _onChanged = widget.onChanged;
    _validator = widget.validator;
    _onTap = widget.onTap;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: _padding,
      child: TextFormField(
        initialValue: widget.initialValue,
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: GoogleFonts.nunito(fontSize: 20.0),
        decoration: InputDecoration(
          labelText: _labelText,
          suffixIcon: InkWell(
            onTap: _onTap,
            child: Icon(
              widget.obscureText ? Icons.visibility : Icons.visibility_off,
            ),
          ),
        ),
        validator: _validator,
        onChanged: _onChanged,
      ),
    );
  }
}
