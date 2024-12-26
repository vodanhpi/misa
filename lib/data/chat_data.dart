import 'package:intl/intl.dart';

class Chat {
  final int userID;
  final String message;
  final String warning;
  final String time;
  final String date;

  Chat({
    required this.userID,
    required this.message,
    required this.warning,
    required this.time,
    required this.date,
  });

  factory Chat.fromMap(Map<String, dynamic> map) {
    String time = map['time'] ?? '';
    if (time.isNotEmpty) {
      DateTime dateTime = DateTime.parse(time);
      time = DateFormat('hh:mm a').format(dateTime);
    }

    String date = map['date'] ?? '';
    if (date.isNotEmpty) {
      try {
        DateTime dateTime = DateFormat('dd/MM/yyyy').parse(date);
        date = DateFormat('dd/MM/yyyy').format(dateTime);
      } catch (e) {
        date = map['date'] ?? '';
      }
    }

    return Chat(
      userID: int.parse(map['userID'].toString()),
      message: map['message'] ?? '',
      warning: map['warning'] ?? '',
      time: time,
      date: date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'message': message,
      'warning': warning,
      'time': time,
      'date': date,
    };
  }
}

List<Chat> getChat() {
  return [
    Chat(
      userID: 1,
      message: 'Cập nhật đạt chỉ tiêu 100.000 VDN',
      warning: '',
      time: '09:25 AM',
      date: '20/10/2023',
    ),
    Chat(
      userID: 1,
      message: 'Xử lý ngay lập tức',
      warning: 'Gửi chỉ đạo mức độ chỉ đạo 1',
      time: '11:14 AM',
      date: '21/10/2023',
    ),
    Chat(
      userID: 2,
      message: 'Cập nhật kết quả 40.000 VDN',
      warning: '',
      time: '09:25 AM',
      date: '',
    ),
    Chat(
      userID: 2,
      message: 'Cập nhật trạng thái đang xử lý',
      warning: '',
      time: '09:30 AM',
      date: '',
    ),
  ];
}
