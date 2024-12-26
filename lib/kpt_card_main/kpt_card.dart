import 'package:flutter/material.dart';
import '../data/kpt_data.dart';
import '../screens/feedback_screen.dart';
import 'kpt_card_header.dart';
import 'kpt_result_input.dart';
import 'kpt_date_input.dart';
import 'kpt_buttons.dart';

class KptCard extends StatelessWidget {
  final Kpt data;
  final bool isExpanded;
  final VoidCallback onExpandedChanged;
  final TextEditingController resultController;
  final TextEditingController dateController;
  final Function(BuildContext) selectDate;

  const KptCard({
    super.key,
    required this.data,
    required this.isExpanded,
    required this.onExpandedChanged,
    required this.resultController,
    required this.dateController,
    required this.selectDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KptCardHeader(
            title: data.title,
            isExpanded: isExpanded,
            onExpandedChanged: onExpandedChanged,
          ),
          const Divider(color: Colors.grey, thickness: 1.0),
          if (!isExpanded)
            ...[
              _buildRow('Thời gian', data.time),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
              _buildRow('Tần suất', data.frequency),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
              _buildRow('Chỉ tiêu', data.target),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
              _buildRow('Trạng thái', data.status, status: true),
              const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
            ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                KptResultInput(controller: resultController),
                const SizedBox(height: 10),
                KptDateInput(
                  hintText: data.date,
                  controller: dateController,
                  onDateSelect: () => selectDate(context),
                ),
                const SizedBox(height: 16),
                KptButtons(
                  onFeedback: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FeedbackScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool status = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: status
                  ? Text(
                value,
                style: TextStyle(color: _getStatusColor(value), fontSize: 14),
              )
                  : FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerRight,
                child: Text(
                  value,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
        ],
      ),
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




























// import 'package:flutter/material.dart';
// import '../data/Kpt_data.dart';
// import '../screens/feedback_screen.dart';
// import 'Kpt_card_header.dart';
// import 'Kpt_result_input.dart';
// import 'Kpt_date_input.dart';
// import 'Kpt_buttons.dart';
//
// class KptCard extends StatelessWidget {
//   final Kpt data;
//   final bool isExpanded;
//   final VoidCallback onExpandedChanged;
//   final TextEditingController resultController;
//   final TextEditingController dateController;
//   final Function(BuildContext) selectDate;
//
//   const KptCard({
//     super.key,
//     required this.data,
//     required this.isExpanded,
//     required this.onExpandedChanged,
//     required this.resultController,
//     required this.dateController,
//     required this.selectDate,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           KptCardHeader(
//             title: data.title,
//             isExpanded: isExpanded,
//             onExpandedChanged: onExpandedChanged,
//           ),
//           const Divider(color: Colors.grey, thickness: 1.0),
//           if (!isExpanded) ...[
//             _buildRow('Thời gian', data.time),
//             const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
//             _buildRow('Tần suất', data.frequency),
//             const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
//             _buildRow('Chỉ tiêu', data.target),
//             const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
//             _buildRow('Trạng thái', data.status, status: true),
//             const Divider(color: Colors.grey, thickness: 0.5, indent: 16.0, endIndent: 16.0),
//           ],
//           const SizedBox(height: 10),
//           KptResultInput(controller: resultController),
//           const SizedBox(height: 10),
//           KptDateInput(
//             hintText: data.date,
//             controller: dateController,
//             onDateSelect: () => selectDate(context),
//           ),
//           const SizedBox(height: 16),
//           KptButtons(
//             onFeedback: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => const FeedbackScreen()),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value, {bool status = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4.0),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16.0, right: 16.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
//             status
//               ? Text(value, style: TextStyle(color: _getStatusColor(value), fontSize: 14))
//               : Text(value, style: const TextStyle(fontSize: 14)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Color _getStatusColor(String status) {
//     switch (status) {
//       case 'Hoàn thành':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }
// }
