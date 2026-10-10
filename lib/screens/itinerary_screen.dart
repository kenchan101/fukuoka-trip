import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/trip_data.dart';
import '../widgets/common.dart';
import '../widgets/cartoon_icon.dart';
import '../widgets/hero_card.dart';

class ItineraryScreen extends StatefulWidget {
  const ItineraryScreen({super.key});

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  int _day = 0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        const HeroCard(),
        const SectionTitle(emoji: '✈️', title: '航班'),
        ...flights.map(_flightCard),
        const SectionTitle(emoji: '🗓️', title: '每日行程'),
        _dayTabs(),
        _dayDetail(days[_day]),
        const SectionTitle(emoji: '📖', title: '五日一覽'),
        ...overviews.map(_overviewRow),
      ],
    );
  }

  Widget _flightCard(FlightInfo f) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(
          children: [
            CartoonIcon(category: '航班', color: f.color, size: 46),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    f.route,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${f.type} · ${f.date} · ${f.note}',
                    style: const TextStyle(
                      color: AppColors.inkSoft,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            StampLabel(text: f.status, color: f.color),
          ],
        ),
      ),
    );
  }

  Widget _dayTabs() {
    final now = DateTime.now();
    return SizedBox(
      height: 68,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        itemBuilder: (context, i) {
          final TripDay d = days[i];
          final bool selected = i == _day;
          final bool isToday = d.date.year == now.year &&
              d.date.month == now.month &&
              d.date.day == now.day;
          return GestureDetector(
            onTap: () => setState(() => _day = i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 58,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.coral : AppColors.card,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: selected ? AppColors.coral : AppColors.line,
                  width: 1.2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${d.date.month}/${d.date.day}',
                    style: TextStyle(
                      fontSize: 12,
                      color: selected ? Colors.white70 : AppColors.inkSoft,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _weekday(d.date),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: selected ? Colors.white : AppColors.ink,
                    ),
                  ),
                  if (isToday)
                    Container(
                      width: 5,
                      height: 5,
                      margin: const EdgeInsets.only(top: 3),
                      decoration: const BoxDecoration(
                        color: AppColors.sun,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _dayDetail(TripDay d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardAlt,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.line),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DAY ${d.day} · ${d.date.month}/${d.date.day} (${_weekday(d.date)})',
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.inkSoft,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                d.theme,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                d.subtitle,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.inkSoft,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [TagChip(label: d.status, color: AppColors.green)],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        ...d.items.asMap().entries.map(
              (e) => _timelineRow(e.value, e.key == d.items.length - 1),
            ),
      ],
    );
  }

  Widget _timelineRow(ItineraryItem it, bool last) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 44,
            child: Padding(
              padding: const EdgeInsets.only(top: 14),
              child: Text(
                it.time,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.inkSoft,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 52,
            child: Column(
              children: [
                const SizedBox(height: 2),
                CartoonIcon(category: it.category, color: it.color, size: 44),
                if (!last)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.line,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12, top: 2),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        TagChip(
                          label: it.category,
                          color: it.color,
                          filled: true,
                        ),
                        ...it.tags.map(
                          (t) => TagChip(label: t, color: it.color),
                        ),
                      ],
                    ),
                    const SizedBox(height: 9),
                    Text(
                      it.title,
                      style: const TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      it.note,
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: AppColors.inkSoft,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _overviewRow(DayOverview o) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.cardAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.line),
              ),
              child: Column(
                children: [
                  Text(
                    'DAY ${o.day}',
                    style: const TextStyle(
                      fontSize: 9.5,
                      color: AppColors.inkSoft,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    o.date,
                    style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    o.place,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    o.text,
                    style: const TextStyle(
                      fontSize: 12.5,
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
    );
  }

  String _weekday(DateTime d) =>
      const ['一', '二', '三', '四', '五', '六', '日'][d.weekday - 1];
}
