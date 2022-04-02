import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputBasic extends ConsumerStatefulWidget {
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 10.0);
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0);
  String labelText;
  void Function(String)? onChanged;
  String? Function(String?)? validator;

  InputBasic({
    Key? key,
    this.margin = const EdgeInsets.only(top: 10.0),
    this.padding = const EdgeInsets.all(0.0),
    required this.labelText,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputBasicState();
}

class _InputBasicState extends ConsumerState<InputBasic> {
  EdgeInsetsGeometry? _margin;
  EdgeInsetsGeometry? _padding;
  String? _labelText;
  void Function(String)? _onChanged;
  String? Function(String?)? _validator;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin;
    _padding = widget.padding;
    _labelText = widget.labelText;
    _onChanged = widget.onChanged;
    _validator = widget.validator;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      padding: _padding,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: _labelText,
        ),
        validator: _validator,
        onChanged: _onChanged,
      ),
    );
  }
}
