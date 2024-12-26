import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../data/kpi_data.dart';

class KpiDetailScreen extends StatefulWidget {
  final List<Kpi> kpiData = getKpiData();
  final int index;

  KpiDetailScreen({super.key, required this.index});

  @override
  _KpiDetailScreenState createState() => _KpiDetailScreenState();
}

class _KpiDetailScreenState extends State<KpiDetailScreen> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;
  bool isChecked5 = false;
  final TextEditingController _targetController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Chỉ tiêu KPI_22024 - Doanh thu'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 2.0),
        ),
      ),
      body: GestureDetector(
        onTap: (){FocusScope.of(context).unfocus();},
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.zero,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildKpiDetails(widget.index),
                  const Text('Chỉ tiêu', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: screenWidth * 0.6,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _targetController,
                        decoration: InputDecoration(
                          hintText: 'Nhập chỉ tiêu',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
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
                  ),
                  const Text('Cách đánh giá', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  _buildComparisonRow(isChecked1, 'So sánh với chỉ tiêu : 50/100 VND', (value) {
                    setState(() => isChecked1 = value);
                  }),
                  _buildComparisonRow(isChecked2, 'So sánh với kỳ trước : 50/100 VND', (value) {
                    setState(() => isChecked2 = value);
                  }),
                  _buildComparisonRow(isChecked3, 'So sánh với cùng kỳ trước : 50/100 VND', (value) {
                    setState(() => isChecked3 = value);
                  }),
                  _buildComparisonRow(isChecked4, 'So sánh với tổng mục tiêu : 20/100 VND', (value) {
                    setState(() => isChecked4 = value);
                  }),
                  _buildComparisonRow(isChecked5, 'So sánh với lũy kế : 20/100 VND', (value) {
                    setState(() => isChecked5 = value);
                  }),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),

                            ),
                            minimumSize: Size(screenWidth*0.3, 50),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Hủy',
                            style: TextStyle(fontSize: 18, color: Colors.green,fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            minimumSize: Size(screenWidth*0.3, 50),
                          ),
                          onPressed: () {
                            Navigator.pop(context, _targetController.text);
                          },
                          child: const Text(
                            'Xác nhận',
                            style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildKpiDetails(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Tổng chỉ tiêu:', widget.kpiData[index].target),
        _buildDetailRow('Thời gian:', widget.kpiData[index].time),
        _buildDetailRow('Tần suất:', widget.kpiData[index].frequency),
        _buildDetailRow('Phát sinh:', widget.kpiData[index].phatSinh),
        _buildDetailRow('Mô Tả:', widget.kpiData[index].moTa),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$label\t\t',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildComparisonRow(bool isChecked, String text, Function(bool) onChanged) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              onChanged(!isChecked);
            });
          },
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: isChecked ? Colors.green : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(color: Colors.grey),
            ),
            minimumSize: const Size(20, 20),
          ),
          child: isChecked
              ? const Icon(
            Icons.check,
            size: 20,
            color: Colors.white,
          )
              : null,
        ),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
