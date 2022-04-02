import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnElevatedBasic extends ConsumerStatefulWidget {
  EdgeInsetsGeometry? margin;
  void Function() onPressed;
  String textBtn;

  BtnElevatedBasic({
    Key? key,
    this.margin = const EdgeInsets.only(top: 20.0),
    required this.onPressed,
    required this.textBtn,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BtnElevatedBasicState();
}

class _BtnElevatedBasicState extends ConsumerState<BtnElevatedBasic> {
  EdgeInsetsGeometry? _margin;
  String? _textBtn;
  void Function()? _onPressed;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin;
    _onPressed = widget.onPressed;
    _textBtn = widget.textBtn;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: _margin,
      child: ElevatedButton(
        onPressed: _onPressed,
        child: Text(_textBtn!),
      ),
    );
  }
}
