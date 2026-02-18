import 'package:flutter/material.dart';
import 'package:hello_chat/constants.dart';

class Customtextfield extends StatefulWidget {
  Customtextfield({
    Key? key,
    this.text,
    this.onChanged,
    this.errorText,
  }) : super(key: key);

  final String? text;
  final Function(String)? onChanged;
  final String? errorText;

  @override
  State<Customtextfield> createState() => _CustomtextfieldState();
}

class _CustomtextfieldState extends State<Customtextfield> {
  bool isHidden = true;

  bool get isPassword =>
      widget.text == 'Password' ||
      widget.text == 'Create Password' ||
      widget.text == 'Confirm Password';

  final Map<String, IconData> iconMap = {
    'Username': Icons.person,
    'Email address': Icons.email,
    'phone number': Icons.phone,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0.2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (data){
              if (data == null || data.isEmpty) {
                return 'Please enter ${widget.text}';
              }
              return null;
            },
            onChanged: widget.onChanged,
            obscureText: isPassword ? isHidden : false,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.text,
              hintStyle: const TextStyle(
                color: kTextHintColor,
                fontFamily: kmainFont,
              ),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        isHidden ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey,
                        size: 21,
                      ),
                      onPressed: () {
                        setState(() {
                          isHidden = !isHidden;
                        });
                      },
                    )
                  : iconMap.containsKey(widget.text)
                      ? Icon(
                          iconMap[widget.text],
                          color: Colors.grey,
                          size: 21,
                        )
                      : null,
            ),
          ),
          if (widget.errorText != null)
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Text(
                widget.errorText!,
                style: const TextStyle(color: Color.fromARGB(255, 209, 15, 1), fontSize: 12 , fontFamily: kmainFont),
              ),
            ),
        ],
      ),
    );
  }
}
