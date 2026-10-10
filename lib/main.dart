import 'package:flutter/material.dart';
import 'theme.dart';
import 'screens/itinerary_screen.dart';
import 'screens/stay_screen.dart';
import 'screens/todo_screen.dart';
import 'screens/budget_screen.dart';
import 'screens/more_screen.dart';

void main() => runApp(const FukuokaApp());

class FukuokaApp extends StatelessWidget {
  const FukuokaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '福岡之旅',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      home: const HomeShell(),
    );
  }
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;

  static const List<String> _tabs = ['行程', '住宿', '待辦', '記帳', '更多'];

  static const List<Widget> _pages = [
    ItineraryScreen(),
    StayScreen(),
    TodoScreen(),
    BudgetScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(),
            Expanded(
              child: IndexedStack(index: _index, children: _pages),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 6),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.card,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.line),
            ),
            child: const Text('⛩️', style: TextStyle(fontSize: 19)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_tabs.length, _pill),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _pill(int i) {
    final bool selected = i == _index;
    return GestureDetector(
      onTap: () => setState(() => _index = i),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? AppColors.coral : AppColors.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColors.coral : AppColors.line,
          ),
        ),
        child: Text(
          _tabs[i],
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: selected ? Colors.white : AppColors.inkSoft,
          ),
        ),
      ),
    );
  }
}
