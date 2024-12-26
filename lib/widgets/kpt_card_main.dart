import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:my_screen/data/kpt_data.dart';
import 'package:my_screen/screens/feedback_screen.dart';

class KptCard extends StatelessWidget {
  final Kpt data;
  final bool isExpanded;
  final VoidCallback onExpandedChanged;
  final TextEditingController dateController;
  final Function(BuildContext) selectDate;


  const KptCard({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.dateController,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and expand button
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4.0),
                  child: Row(
                    children: [
                      if (isExpanded) const Icon(Icons.error_rounded, color: Colors.red),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          data.title,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: IconButton(
                  onPressed: onExpandedChanged,
                  icon: Icon(isExpanded ? Icons.chevron_right : Icons.expand_more),
                ),
              ),
            ],
          ),
          const Divider(color: Colors.grey, thickness: 1.0),
          if (!isExpanded) ...[
            _buildRow('Thời gian', data.time),
            const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
            _buildRow('Tần suất', data.frequency),
            const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
            _buildRow('Chỉ tiêu', data.target),
            const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
            _buildRow('Trạng thái', data.status, status: true),
            const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
          ],
          const SizedBox(height: 10),
          // Kết quả
          Padding(

            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Kết quả: ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
                SizedBox(
                  width: screenWidth*0.5,
                  child: TextField(
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
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        final allowedCharactersRegExp = RegExp(r'^[0-9.,]*$');
                        if (!allowedCharactersRegExp.hasMatch(newValue.text)) {
                          return oldValue;
                        }
                        return newValue;
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Nhập ngày
          Padding(
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
                      width: screenWidth*0.5,
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: data.date,
                          hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            onPressed: () => selectDate(context),
                          ),
                        ),
                        readOnly: true,
                      ),
                    ),
                  ],
                ),
                if (isExpanded)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Yêu cầu Xử lý và báo cáo kết quả',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: myColor, // Màu nền của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo góc nút
                    ),
                    minimumSize: Size(90, 50),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      SvgPicture.asset('assets/images/Icon Сolor.svg'),
                      const SizedBox(height: 4),
                      const Text(
                        'Xem chi tiết',
                        style: TextStyle(fontSize: 14, color: Colors.black), // Màu chữ
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: myColor, // Màu nền của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo góc nút
                    ),
                    minimumSize: Size(90, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                    );
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(Icons.feedback_outlined, color: Colors.orangeAccent, size: 20),
                      Text(
                        'Phản hồi',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ]
            )
          )
        ]
      )
    );
  }

  Widget _buildRow(String label, String value, {bool status = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
            status
              ? Text(value, style: TextStyle(color: _getStatusColor(value), fontSize: 14))
              : Text(value, style: const TextStyle(fontSize: 14))
          ]
        )
      )
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Hoàn thành':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
