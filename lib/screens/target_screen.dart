import 'package:flutter/material.dart';
import 'package:my_screen/widgets/kpt_card_main.dart';
import 'package:my_screen/data/kpt_data.dart';
import 'package:my_screen/widgets/search_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TargetScreen extends StatefulWidget {
  const TargetScreen({super.key});

  @override
  MyScreenState createState() => MyScreenState();
}

class MyScreenState extends State<TargetScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  List<Kpt> kptData = getKptData(); // Dữ liệu gốc
  List<Kpt> filterData = [];
  List<bool> isExpanded = [];
  int itemsToShow = 3;
  bool isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    filterData = kptData;
    isExpanded = List<bool>.filled(filterData.length, true);
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      setState(() {
        dateController.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
      });
    }
  }

  void updateFilteredKpts(List<Kpt> newData) {
    setState(() {
      filterData = newData;
      itemsToShow = 3;
      isExpanded = List<bool>.filled(filterData.length, true);
    });
  }

  Future<void> _loadMoreItems() async {
    if (itemsToShow < filterData.length && !isLoadingMore) {
      setState(() {
        isLoadingMore = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        itemsToShow = (itemsToShow + 3 <= filterData.length) ? itemsToShow + 3 : filterData.length;
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Danh sách chỉ tiêu',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8.0),
            child: Container(
              width: 70,
              height: 35,
              decoration: BoxDecoration(
                color: myColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(-1, 3)
                  )
                ]
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text('Lưu',
                    style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold))
              )
            )
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey[400],
            height: 1.0
          )
        )
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      hintText: 'Tìm kiếm',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(color: Colors.grey)
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 10.0)
                    )
                  )
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: SvgPicture.asset('assets/images/Filter 2.svg',height: 30,width: 30),
                  onPressed: () => showSearchDialog(context, kptData, updateFilteredKpts)
                )
              ]
            )
          ),
          // Kpt List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  filterData = kptData;
                  itemsToShow = filterData.length < 3 ? filterData.length : 3;
                  isExpanded = List<bool>.filled(filterData.length, true);
                });
                FocusScope.of(context).unfocus();
              },
              child: filterData.isEmpty
                  ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        'Không tìm thấy kết quả',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )
                  : NotificationListener<ScrollNotification>(
                onNotification: (scrollInfo) {
                  if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !isLoadingMore) {
                    _loadMoreItems();
                  }
                  return false;
                },
                child: ListView.builder(
                  itemCount: (itemsToShow > filterData.length
                      ? filterData.length
                      : itemsToShow) + 1,
                  itemBuilder: (context, index) {
                    if (index == itemsToShow || index == filterData.length) {
                      return isLoadingMore
                        ? const Center(child: CircularProgressIndicator())
                        : const SizedBox();
                    }
                    return KptCard(
                      data: filterData[index],
                      isExpanded: isExpanded[index],
                      onExpandedChanged: () {
                        setState(() {
                          isExpanded[index] = !isExpanded[index];
                        });
                      },
                      // resultController: resultController,
                      dateController: dateController,
                      selectDate: _selectDate,
                    );
                  },
                ),
              ),
            ),
          ),
          Container(
            color: Colors.grey[400],
            height: 1.0,
          ),
        ]
      ),
    );
  }
}
