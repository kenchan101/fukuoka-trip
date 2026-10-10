import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/trip_data.dart';
import '../widgets/common.dart';

class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  static const double _jpyToTwd = 0.22;

  @override
  Widget build(BuildContext context) {
    final int total = budgets.fold<int>(0, (sum, b) => sum + b.jpy);
    final int ntd = (total * _jpyToTwd).round();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        const SectionTitle(emoji: '💴', title: '記帳 / 預算'),
        AppCard(
          color: AppColors.cardAlt,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '預估總預算（1 人）',
                style: TextStyle(
                  fontSize: 12.5,
                  color: AppColors.inkSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _yen(total),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '約 NT\$ $_ntdFmt（匯率 ${_jpyToTwd}）',
                style: const TextStyle(
                  fontSize: 12.5,
                  color: AppColors.inkSoft,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...budgets.map(_budgetRow),
        const SizedBox(height: 6),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            '※ 以上為估算值，實際花費請於旅程中自行記錄。',
            style: TextStyle(fontSize: 11.5, color: AppColors.inkSoft),
          ),
        ),
      ],
    );
  }

  Widget _budgetRow(BudgetItem b) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 10,
              height: 34,
              decoration: BoxDecoration(
                color: b.color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    b.category,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    b.note,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              _yen(b.jpy),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _ntdFmt => _yen(budgets.fold<int>(0, (s, b) => s + b.jpy))
      .replaceFirst('¥', '')
      .isEmpty
      ? '0'
      : _comma((budgets.fold<int>(0, (s, b) => s + b.jpy) * _jpyToTwd).round());

  String _yen(int v) => '¥${_comma(v)}';

  String _comma(int v) {
    final String s = v.abs().toString();
    final StringBuffer buf = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buf.write(',');
      buf.write(s[i]);
    }
    return v < 0 ? '-$buf' : buf.toString();
  }
}
