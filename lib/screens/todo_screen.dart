import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/trip_data.dart';
import '../widgets/common.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final Set<int> _done = <int>{};

  @override
  Widget build(BuildContext context) {
    final int total = todos.length;
    final int doneCount = _done.length;

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        const SectionTitle(emoji: '✅', title: '待辦清單'),
        AppCard(
          color: AppColors.cardAlt,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '已完成 $doneCount / $total',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: total == 0 ? 0 : doneCount / total,
                  minHeight: 9,
                  backgroundColor: Colors.white,
                  color: AppColors.green,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ...List.generate(todos.length, _row),
      ],
    );
  }

  Widget _row(int i) {
    final TodoInfo t = todos[i];
    final bool done = _done.contains(i);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: () => setState(() {
          if (done) {
            _done.remove(i);
          } else {
            _done.add(i);
          }
        }),
        child: AppCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 23,
                height: 23,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: done ? AppColors.green : Colors.transparent,
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(
                    color: done ? AppColors.green : AppColors.line,
                    width: 1.6,
                  ),
                ),
                child: done
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.text,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        decoration:
                            done ? TextDecoration.lineThrough : null,
                        color: done ? AppColors.inkSoft : AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${t.date} · ${t.note}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.inkSoft,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
