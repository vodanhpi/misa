import 'package:flutter/material.dart';
import 'package:my_screen/screens/approval_screen.dart';
import 'screens/target_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  MyScreenState createState() => MyScreenState();
}

class MyScreenState extends State<MyScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const TargetScreen(),
    const Center(child: Text('Thông báo Screen')),
    const Center(child: Text('Tài Khoản Screen')),
    const ApprovalScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ApprovalScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedItemColor: const Color(0xFF289767),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0 ? const Color(0xFF289767) : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset('assets/images/ic-marketing.svg'),
              ),
              label: 'Chỉ tiêu',
            ),
            BottomNavigationBarItem(
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.notifications_active_outlined,
                    size: 25,
                    color: _selectedIndex == 1 ? const Color(0xFF289767) : Colors.grey,
                  ),
                  Positioned(
                    right: -3,
                    top: -5,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 15,
                        minHeight: 15,
                      ),
                      child: const Text(
                        '5',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              label: 'Thông báo',
            ),
            BottomNavigationBarItem(
              icon: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2 ? const Color(0xFF289767) : Colors.grey,
                  BlendMode.srcIn,
                ),
                child: SvgPicture.asset('assets/images/human.svg'),
              ),
              label: 'Tài Khoản',
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.note_alt_outlined,
                size: 25,
                color: Colors.grey,
              ),
              label: 'Phê Duyệt',
            ),
          ],
        )
    );
  }
}
