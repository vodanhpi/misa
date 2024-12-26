import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_screen/data/chat_data.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final List<Chat> _chatMessages = getChat();
  final TextEditingController _textController = TextEditingController();
  bool isMenuVisible = false;
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() {
    if (_textController.text.trim().isNotEmpty) {
      setState(() {
        _chatMessages.add(Chat(
          userID: 2,
          message: _textController.text.trim(),
          warning: '',
          time: DateFormat('hh:mm a').format(DateTime.now()),
          date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
        ));
      });
      _textController.clear();
      _scrollToBottom();
    }
  }

  void _hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  // Step 2: Function to scroll to the bottom
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    String currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

    return GestureDetector(
      onTap: _hideKeyboard,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cảnh báo KPT_22024'),
          centerTitle: true,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(1.0),
              child: Container(color: Colors.grey[400], height: 1.0)),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _chatMessages.length,
                    itemBuilder: (context, index) {
                      final chat = _chatMessages[index];
                      bool isToday = chat.date == currentDate;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: chat.userID == 1
                                ? MainAxisAlignment.start
                                : MainAxisAlignment.end,
                            children: [
                              if (chat.userID == 1)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            'assets/images/lanhdao.jpg',
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Lãnh đạo',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                              padding: const EdgeInsets.all(8.0),
                                              decoration: BoxDecoration(
                                                color:
                                                Colors.blueAccent.withOpacity(0.1),
                                                borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(16.0),
                                                  bottomRight: Radius.circular(16.0),
                                                  topRight: Radius.circular(16.0),
                                                ),
                                              ),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (chat.warning.isNotEmpty)
                                                    Text(
                                                      chat.warning,
                                                      style: const TextStyle(
                                                        color: Colors.red,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  Text(
                                                    chat.message,
                                                    style: const TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${chat.time}${isToday ? '' : ' - ${chat.date}'}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black45),
                                    ),
                                  ],
                                ),
                              if (chat.userID != 1)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    if (chat.warning.isNotEmpty)
                                      Text(
                                        chat.warning,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    const SizedBox(height: 4),
                                    Container(
                                      constraints: BoxConstraints(maxWidth: screenWidth * 0.75),
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.blueAccent.withOpacity(0.1),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(16.0),
                                          bottomRight: Radius.circular(16.0),
                                          topLeft: Radius.circular(16.0),
                                        ),
                                      ),
                                      child: Text(chat.message,
                                        style: const TextStyle(fontSize: 16))
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${chat.time}${isToday ? '' : '- ${chat.date}'}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black45),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset('assets/images/ghim.svg'),
                            color: Colors.black,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isMenuVisible = !isMenuVisible;
                              });
                            },
                            icon: const Icon(Icons.error),
                            color: Colors.red,
                          ),
                        ],
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                            hintText: 'Nhập văn bản',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            contentPadding: const EdgeInsets.all(12.0),
                            suffixIcon: IconButton(
                              onPressed: _sendMessage,
                              icon: SvgPicture.asset('assets/images/send.svg'),
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (isMenuVisible)
              Positioned(
                bottom: 60,
                left: 80,
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: 300,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _chatMessages.add(Chat(
                                  userID: 2,
                                  message: 'Cập nhật trạng thái đang xử lý',
                                  warning: '',
                                  time: DateFormat('hh:mm a').format(DateTime.now()),
                                  date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                ));
                                isMenuVisible = false;
                              });
                              _scrollToBottom(); // Scroll after new message
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8.0),
                                  topLeft: Radius.circular(8.0),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text(
                              'Đang xử lý',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _chatMessages.add(Chat(
                                  userID: 2,
                                  message: 'Cập nhật trạng thái đã hoàn thành',
                                  warning: '',
                                  time: DateFormat('hh:mm a').format(DateTime.now()),
                                  date: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                                ));
                                isMenuVisible = false;
                              });
                              _scrollToBottom(); // Scroll after new message
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(8.0),
                                  bottomLeft: Radius.circular(8.0),
                                ),
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            child: const Text(
                              'Đã hoàn thành',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
