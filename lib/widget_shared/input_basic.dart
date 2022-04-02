import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputBasic extends ConsumerStatefulWidget {
  EdgeInsetsGeometry margin = const EdgeInsets.only(top: 20.0);
  EdgeInsetsGeometry padding = const EdgeInsets.all(0.0);
  String labelText;
  void Function(String)? onChanged;

  InputBasic({
    Key? key,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(0.0),
    required this.labelText,
    this.onChanged,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _InputBasicState();
}

class _InputBasicState extends ConsumerState<InputBasic> {
  EdgeInsetsGeometry? _margin;
  EdgeInsetsGeometry? _padding;
  String? _labelText;
  void Function(String)? _onChanged;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin;
    _padding = widget.padding;
    _labelText = widget.labelText;
    _onChanged = widget.onChanged;
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
        onChanged: _onChanged,
      ),
    );
  }
}
