import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';
import '../data/trip_data.dart';

/// 首頁 Hero：卡通動態場景 + 標題 + 倒數
class HeroCard extends StatefulWidget {
  const HeroCard({super.key});

  @override
  State<HeroCard> createState() => _HeroCardState();
}

class _HeroCardState extends State<HeroCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final daysLeft = tripInfo.start.difference(today).inDays;
    final String countdown = daysLeft > 0
        ? '$daysLeft 日後出發'
        : (daysLeft == 0 ? '今日出發！' : '旅程進行中');

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.line, width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: SizedBox(
              height: 168,
              child: AnimatedBuilder(
                animation: _c,
                builder: (context, _) =>
                    CustomPaint(painter: _ScenePainter(_c.value)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 18),
            child: Column(
              children: [
                Text(
                  tripInfo.route,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.inkSoft,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  tripInfo.title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _dateRange(),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.inkSoft,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: AppColors.sun,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFD9A93A),
                      width: 1.4,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.sun.withOpacity(0.5),
                        offset: const Offset(0, 3),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Text(
                    countdown,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF5A4410),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _dateRange() {
    final s = tripInfo.start;
    final e = tripInfo.end;
    return '${s.year}.${_two(s.month)}.${_two(s.day)} (${_weekday(s)})'
        ' ～ ${_two(e.month)}.${_two(e.day)} (${_weekday(e)})';
  }

  String _two(int v) => v < 10 ? '0$v' : '$v';

  String _weekday(DateTime d) =>
      const ['一', '二', '三', '四', '五', '六', '日'][d.weekday - 1];
}

/// 會動的卡通場景
class _ScenePainter extends CustomPainter {
  final double t; // 0.0 ~ 1.0 循環
  _ScenePainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    // 天空
    final Paint sky = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFCDE4F0), Color(0xFFF4EFE0)],
      ).createShader(Rect.fromLTWH(0, 0, w, h));
    canvas.drawRect(Rect.fromLTWH(0, 0, w, h), sky);

    // 太陽 + 旋轉光芒
    final Offset sun = Offset(w * 0.79, h * 0.28);
    final double sunR = h * 0.11;
    final Paint ray = Paint()
      ..color = AppColors.sun.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 8; i++) {
      final double a = t * 2 * math.pi + i * math.pi / 4;
      final Offset dir = Offset(math.cos(a), math.sin(a));
      canvas.drawLine(sun + dir * (sunR * 1.4), sun + dir * (sunR * 1.8), ray);
    }
    canvas.drawCircle(sun, sunR, Paint()..color = AppColors.sun);

    // 遠山
    final Path back = Path()
      ..moveTo(-w * 0.05, h)
      ..lineTo(w * 0.24, h * 0.44)
      ..lineTo(w * 0.52, h)
      ..close();
    canvas.drawPath(back, Paint()..color = AppColors.blueSoft);

    // 近山
    final Path front = Path()
      ..moveTo(w * 0.30, h)
      ..lineTo(w * 0.60, h * 0.34)
      ..lineTo(w * 0.92, h)
      ..close();
    canvas.drawPath(front, Paint()..color = AppColors.greenSoft);

    // 地面
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.74, w, h * 0.26),
      Paint()..color = const Color(0xFFE9D8B6),
    );

    // 飄動的雲
    final double cx = (t * (w + 160)) % (w + 160) - 80;
    _cloud(canvas, Offset(cx, h * 0.20), h * 0.075);
    final double cx2 = (t * (w + 220) + w * 0.6) % (w + 220) - 110;
    _cloud(canvas, Offset(cx2, h * 0.42), h * 0.055);

    // 鳥居
    _torii(canvas, Offset(w * 0.18, h * 0.90), h * 0.44);

    // 行駛中的小火车
    final double trainX = ((t * 1.2) % 1.0) * (w + 220) - 200;
    _train(canvas, Offset(trainX, h * 0.74), h * 0.18);
  }

  void _cloud(Canvas canvas, Offset p, double r) {
    final Paint paint = Paint()..color = Colors.white.withOpacity(0.92);
    canvas.drawCircle(p, r, paint);
    canvas.drawCircle(p + Offset(r * 0.95, r * 0.15), r * 0.72, paint);
    canvas.drawCircle(p + Offset(-r * 0.95, r * 0.20), r * 0.62, paint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(p.dx - r * 1.4, p.dy + r * 0.1, r * 2.8, r * 0.9),
        Radius.circular(r * 0.45),
      ),
      paint,
    );
  }

  void _torii(Canvas canvas, Offset base, double hgt) {
    final Paint red = Paint()..color = AppColors.coral;
    final double postW = hgt * 0.09;
    final double span = hgt * 0.9;
    final double left = base.dx - span / 2;
    final double top = base.dy - hgt;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left, top, postW, hgt),
        Radius.circular(postW / 2),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + span - postW, top, postW, hgt),
        Radius.circular(postW / 2),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left - postW * 0.5, top - postW * 0.8, span + postW,
            postW * 0.7),
        Radius.circular(postW * 0.3),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(left + postW * 0.2, top + hgt * 0.16, span - postW * 0.4,
            postW * 0.5),
        Radius.circular(postW * 0.2),
      ),
      red,
    );
  }

  void _train(Canvas canvas, Offset pos, double hgt) {
    final double bodyW = hgt * 2.6;
    final Paint ink = Paint()..color = AppColors.ink;

    // 車身
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(pos.dx, pos.dy, bodyW, hgt),
        Radius.circular(hgt * 0.34),
      ),
      Paint()..color = AppColors.pink,
    );
    // 車頭
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(pos.dx + bodyW * 0.68, pos.dy - hgt * 0.16, bodyW * 0.32,
            hgt * 0.92),
        Radius.circular(hgt * 0.30),
      ),
      Paint()..color = AppColors.coral,
    );
    // 腰線
    canvas.drawRect(
      Rect.fromLTWH(pos.dx, pos.dy + hgt * 0.62, bodyW, hgt * 0.1),
      Paint()..color = const Color(0xFFFDE7C9),
    );
    // 車窗
    final Paint win = Paint()..color = Colors.white.withOpacity(0.92);
    for (int i = 0; i < 3; i++) {
      final double wx = pos.dx + hgt * 0.28 + i * hgt * 0.62;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(wx, pos.dy + hgt * 0.20, hgt * 0.4, hgt * 0.3),
          Radius.circular(hgt * 0.1),
        ),
        win,
      );
    }
    // 頭燈
    canvas.drawCircle(
      Offset(pos.dx + bodyW * 0.92, pos.dy + hgt * 0.72),
      hgt * 0.09,
      Paint()..color = AppColors.sun,
    );
    // 車輪
    canvas.drawCircle(Offset(pos.dx + hgt * 0.6, pos.dy + hgt), hgt * 0.15, ink);
    canvas.drawCircle(
        Offset(pos.dx + bodyW - hgt * 0.55, pos.dy + hgt), hgt * 0.15, ink);
  }

  @override
  bool shouldRepaint(covariant _ScenePainter old) => old.t != t;
}
