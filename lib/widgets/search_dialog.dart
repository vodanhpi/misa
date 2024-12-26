import 'package:flutter/material.dart';
import 'package:my_screen/data/kpt_data.dart';

void showSearchDialog(BuildContext context, List<Kpt> kptData, Function(List<Kpt>) onSearchComplete) {
  String inputText = '';
  String? selectedStatus;
  String? selectedFrequency;
  String dateRange = '';

  TextEditingController statusController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController dateRangeController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Tiêu đề
                      const Center(
                        child: Text(
                          'Tìm kiếm nâng cao',
                          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 40),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Ô nhập liệu
                      TextField(
                        controller: TextEditingController(text: inputText),
                        decoration: const InputDecoration(
                          hintText: 'Nhập chỉ số',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          inputText = value;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      // Trạng thái
                      TextField(
                        controller: statusController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Trạng thái',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () async {
                              String? selected = await showDialog<String>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Chọn trạng thái'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('Đang xử lý'),
                                          onTap: () => Navigator.of(context).pop('Đang xử lý'),
                                        ),
                                        ListTile(
                                          title: const Text('Hoàn thành'),
                                          onTap: () => Navigator.of(context).pop('Hoàn thành'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (selected != null) {
                                statusController.text = selected;
                                selectedStatus = selected;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Tần suất
                      TextField(
                        controller: frequencyController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Tần suất',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.expand_more),
                            onPressed: () async {
                              String? selected = await showDialog<String>(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Chọn tần suất'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListTile(
                                          title: const Text('Hàng năm'),
                                          onTap: () => Navigator.of(context).pop('Hàng năm'),
                                        ),
                                        ListTile(
                                          title: const Text('Hàng tháng'),
                                          onTap: () => Navigator.of(context).pop('Hàng tháng'),
                                        ),
                                        ListTile(
                                          title: const Text('Hàng ngày'),
                                          onTap: () => Navigator.of(context).pop('Hàng ngày'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (selected != null) {
                                frequencyController.text = selected;
                                selectedFrequency = selected;
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      // Ngày bắt đầu - Ngày kết thúc
                      TextField(
                        controller: dateRangeController,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Ngày bắt đầu - Ngày kết thúc',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            onPressed: () async {
                              // Hiển thị lựa chọn ngày bắt đầu và ngày kết thúc
                              DateTime? startDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              );
                              if (startDate != null) {
                                DateTime? endDate = await showDatePicker(
                                  context: context,
                                  initialDate: startDate,
                                  firstDate: startDate,
                                  lastDate: DateTime(2101),
                                );
                                if (endDate != null) {
                                  dateRangeController.text =
                                  '${startDate.day.toString().padLeft(2, '0')}'
                                    '/${startDate.month.toString().padLeft(2, '0')}'
                                    '/${startDate.year} '
                                    '- '
                                    '${endDate.day.toString().padLeft(2, '0')}'
                                    '/${endDate.month.toString().padLeft(2, '0')}'
                                    '/${endDate.year}';
                                  dateRange = dateRangeController.text;
                                }
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                ),
                // Nút "Xong"
                TextButton(
                  onPressed: () {
                    // Lọc dữ liệu
                    List<Kpt> filteredKpts = kptData.where((kpt) {
                      bool matchesTitle = inputText == '' || kpt.title.contains(inputText);
                      bool matchesStatus = selectedStatus == null || kpt.status == selectedStatus;
                      bool matchesFrequency = selectedFrequency == null || kpt.frequency == selectedFrequency;
                      bool matchesTime = dateRange == '' || kpt.time.contains(dateRange);
                      return matchesTitle && matchesStatus && matchesFrequency && matchesTime;
                    }).toList();
                    // Trả lại kết quả tìm kiếm
                    onSearchComplete(filteredKpts);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Xong'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}