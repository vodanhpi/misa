import 'package:flutter/material.dart';

class Kpt {
  final String title;
  final String time;
  final String frequency;
  final String target;
  final String status;
  final String result;
  final String date;

  Kpt({
    required this.title,
    required this.time,
    required this.frequency,
    required this.target,
    required this.status,
    required this.result,
    required this.date,
  });

  // Factory constructor để khởi tạo đối tượng từ Map
  factory Kpt.fromMap(Map<String, String> map) {
    return Kpt(
      title: map['title']!,
      time: map['time']!,
      frequency: map['frequency']!,
      target: map['target']!,
      status: map['status']!,
      result: map['result']!,
      date: map['date']!,
    );
  }
  Map<String, String> toMap() {
    return {
      'title': title,
      'time': time,
      'frequency': frequency,
      'target': target,
      'status': status,
      'result': result,
      'date': date,
    };
  }
}

List<Kpt> getKptData() {
  return [
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Hoàn thành',
      result: '100.000 VND',
      date: '20/02/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Hoàn thành',
      result: '100.000 VND',
      date: '20/02/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
    Kpt(
      title: 'KPT_22024 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '100.000 VND',
      date: '09/12/2024',
    ),
  ];
}

const Color myColor = Color.fromARGB(255, 233, 245, 240);
const Color grey = Colors.grey;
const Color white = Colors.white;
const Color black = Colors.black;
