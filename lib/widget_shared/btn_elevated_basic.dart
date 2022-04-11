import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BtnElevatedBasic extends ConsumerStatefulWidget {
  EdgeInsetsGeometry? margin;
  void Function() onPressed;
  String textBtn;
  String message;
  bool isLoading;

  BtnElevatedBasic({
    Key? key,
    this.margin = const EdgeInsets.only(top: 20.0),
    required this.onPressed,
    required this.textBtn,
    this.isLoading = false,
    this.message = '',
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BtnElevatedBasicState();
}

class _BtnElevatedBasicState extends ConsumerState<BtnElevatedBasic> {
  EdgeInsetsGeometry? _margin;
  String? _textBtn;
  void Function()? _onPressed;
  String? _message;

  @override
  void initState() {
    super.initState();
    _margin = widget.margin;
    _onPressed = widget.onPressed;
    _textBtn = widget.textBtn;
    _message = widget.message;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: _margin,
      child: Tooltip(
        message: _message,
        verticalOffset: 30,
        child: ElevatedButton(
          onPressed: _onPressed,
          child: widget.isLoading
              ? CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                )
              : Text(_textBtn!),
        ),
      ),
    );
  }
}
