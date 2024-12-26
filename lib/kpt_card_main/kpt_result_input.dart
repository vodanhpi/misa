import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

class KptResultInput extends StatelessWidget {
  final TextEditingController controller;

  const KptResultInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Kết quả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          SizedBox(
            width: 250,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '100.000 VND',
                hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                suffixText: 'VND',
                suffixStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                TextInputFormatter.withFunction((oldValue, newValue) {
                  if (newValue.text.isEmpty) return newValue;
                  int parsedValue = int.parse(newValue.text);
                  String formattedValue = NumberFormat('#,###').format(parsedValue);
                  formattedValue = formattedValue.replaceAll(',', '.');
                  return TextEditingValue(
                    text: formattedValue,
                    selection: newValue.selection,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
