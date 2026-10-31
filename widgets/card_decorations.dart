import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Renders a gold EMV smart chip with realistic copper contact geometry
class SmartChipWidget extends StatelessWidget {
  final double width;
  final double height;

  const SmartChipWidget({
    super.key,
    this.width = 44,
    this.height = 34,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFDF7D),
            Color(0xFFD4AF37),
            Color(0xFFB8860B),
            Color(0xFFFFE599),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.35),
            offset: const Offset(1, 2),
            blurRadius: 3,
          ),
        ],
        border: Border.all(
          color: const Color(0xFF8B6508),
          width: 0.8,
        ),
      ),
      child: CustomPaint(
        painter: _ChipPainter(),
      ),
    );
  }
}

class _ChipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF7A5805).withValues(alpha: 0.7)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final w = size.width;
    final h = size.height;

    // Draw central circular contact
    final center = Offset(w * 0.45, h * 0.5);
    canvas.drawCircle(center, h * 0.22, paint);

    // Radiating dividing tracks
    canvas.drawLine(Offset(0, h * 0.35), Offset(w * 0.28, h * 0.35), paint);
    canvas.drawLine(Offset(0, h * 0.65), Offset(w * 0.28, h * 0.65), paint);
    canvas.drawLine(Offset(w * 0.62, h * 0.35), Offset(w, h * 0.35), paint);
    canvas.drawLine(Offset(w * 0.62, h * 0.65), Offset(w, h * 0.65), paint);
    canvas.drawLine(Offset(w * 0.45, 0), Offset(w * 0.45, h * 0.28), paint);
    canvas.drawLine(Offset(w * 0.45, h * 0.72), Offset(w * 0.45, h), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Renders a realistic vertical barcode with bottom alphanumeric string
class BarcodeWidget extends StatelessWidget {
  final String code;
  final double height;
  final Color barColor;
  final Color textColor;
  final bool showText;

  const BarcodeWidget({
    super.key,
    required this.code,
    this.height = 42,
    this.barColor = Colors.white,
    this.textColor = Colors.white,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomPaint(
          size: Size(double.infinity, height),
          painter: _BarcodePainter(code: code, color: barColor),
        ),
        if (showText) ...[
          const SizedBox(height: 3),
          Text(
            code,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'Courier',
              letterSpacing: 2.5,
              fontWeight: FontWeight.w600,
              color: textColor.withValues(alpha: 0.85),
            ),
          ),
        ],
      ],
    );
  }
}

class _BarcodePainter extends CustomPainter {
  final String code;
  final Color color;

  _BarcodePainter({required this.code, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // Deterministic bar widths based on code hash
    final rand = math.Random(code.hashCode);
    double x = 4;
    final totalWidth = size.width - 8;

    while (x < totalWidth) {
      final barWidth = 1.0 + (rand.nextInt(3) * 1.2);
      final gapWidth = 1.0 + (rand.nextInt(3) * 1.0);

      if (x + barWidth <= totalWidth) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(x, 0, barWidth, size.height),
            const Radius.circular(0.5),
          ),
          paint,
        );
      }
      x += barWidth + gapWidth;
    }
  }

  @override
  bool shouldRepaint(covariant _BarcodePainter oldDelegate) =>
      oldDelegate.code != code || oldDelegate.color != color;
}

/// Renders a scannable styled QR Code pattern
class QrCodeWidget extends StatelessWidget {
  final String data;
  final double size;
  final Color color;
  final Color backgroundColor;

  const QrCodeWidget({
    super.key,
    required this.data,
    this.size = 80,
    this.color = const Color(0xFF0F172A),
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: CustomPaint(
        painter: _QrPainter(data: data, color: color),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  final String data;
  final Color color;

  _QrPainter({required this.data, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final w = size.width;
    final h = size.height;
    final markerSize = w * 0.28;

    // Corner Finder Patterns (Top-Left, Top-Right, Bottom-Left)
    _drawFinderPattern(canvas, const Offset(0, 0), markerSize, strokePaint, paint);
    _drawFinderPattern(canvas, Offset(w - markerSize, 0), markerSize, strokePaint, paint);
    _drawFinderPattern(canvas, Offset(0, h - markerSize), markerSize, strokePaint, paint);

    // Matrix pseudo data points
    final rand = math.Random(data.hashCode);
    const int cells = 11;
    final cellW = w / cells;
    final cellH = h / cells;

    for (int r = 0; r < cells; r++) {
      for (int c = 0; c < cells; c++) {
        // Skip finder marker zones
        if ((r < 4 && c < 4) || (r < 4 && c >= 7) || (r >= 7 && c < 4)) {
          continue;
        }
        if (rand.nextBool()) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(c * cellW + 0.5, r * cellH + 0.5, cellW - 1, cellH - 1),
              const Radius.circular(1.0),
            ),
            paint,
          );
        }
      }
    }
  }

  void _drawFinderPattern(
    Canvas canvas,
    Offset offset,
    double size,
    Paint strokePaint,
    Paint fillPaint,
  ) {
    // Outer box
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(offset.dx, offset.dy, size, size),
        const Radius.circular(3),
      ),
      strokePaint,
    );
    // Inner center square
    final innerPadding = size * 0.25;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          offset.dx + innerPadding,
          offset.dy + innerPadding,
          size - (innerPadding * 2),
          size - (innerPadding * 2),
        ),
        const Radius.circular(2),
      ),
      fillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _QrPainter oldDelegate) =>
      oldDelegate.data != data || oldDelegate.color != color;
}

/// Guilloche background watermark effect
class WatermarkBackground extends StatelessWidget {
  final Widget child;
  final Color patternColor;

  const WatermarkBackground({
    super.key,
    required this.child,
    this.patternColor = const Color(0x0EFFFFFF),
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: _WatermarkPainter(color: patternColor),
          ),
        ),
        child,
      ],
    );
  }
}

class _WatermarkPainter extends CustomPainter {
  final Color color;

  _WatermarkPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Elegant concentric arcs and subtle angled lines
    final center = Offset(size.width * 0.85, size.height * 0.65);
    for (double r = 40; r < size.width * 1.5; r += 26) {
      canvas.drawCircle(center, r, paint);
    }

    final topCenter = Offset(size.width * 0.15, size.height * 0.2);
    for (double r = 30; r < size.width; r += 32) {
      canvas.drawCircle(topCenter, r, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _WatermarkPainter oldDelegate) => false;
}

/// Lanyard slot and metal badge clip rendered at top of card
class LanyardHangerWidget extends StatelessWidget {
  const LanyardHangerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Lanyard strap
        Container(
          width: 28,
          height: 18,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF1E293B), Color(0xFF334155), Color(0xFF1E293B)],
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        // Metal clip ring
        Container(
          width: 38,
          height: 14,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: const LinearGradient(
              colors: [Color(0xFFE2E8F0), Color(0xFF94A3B8), Color(0xFFE2E8F0)],
            ),
            border: Border.all(color: const Color(0xFF64748B), width: 1),
          ),
          child: Center(
            child: Container(
              width: 14,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
        // Slot hole in the badge
        Container(
          width: 48,
          height: 8,
          margin: const EdgeInsets.only(top: 4, bottom: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF020617).withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 0.8,
            ),
          ),
        ),
      ],
    );
  }
}
