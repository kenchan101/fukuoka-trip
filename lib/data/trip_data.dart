import 'package:flutter/material.dart';
import '../theme.dart';

/// ===== 旅程基本資料 =====
class TripInfo {
  final String title;
  final String route;
  final DateTime start;
  final DateTime end;
  const TripInfo({
    required this.title,
    required this.route,
    required this.start,
    required this.end,
  });
}

final TripInfo tripInfo = TripInfo(
  title: '福岡・由布院 5日4夜',
  route: '福岡 → 由布院',
  start: DateTime(2027, 5, 10),
  end: DateTime(2027, 5, 14),
);

/// ===== 航班 =====
class FlightInfo {
  final String type;
  final String route;
  final String date;
  final String status;
  final String note;
  final Color color;
  const FlightInfo({
    required this.type,
    required this.route,
    required this.date,
    required this.status,
    required this.note,
    required this.color,
  });
}

final List<FlightInfo> flights = const [
  FlightInfo(
    type: '去程',
    route: '香港 → 福岡',
    date: '5/10 (一)',
    status: '待訂',
    note: '航班待確定 · 早機優先',
    color: AppColors.blue,
  ),
  FlightInfo(
    type: '回程',
    route: '福岡 → 香港',
    date: '5/14 (五)',
    status: '待訂',
    note: '航班待確定 · 傍晚回程',
    color: AppColors.coral,
  ),
];

/// ===== 每日行程 =====
class ItineraryItem {
  final String time;
  final String category;
  final Color color;
  final List<String> tags;
  final String title;
  final String note;
  const ItineraryItem({
    required this.time,
    required this.category,
    required this.color,
    this.tags = const [],
    required this.title,
    required this.note,
  });
}

class TripDay {
  final int day;
  final DateTime date;
  final String theme;
  final String subtitle;
  final String status;
  final List<ItineraryItem> items;
  TripDay({
    required this.day,
    required this.date,
    required this.theme,
    required this.subtitle,
    required this.status,
    required this.items,
  });
}

final List<TripDay> days = [
  TripDay(
    day: 1,
    date: DateTime(2027, 5, 10),
    theme: '抵達福岡 · 博多',
    subtitle: '香港 → 福岡 · 市區散步',
    status: '行程規劃中',
    items: const [
      ItineraryItem(
        time: '08:00',
        category: '航班',
        color: AppColors.blue,
        tags: ['香港出發'],
        title: '香港國際機場 → 福岡機場',
        note: '建議提早 3 小時到機場；抵達後乘地下鐵空港線到博多站。',
      ),
      ItineraryItem(
        time: '14:00',
        category: '住宿',
        color: AppColors.green,
        tags: ['Check-in'],
        title: '博多站築紫口 F 飯店',
        note: '先放低行李，稍作休息再出市區。',
      ),
      ItineraryItem(
        time: '19:00',
        category: '美食',
        color: AppColors.coral,
        tags: ['必去'],
        title: '中洲屋台',
        note: '拉麵、串燒、關東煮；大部分只收現金，記得帶現金。',
      ),
    ],
  ),
  TripDay(
    day: 2,
    date: DateTime(2027, 5, 11),
    theme: '博多市區一日遊',
    subtitle: '神社 · 公園 · 城跡 · 地下街',
    status: '行程規劃中',
    items: const [
      ItineraryItem(
        time: '09:30',
        category: '景點',
        color: AppColors.green,
        tags: ['神社'],
        title: '櫛田神社',
        note: '博多總鎮守，順路可逛旁邊的博多町家文化館。',
      ),
      ItineraryItem(
        time: '12:00',
        category: '美食',
        color: AppColors.coral,
        tags: ['午餐'],
        title: '博多拉麵（一幸舍 / 元祖）',
        note: '豚骨拉麵，建議避開正午高峰。',
      ),
      ItineraryItem(
        time: '14:00',
        category: '景點',
        color: AppColors.green,
        tags: ['散步'],
        title: '大濠公園 · 福岡城跡',
        note: '繞湖一圈約 2 公里，5 月綠意正好。',
      ),
      ItineraryItem(
        time: '17:00',
        category: '購物',
        color: AppColors.yellow,
        tags: ['地下街'],
        title: '天神地下街',
        note: '地下街直通地鐵天神站，落雨都唔怕。',
      ),
    ],
  ),
  TripDay(
    day: 3,
    date: DateTime(2027, 5, 12),
    theme: '由布院之森 → 湯布院山莊吾亦紅',
    subtitle: '一泊二食 · 溫泉旅館',
    status: '已訂 · 待交通劃位',
    items: const [
      ItineraryItem(
        time: '09:17',
        category: '特急',
        color: Color(0xFFB08968),
        tags: ['JR', '指定席'],
        title: '特急「由布院之森」1號 博多 → 由布院',
        note: '車程約 2 小時 15 分；全車指定席，需提前劃位。',
      ),
      ItineraryItem(
        time: '11:35',
        category: '景點',
        color: AppColors.green,
        tags: ['湯の坪街道'],
        title: '湯之坪街道散策',
        note: '小店多數只收現金，邊行邊食可樂餅、可麗餅。',
      ),
      ItineraryItem(
        time: '15:00',
        category: '溫泉旅館',
        color: AppColors.coral,
        tags: ['免費接送'],
        title: '湯布院山莊吾亦紅 · 入住',
        note: '15:00 入住；可預約車站接送（抵達前先確認）。',
      ),
      ItineraryItem(
        time: '18:00',
        category: '美食',
        color: AppColors.coral,
        tags: ['必去', '一泊二食'],
        title: '旅館晚餐（會席料理）',
        note: '主菜務必留肚；晚餐後浸溫泉。',
      ),
    ],
  ),
  TripDay(
    day: 4,
    date: DateTime(2027, 5, 13),
    theme: '由布院 → 博多',
    subtitle: '金鱗湖晨景 · 返回博多',
    status: '行程規劃中',
    items: const [
      ItineraryItem(
        time: '07:00',
        category: '景點',
        color: AppColors.green,
        tags: ['晨景'],
        title: '金鱗湖',
        note: '清晨常有晨霧，係影相最佳時間。',
      ),
      ItineraryItem(
        time: '10:30',
        category: '特急',
        color: Color(0xFFB08968),
        tags: ['JR', '指定席'],
        title: '由布院 → 博多',
        note: '回程同樣需指定席，建議先劃位。',
      ),
      ItineraryItem(
        time: '16:00',
        category: '購物',
        color: AppColors.yellow,
        tags: ['伴手禮'],
        title: '博多運河城 / 博多站地下街',
        note: '買明太子、博多通饅頭等手信。',
      ),
    ],
  ),
  TripDay(
    day: 5,
    date: DateTime(2027, 5, 14),
    theme: '福岡 → 香港',
    subtitle: '收尾 · 回程',
    status: '行程規劃中',
    items: const [
      ItineraryItem(
        time: '09:00',
        category: '購物',
        color: AppColors.yellow,
        tags: ['最後衝刺'],
        title: '博多站最後補貨',
        note: '機場也有手信店，但市區選擇較多。',
      ),
      ItineraryItem(
        time: '12:00',
        category: '航班',
        color: AppColors.blue,
        tags: ['回程'],
        title: '福岡機場 → 香港',
        note: '國際線建議提早 2.5 小時到機場辦登機。',
      ),
    ],
  ),
];

/// ===== 五日一覽 =====
class DayOverview {
  final int day;
  final String date;
  final String place;
  final String text;
  const DayOverview({
    required this.day,
    required this.date,
    required this.place,
    required this.text,
  });
}

final List<DayOverview> overviews = const [
  DayOverview(day: 1, date: '5/10', place: '香港 → 博多', text: '8:00 香港出發 → 福岡機場 → 博多 Check-in → 中洲屋台晚餐'),
  DayOverview(day: 2, date: '5/11', place: '博多市區', text: '櫛田神社 → 博多拉麵 → 大濠公園 · 福岡城跡 → 天神地下街'),
  DayOverview(day: 3, date: '5/12', place: '由布院（住一晚）', text: '由布院之森 → 湯之坪街道 → 溫泉旅館一泊二食'),
  DayOverview(day: 4, date: '5/13', place: '由布院 → 博多', text: '金鱗湖晨景 → 返回博多 → 運河城購物'),
  DayOverview(day: 5, date: '5/14', place: '返香港', text: '博多站最後補貨 → 福岡機場 → 香港'),
];

/// ===== 住宿 =====
class StayInfo {
  final String emoji;
  final String name;
  final String dates;
  final String status;
  final Color color;
  final List<String> notes;
  const StayInfo({
    required this.emoji,
    required this.name,
    required this.dates,
    required this.status,
    required this.color,
    required this.notes,
  });
}

final List<StayInfo> stays = const [
  StayInfo(
    emoji: '🏨',
    name: '博多站築紫口 F 飯店',
    dates: '5/10 – 5/12（2 晚）',
    status: '待訂',
    color: AppColors.blue,
    notes: ['鄰近博多站，交通方便', '可考慮搭配 2 晚加 1 晚優惠'],
  ),
  StayInfo(
    emoji: '♨️',
    name: '湯布院山莊吾亦紅',
    dates: '5/12 – 5/13（1 晚・一泊二食）',
    status: '已訂',
    color: AppColors.green,
    notes: ['含一泊二食（晚餐 + 早餐）', '有露天風呂，可預約車站接送'],
  ),
  StayInfo(
    emoji: '🛏️',
    name: '最後一晚（博多）',
    dates: '5/13 – 5/14（1 晚）',
    status: '未定',
    color: AppColors.yellow,
    notes: ['建議揀博多站附近，方便翌日去機場', '1 月尾確定即可'],
  ),
];

/// ===== 待辦清單 =====
class TodoInfo {
  final String text;
  final String date;
  final String note;
  const TodoInfo({required this.text, required this.date, required this.note});
}

final List<TodoInfo> todos = const [
  TodoInfo(text: '訂機票（來回）', date: '—', note: '留意廉航與傳統航空價格'),
  TodoInfo(text: '訂酒店（博多 2 晚 + 最後 1 晚）', date: '—', note: '確認入住／退房時間'),
  TodoInfo(text: '預訂由布院之森指定席', date: '—', note: '熱門班次建議開放劃位即訂'),
  TodoInfo(text: '辦護照／檢查證件效期', date: '—', note: '護照需 6 個月以上效期'),
  TodoInfo(text: '買 eSIM / SIM 卡', date: '—', note: '出發前先開通測試'),
  TodoInfo(text: '兌換日幣現金', date: '—', note: '屋台與小店多收現金'),
  TodoInfo(text: '列印／存好行程與訂房憑證', date: '—', note: '存離線截圖最保險'),
];

/// ===== 記帳 / 預算 =====
class BudgetItem {
  final String category;
  final int jpy;
  final String note;
  final Color color;
  const BudgetItem({
    required this.category,
    required this.jpy,
    required this.note,
    required this.color,
  });
}

final List<BudgetItem> budgets = const [
  BudgetItem(category: '機票（來回）', jpy: 45000, note: '1 人估算，待確認', color: AppColors.blue),
  BudgetItem(category: '住宿（4 晚）', jpy: 60000, note: '博多 2 晚 + 溫泉 1 晚 + 博多 1 晚', color: AppColors.green),
  BudgetItem(category: '交通（JR / 地鐵）', jpy: 25000, note: '含由布院之森指定席', color: Color(0xFFB08968)),
  BudgetItem(category: '餐飲', jpy: 30000, note: '含旅館一泊二食', color: AppColors.coral),
  BudgetItem(category: '購物 / 伴手禮', jpy: 40000, note: '彈性調整', color: AppColors.yellow),
  BudgetItem(category: '雜支 / 備用', jpy: 10000, note: '應急用', color: AppColors.pink),
];
