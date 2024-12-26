import 'package:flutter/material.dart';

class Kpi {
  final String title;
  final String time;
  final String frequency;
  String target;
  final String status;
  final String result;
  final String date;
  final String percent;
  final String phatSinh;
  final String moTa;

  Kpi({
    required this.title,
    required this.time,
    required this.frequency,
    required this.target,
    required this.status,
    required this.result,
    required this.date,
    required this.percent,
    this.phatSinh = 'Theo yêu cầu',
    this.moTa = 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
  });

  // Factory constructor để khởi tạo đối tượng từ Map
  factory Kpi.fromMap(Map<String, String> map) {
    return Kpi(
      title: map['title']!,
      time: map['time']!,
      frequency: map['frequency']!,
      target: map['target']!,
      status: map['status']!,
      result: map['result']!,
      date: map['date']!,
      percent: map['percent']!,
      phatSinh: map['phatSinh']!,
      moTa: map['moTa'] !,
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
      'percent': percent,
      'phatSinh': phatSinh,
      'moTa': moTa,
    };
  }
}

List<Kpi> getKpiData() {
  return [
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '20/10/2023 - 20/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '30.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '90.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Hoàn thành',
      result: '10.000 VND',
      date: '20/02/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '80.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '30/10/2023 - 30/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '50.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Hoàn thành',
      result: '80.000 VND',
      date: '20/02/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '80.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
    Kpi(
      title: 'KPI.230101 - Doanh thu hàng tháng',
      time: '10/10/2023 - 10/11/2023',
      frequency: 'Hàng tháng',
      target: '100.000 VDN',
      status: 'Đang xử lý',
      result: '80.000 VND',
      date: '09/12/2024',
      percent: '50%',
      phatSinh: 'Theo yêu cầu',
      moTa: 'Tổng doanh thu từ các sản phẩm và dịch vụ trong tháng.',
    ),
  ];
}

const Color myColor = Color.fromARGB(255, 233, 245, 240);
const Color grey = Colors.grey;
const Color white = Colors.white;
const Color black = Colors.black;
