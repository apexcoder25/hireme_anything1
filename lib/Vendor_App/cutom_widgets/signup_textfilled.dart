import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Signup_textfilled extends StatefulWidget {
  final String? hinttext;
  final String? Function(String?)? validator;
  final TextInputType? keytype;
  final TextEditingController? textcont;
  final int? length;
  final double? textfilled_height;
  final double? textfilled_weight;
  final Function(String)? onchangeButton;
  final bool isPassword;
  final bool readOnly; // Added readOnly property
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final bool? enabled;
  final Function(String p1)? onChanged;

  const Signup_textfilled({
    super.key,
    this.hinttext,
    this.enabled,
    this.keytype,
    this.textcont,
     this.length,
     this.textfilled_height,
     this.textfilled_weight,
    this.onchangeButton,
    this.validator,
    this.maxLines,
    this.isPassword = false,
    this.readOnly = false, // Default to false
    this.inputFormatters,
    this.onChanged,
  });

  @override
  State<Signup_textfilled> createState() => _Signup_textfilledState();
}

class _Signup_textfilledState extends State<Signup_textfilled> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        height: h / (widget.textfilled_height ?? 1),
        width: w / (widget.textfilled_weight ?? 1),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: TextFormField(
              enabled: widget.enabled ?? true, // Use the enabled property
              maxLines: widget.maxLines ?? 1,
              validator: widget.validator,
              controller: widget.textcont,
              keyboardType: widget.keytype,
              onChanged: widget.onchangeButton,
              obscureText: widget.isPassword ? _obscureText : false,
              readOnly: widget.readOnly, // Use the readOnly property
              inputFormatters: [
                LengthLimitingTextInputFormatter(widget.length),
                ...?widget.inputFormatters,
              ],
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hinttext,
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          _obscureText ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}