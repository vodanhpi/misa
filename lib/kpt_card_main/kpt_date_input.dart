import 'package:flutter/material.dart';

class KptDateInput extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onDateSelect;

  const KptDateInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onDateSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Ngày Nhập: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              SizedBox(
                width: 250,
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_outlined),
                      onPressed: onDateSelect,
                    ),
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
