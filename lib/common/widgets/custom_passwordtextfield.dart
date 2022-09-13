import "package:flutter/material.dart";
import "package:flutter/services.dart";

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final RegExp regex;
  final String emptyText;
  final String regexText;

  PasswordTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
    required this.regex,
    required this.emptyText,
    required this.regexText,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState(
      controller: controller,
      hintText: hintText,
      maxLength: maxLength,
      regex: regex,
      emptyText: emptyText,
      regexText: regexText);

  // return TextFormField(
  //   maxLines: null,
  //   keyboardType: TextInputType.multiline,
  //   controller: controller,
  //   decoration: InputDecoration(
  //     hintText: hintText,
  //     border: const OutlineInputBorder(
  //         borderSide: BorderSide(
  //       color: Colors.black12,
  //     )),
  //     enabledBorder: const OutlineInputBorder(
  //         borderSide: BorderSide(
  //       color: Colors.black12,
  //     )),
  //   ),
  //   validator: (val) {
  //     if (val == null || val.isEmpty) {
  //       return emptyText;
  //     } else {
  //       if (!regex.hasMatch(val)) {
  //         return regexText;
  //       }
  //     }

  //     return null;
  //   },
  //   inputFormatters: [
  //     LengthLimitingTextInputFormatter(maxLength),
  //   ],
  // );
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;
  final RegExp regex;
  final String emptyText;
  final String regexText;
  bool _masking = true;

  _PasswordTextFieldState({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.maxLength,
    required this.regex,
    required this.emptyText,
    required this.regexText,
  }) : super();

  @override
  Widget build(BuildContext context) {
    void _toggle() {
      setState(() {
        _masking = !_masking;
      });
    }

    return Row(
      children: <Widget>[
        Flexible(
          child: TextFormField(
            maxLines: 1,
            keyboardType: TextInputType.multiline,
            controller: controller,
            decoration: InputDecoration(
                hintText: hintText,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                  color: Colors.black12,
                )),
                suffixIcon: GestureDetector(
                  onTap: _toggle,
                  child: Icon(
                    _masking ? Icons.visibility_off : Icons.visibility,
                  ),
                )),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return emptyText;
              } else {
                if (!regex.hasMatch(val)) {
                  return regexText;
                }
              }

              return null;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(maxLength),
            ],
            obscureText: _masking,
          ),
        ),
      ],
    );
  }
}
