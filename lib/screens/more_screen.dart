import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/common.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      children: [
        const SectionTitle(emoji: '🚨', title: '緊急聯絡'),
        _card(const [
          _Pair('警察', '110'),
          _Pair('火警 / 救護', '119'),
          _Pair('駐福岡辦事處', '+81-92-734-2810'),
        ]),
        const SectionTitle(emoji: '🗣️', title: '實用日文'),
        _card(const [
          _Pair('你好', 'こんにちは'),
          _Pair('謝謝', 'ありがとうございます'),
          _Pair('不好意思', 'すみません'),
          _Pair('多少錢？', 'いくらですか？'),
          _Pair('買單', 'お会計お願いします'),
        ]),
        const SectionTitle(emoji: '🧾', title: '退稅資訊'),
        _card(const [
          _Pair('門檻', '單店滿 ¥5,000（未稅）'),
          _Pair('必備', '護照正本（當日）'),
          _Pair('注意', '消耗品會封袋，出境前請勿拆封'),
        ]),
        const SectionTitle(emoji: '🚇', title: '交通票券'),
        _card(const [
          _Pair('市區', '福岡地下鐵一日券 ¥640'),
          _Pair('近郊', 'JR 九州 Pass（北九州 3 日）'),
          _Pair('由布院', '由布院之森需指定席，建議先劃位'),
        ]),
        const SectionTitle(emoji: '🌤️', title: '天氣'),
        _card(const [
          _Pair('5 月福岡', '約 15～24°C，多雲偶雨'),
          _Pair('建議', '帶薄外套與折疊傘'),
          _Pair('查詢', 'tenki.jp / 日本氣象廳'),
        ]),
        const SectionTitle(emoji: 'ℹ️', title: '關於'),
        _card(const [
          _Pair('版本', 'v0.1.0（個人自用）'),
          _Pair('資料', '自行整理，出發前請再次確認'),
        ]),
      ],
    );
  }

  Widget _card(List<_Pair> pairs) {
    return AppCard(
      child: Column(
        children: pairs
            .map(
              (p) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 104,
                      child: Text(
                        p.label,
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.inkSoft,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        p.value,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          height: 1.45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class _Pair {
  final String label;
  final String value;
  const _Pair(this.label, this.value);
}
