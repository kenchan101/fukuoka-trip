import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme.dart';

/// 行程卡通圖標的種類
enum CartoonKind {
  plane,
  train,
  torii,
  onsen,
  hotel,
  ramen,
  shopping,
  camera,
  star,
}

/// 由中文分類對應到卡通圖
CartoonKind cartoonKindFromCategory(String category) {
  switch (category) {
    case '航班':
    case '飛機':
      return CartoonKind.plane;
    case '特急':
    case '交通':
    case 'JR':
      return CartoonKind.train;
    case '景點':
    case '神社':
      return CartoonKind.camera;
    case '溫泉旅館':
    case '溫泉':
      return CartoonKind.onsen;
    case '住宿':
    case '酒店':
      return CartoonKind.hotel;
    case '美食':
    case '餐廳':
      return CartoonKind.ramen;
    case '購物':
    case '伴手禮':
      return CartoonKind.shopping;
    default:
      return CartoonKind.star;
  }
}

/// 卡通圖標：圓角色塊 + 手繪插畫（會輕輕上下郁動）
class CartoonIcon extends StatefulWidget {
  final String category;
  final double size;
  final Color color;
  const CartoonIcon({
    super.key,
    required this.category,
    this.size = 46,
    required this.color,
  });

  @override
  State<CartoonIcon> createState() => _CartoonIconState();
}

class _CartoonIconState extends State<CartoonIcon>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CartoonKind kind = cartoonKindFromCategory(widget.category);
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.14),
        borderRadius: BorderRadius.circular(widget.size * 0.32),
        border: Border.all(color: widget.color.withOpacity(0.35), width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.size * 0.32),
        child: AnimatedBuilder(
          animation: _c,
          builder: (context, _) => CustomPaint(
            painter: _CartoonPainter(kind, widget.color, _c.value),
          ),
        ),
      ),
    );
  }
}

class _CartoonPainter extends CustomPainter {
  final CartoonKind kind;
  final Color color;
  final double t;
  const _CartoonPainter(this.kind, this.color, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final double d = size.shortestSide;
    final double phase = kind.index * 0.9;
    final double bob = math.sin(t * 2 * math.pi + phase) * (d * 0.03);

    canvas.save();
    canvas.translate(0, bob);

    switch (kind) {
      case CartoonKind.plane:
        _plane(canvas, d);
        break;
      case CartoonKind.train:
        _train(canvas, d);
        break;
      case CartoonKind.torii:
        _torii(canvas, d);
        break;
      case CartoonKind.onsen:
        _onsen(canvas, d);
        break;
      case CartoonKind.hotel:
        _bed(canvas, d);
        break;
      case CartoonKind.ramen:
        _ramen(canvas, d);
        break;
      case CartoonKind.shopping:
        _shopping(canvas, d);
        break;
      case CartoonKind.camera:
        _camera(canvas, d);
        break;
      case CartoonKind.star:
        _star(canvas, d);
        break;
    }

    canvas.restore();
  }

  void _plane(Canvas canvas, double d) {
    final Path body = Path()
      ..moveTo(d * 0.10, d * 0.54)
      ..lineTo(d * 0.90, d * 0.14)
      ..lineTo(d * 0.52, d * 0.90)
      ..lineTo(d * 0.44, d * 0.60)
      ..close();
    canvas.drawPath(body, Paint()..color = color);

    final Path under = Path()
      ..moveTo(d * 0.44, d * 0.60)
      ..lineTo(d * 0.90, d * 0.14)
      ..lineTo(d * 0.52, d * 0.90)
      ..close();
    canvas.drawPath(under, Paint()..color = color.withOpacity(0.5));
  }

  void _train(Canvas canvas, double d) {
    final double x = d * 0.13;
    final double y = d * 0.34;
    final double bodyW = d * 0.60;
    final double bodyH = d * 0.34;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, bodyW, bodyH),
        Radius.circular(d * 0.10),
      ),
      Paint()..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            x + bodyW * 0.60, y - d * 0.07, bodyW * 0.48, bodyH * 0.98),
        Radius.circular(d * 0.09),
      ),
      Paint()..color = color.withOpacity(0.72),
    );

    final Paint win = Paint()..color = Colors.white.withOpacity(0.92);
    for (int i = 0; i < 2; i++) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + d * 0.07 + i * d * 0.21, y + d * 0.08, d * 0.14,
              d * 0.12),
          Radius.circular(d * 0.03),
        ),
        win,
      );
    }

    final Paint wheel = Paint()..color = AppColors.ink;
    canvas.drawCircle(Offset(x + d * 0.16, y + bodyH), d * 0.06, wheel);
    canvas.drawCircle(
        Offset(x + bodyW - d * 0.08, y + bodyH), d * 0.06, wheel);
  }

  void _torii(Canvas canvas, double d) {
    final Paint red = Paint()..color = color;
    final double postW = d * 0.10;
    final double span = d * 0.62;
    final double top = d * 0.24;
    final double baseY = d * 0.86;
    const double left = 0;
    final double x = d * 0.19 + left;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x, top, postW, baseY - top),
        Radius.circular(postW / 2),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + span - postW, top, postW, baseY - top),
        Radius.circular(postW / 2),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x - postW * 0.6, top - postW * 0.7, span + postW * 1.2,
            postW * 0.62),
        Radius.circular(postW * 0.3),
      ),
      red,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(x + postW * 0.2, top + (baseY - top) * 0.18,
            span - postW * 0.4, postW * 0.45),
        Radius.circular(postW * 0.2),
      ),
      red,
    );
  }

  void _onsen(Canvas canvas, double d) {
    canvas.drawOval(
      Rect.fromLTWH(d * 0.14, d * 0.58, d * 0.72, d * 0.26),
      Paint()..color = color,
    );
    canvas.drawOval(
      Rect.fromLTWH(d * 0.22, d * 0.625, d * 0.56, d * 0.14),
      Paint()..color = Colors.white.withOpacity(0.35),
    );
    canvas.drawCircle(
      Offset(d * 0.80, d * 0.64),
      d * 0.07,
      Paint()..color = AppColors.inkSoft,
    );
    _steam(canvas, d, 0.5, 0.24, 0.58);
  }

  void _bed(Canvas canvas, double d) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.13, d * 0.32, d * 0.11, d * 0.42),
        Radius.circular(d * 0.05),
      ),
      Paint()..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.19, d * 0.56, d * 0.68, d * 0.22),
        Radius.circular(d * 0.08),
      ),
      Paint()..color = color.withOpacity(0.85),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.53, d * 0.56, d * 0.34, d * 0.22),
        Radius.circular(d * 0.08),
      ),
      Paint()..color = color.withOpacity(0.5),
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.24, d * 0.50, d * 0.20, d * 0.11),
        Radius.circular(d * 0.05),
      ),
      Paint()..color = Colors.white,
    );
    final Paint leg = Paint()..color = AppColors.inkSoft;
    canvas.drawRect(Rect.fromLTWH(d * 0.20, d * 0.78, d * 0.05, d * 0.07), leg);
    canvas.drawRect(Rect.fromLTWH(d * 0.80, d * 0.78, d * 0.05, d * 0.07), leg);
  }

  void _ramen(Canvas canvas, double d) {
    final Path bowl = Path()
      ..moveTo(d * 0.16, d * 0.50)
      ..lineTo(d * 0.84, d * 0.50)
      ..quadraticBezierTo(d * 0.82, d * 0.88, d * 0.50, d * 0.88)
      ..quadraticBezierTo(d * 0.18, d * 0.88, d * 0.16, d * 0.50)
      ..close();
    canvas.drawPath(bowl, Paint()..color = color);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.12, d * 0.46, d * 0.76, d * 0.09),
        Radius.circular(d * 0.045),
      ),
      Paint()..color = color.withOpacity(0.65),
    );
    canvas.drawCircle(
        Offset(d * 0.40, d * 0.505), d * 0.055, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset(d * 0.58, d * 0.505), d * 0.055, Paint()..color = AppColors.yellow);
    _steam(canvas, d, 0.5, 0.20, 0.46);
  }

  void _shopping(Canvas canvas, double d) {
    canvas.drawArc(
      Rect.fromLTWH(d * 0.34, d * 0.18, d * 0.32, d * 0.32),
      math.pi,
      math.pi,
      false,
      Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = d * 0.05
        ..strokeCap = StrokeCap.round,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.21, d * 0.40, d * 0.58, d * 0.44),
        Radius.circular(d * 0.08),
      ),
      Paint()..color = color,
    );
    final Paint stripe = Paint()..color = Colors.white.withOpacity(0.45);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.36, d * 0.40, d * 0.035, d * 0.44),
        Radius.circular(d * 0.02),
      ),
      stripe,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.61, d * 0.40, d * 0.035, d * 0.44),
        Radius.circular(d * 0.02),
      ),
      stripe,
    );
  }

  void _camera(Canvas canvas, double d) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.16, d * 0.32, d * 0.68, d * 0.44),
        Radius.circular(d * 0.10),
      ),
      Paint()..color = color,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(d * 0.34, d * 0.24, d * 0.24, d * 0.13),
        Radius.circular(d * 0.05),
      ),
      Paint()..color = color.withOpacity(0.75),
    );
    canvas.drawCircle(
        Offset(d * 0.50, d * 0.54), d * 0.14, Paint()..color = Colors.white);
    canvas.drawCircle(Offset(d * 0.50, d * 0.54), d * 0.09,
        Paint()..color = AppColors.ink.withOpacity(0.7));
    canvas.drawCircle(
        Offset(d * 0.46, d * 0.50), d * 0.03, Paint()..color = Colors.white);
    canvas.drawCircle(
        Offset(d * 0.73, d * 0.40), d * 0.03, Paint()..color = Colors.white);
  }

  void _star(Canvas canvas, double d) {
    final Path star = Path()
      ..moveTo(d * 0.5, d * 0.16)
      ..quadraticBezierTo(d * 0.55, d * 0.45, d * 0.84, d * 0.5)
      ..quadraticBezierTo(d * 0.55, d * 0.55, d * 0.5, d * 0.84)
      ..quadraticBezierTo(d * 0.45, d * 0.55, d * 0.16, d * 0.5)
      ..quadraticBezierTo(d * 0.45, d * 0.45, d * 0.5, d * 0.16)
      ..close();
    canvas.drawPath(star, Paint()..color = color);
  }

  /// 上升的蒸氣
  void _steam(
      Canvas canvas, double d, double cx, double topY, double bottomY) {
    for (int i = 0; i < 3; i++) {
      final double off = (t + i * 0.33) % 1.0;
      final double x = d * cx + (i - 1) * d * 0.15;
      final double y = d * (bottomY - off * (bottomY - topY));
      final Path p = Path()
        ..moveTo(x, y)
        ..cubicTo(x - d * 0.05, y - d * 0.04, x + d * 0.05, y - d * 0.08, x,
            y - d * 0.12);
      canvas.drawPath(
        p,
        Paint()
          ..color = color.withOpacity(0.35 + 0.5 * (1 - off))
          ..style = PaintingStyle.stroke
          ..strokeWidth = d * 0.035
          ..strokeCap = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CartoonPainter old) =>
      old.t != t || old.kind != kind || old.color != color;
}
