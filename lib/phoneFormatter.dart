import 'package:flutter/services.dart';

class PhoneFormatter extends TextInputFormatter {
  final String amostra = '00000-0000';
  final String separador = '-';

  PhoneFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      var isNumber = RegExp(r'[0-9]');
      if (!isNumber.hasMatch(newValue.text[newValue.text.length - 1])) {
        if (newValue.text.length < oldValue.text.length) {
          return newValue;
        }
        return oldValue;
      }
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > amostra.length) return oldValue;
        if (newValue.text.length < amostra.length &&
            amostra[newValue.text.length - 1] == separador) {
          return TextEditingValue(
              text:
                  '${oldValue.text}$separador${newValue.text.substring(newValue.text.length - 1)}',
              selection: TextSelection.collapsed(
                offset: newValue.selection.end + 1,
              ));
        }
      }
    }
    return newValue;
  }
}
