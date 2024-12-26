import 'package:flutter/material.dart';
import 'package:my_screen/data/kpi_data.dart';
import '../widgets/approval_bottom_nav.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'approval_details_screen.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});
  @override
  ApprovalScreenState createState() => ApprovalScreenState();
}

class ApprovalScreenState extends State<ApprovalScreen> {
  List<Kpi> kpiData = getKpiData();
  bool isLoadingMore = false;
  int itemsToShow = 3;

  Future<void> _loadMoreItems() async {
    if (itemsToShow < kpiData.length && !isLoadingMore) {
      setState(() => isLoadingMore = true);
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        itemsToShow = (itemsToShow + 3 <= kpiData.length) ? itemsToShow + 3 : kpiData.length;
        isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoadingMore && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMoreItems();
          }
          return false;
        },
        child: Column(
          children: [
            _buildSearchBar(),
            _buildKpiList(),
            Container(color: Colors.grey[400], height: 1.0),
            // const ApprovalBottomNav(),
          ],
        ),
      ),
    );
  }

  void _navigateToKpiDetail(int index) async {
    final updatedTarget = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => KpiDetailScreen(index: index),
      ),
    );
    if (updatedTarget != null && updatedTarget != '') {
      setState(() {
        kpiData[index].target = updatedTarget;
      });
    }
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: const Text(
        'Danh sách chỉ tiêu',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      actions: [_buildApproveButton()],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(color: Colors.grey[400], height: 1.0),
      ),
    );
  }

  Widget _buildApproveButton() {
    return Padding(
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
              offset: const Offset(-1, 3),
            ),
          ],
        ),
        child: TextButton(
          onPressed: () {},
          child: const Text(
            'Duyệt',
            style: TextStyle(fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
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
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.italic,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          IconButton(
            icon: SvgPicture.asset('assets/images/Filter 2.svg',height: 30,width: 30),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildKpiList() {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            itemsToShow = kpiData.length < 3 ? kpiData.length : 3;
          });
          FocusScope.of(context).unfocus();
        },
        child: ListView.builder(
          itemCount: (itemsToShow > kpiData.length ? kpiData.length : itemsToShow) + 1,
          itemBuilder: (context, index) {
            if (index == itemsToShow || index == kpiData.length) {
              return isLoadingMore
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox();
            }
            return GestureDetector(
              onTap: () {
                _navigateToKpiDetail(index);
              },
              child: _buildKpiCard(index),
            );
          },
        ),
      ),
    );
  }

  Widget _buildKpiCard(int index) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildKpiHeader(index),
          _buildDottedLine(),
          _buildKpiDetails(index),
          _buildDottedLine(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildKpiHeader(int index) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 4.0),
      child: Row(
        children: [
          const Icon(Icons.error_rounded, color: Colors.red),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              kpiData[index].title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDottedLine() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.center,
        child: DottedLine(
          direction: Axis.horizontal,
          lineLength: double.infinity,
          lineThickness: 1.0,
          dashLength: 5.0,
          dashColor: Colors.grey,
          dashGapLength: 3.0,
        ),
      ),
    );
  }

  Widget _buildKpiDetails(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          _buildDetailRow('Đơn vị : ', 'VND'),
          _buildDetailRow('Tần suất : ', kpiData[index].frequency),
          _buildDetailRow('Trọng số : ', kpiData[index].percent),
          _buildDetailRow('Chỉ tiêu : ', kpiData[index].target),
          _buildDetailRow('Kết quả : ', kpiData[index].result),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton('Xóa', 'assets/images/Group.svg', Icons.delete),
          _buildActionButton('Giao việc', 'assets/images/Vector.svg', Icons.assignment),
          _buildActionButton('Nhập chỉ tiêu', 'assets/images/Group 59.svg', Icons.input),
          _buildActionButton('Phê duyệt', null, Icons.check_circle_outline, iconColor: Colors.green),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, String? assetPath, IconData fallbackIcon, {Color iconColor = Colors.black}) {
    double screenWidth = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: myColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        minimumSize: Size(screenWidth*0.15, 50),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            assetPath != null
                ? SvgPicture.asset(assetPath)
                : Icon(fallbackIcon, color: iconColor, size: 20),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}