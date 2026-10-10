import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/trip_data.dart';
import '../widgets/common.dart';
import '../widgets/cartoon_icon.dart';

class StayScreen extends StatelessWidget {
  const StayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        const SectionTitle(emoji: '🏨', title: '住宿資訊'),
        ...stays.map(_stayCard),
      ],
    );
  }

  Widget _stayCard(StayInfo s) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: AppCard(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CartoonIcon(category: s.cartoon, color: s.color, size: 56),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TagChip(
                        label: s.status,
                        color: s.color,
                        filled: s.status == '已訂',
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    s.dates,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: AppColors.inkSoft,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...s.notes.map(
                    (n) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '・',
                            style: TextStyle(color: AppColors.inkSoft),
                          ),
                          Expanded(
                            child: Text(
                              n,
                              style: const TextStyle(
                                fontSize: 12.5,
                                color: AppColors.inkSoft,
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
