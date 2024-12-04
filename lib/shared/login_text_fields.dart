import 'package:flutter/material.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField({
    super.key,
    required this.label,
    this.updateValue,
    required this.icon,
    required this.validate,
    this.textSize = 14,
    this.height = 1.4,
    this.controller,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final bool enabled;
  final double textSize, height;
  final String label;
  final void Function(String value)? updateValue;
  final String? Function(String? value) validate;
  final IconData icon;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _obscureText = false;
  late FocusNode _focusNode; // FocusNode pour détecter le focus du champ

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode(); // Initialisation du FocusNode

    if (widget.label == "Password" || widget.label == "Confirm Password") {
      _obscureText = true;
    }
  }

  @override
  void dispose() {
    _focusNode.dispose(); // Nettoyage du FocusNode quand le widget est détruit
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.label,
            style: TextStyle(
              fontSize: widget.textSize,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(
                  0.8), // Augmenter l'opacité pour le texte du label
            ),
          ),
        ),
        const SizedBox(height: 8), // Ajoute un espace vertical
        TextFormField(
          enabled: widget.enabled,
          controller: widget.controller,
          focusNode: _focusNode, // Ajoute le FocusNode au TextFormField
          obscureText: _obscureText,
          onSaved: (newValue) {
            if (widget.updateValue != null) {
              widget.updateValue!(newValue!);
            }
          },
          validator: (value) {
            return widget.validate(value);
          },
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          style: TextStyle(
            fontSize: widget.textSize,
            height: widget.height,
            color: Theme.of(context)
                .colorScheme
                .onSurface, // Assure que le texte a la bonne couleur
          ),
          decoration: InputDecoration(
            isDense: true,
            prefixIcon: Icon(
              widget.icon,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withOpacity(0.8), // Augmenter l'opacité pour l'icône
              size: 18,
            ),
            hintText: widget.label,
            hintStyle: TextStyle(
              fontSize: widget.textSize,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
            ),
            suffixIcon: widget.label == 'Password' ||
                    widget.label == 'New Password' ||
                    widget.label == 'Confirm Password'
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      size: 18,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: _focusNode.hasFocus
                    ? const Color(0xFF130160) // Couleur plus intense
                    : Theme.of(context).colorScheme.onSurface.withOpacity(
                        0.3), // Couleur faible quand il n'y a pas de focus
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: _focusNode.hasFocus
                    ? const Color(
                        0xFF130160) // Couleur de bordure plus intense quand le champ est focus
                    : Theme.of(context).primaryColor.withOpacity(0.9),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
