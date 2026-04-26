import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 취향 반전도 네온 게이지 위젯
class NeonGauge extends StatefulWidget {
  final double value; // 0.0 ~ 1.0
  final String label;

  const NeonGauge({
    super.key,
    required this.value,
    this.label = '취향 반전도',
  });

  @override
  State<NeonGauge> createState() => _NeonGaugeState();
}

class _NeonGaugeState extends State<NeonGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(NeonGauge oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final val = _animation.value;
        final percent = (val * 100).toInt();
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.swap_horiz_rounded,
                  color: AppColors.cyan,
                  size: 16,
                  shadows: [
                    Shadow(
                      color: AppColors.cyan.withOpacity(0.6),
                      blurRadius: 8,
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Text(
                  widget.label,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  '$percent%',
                  style: TextStyle(
                    color: Color.lerp(AppColors.neonBlue, AppColors.neonGreen, val),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(
                        color: Color.lerp(
                          AppColors.neonBlue,
                          AppColors.neonGreen,
                          val,
                        )!
                            .withOpacity(0.5),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              height: 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: AppColors.cardDark,
              ),
              child: Stack(
                children: [
                  FractionallySizedBox(
                    widthFactor: val,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        gradient: LinearGradient(
                          colors: [AppColors.neonBlue, AppColors.neonGreen],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.lerp(
                              AppColors.neonBlue,
                              AppColors.neonGreen,
                              val,
                            )!
                                .withOpacity(0.6),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

/// 원형 네온 게이지 (프로필 대시보드용)
class CircularNeonGauge extends StatefulWidget {
  final double value;
  final String label;
  final String centerText;
  final double size;
  final Color startColor;
  final Color endColor;

  const CircularNeonGauge({
    super.key,
    required this.value,
    required this.label,
    this.centerText = '',
    this.size = 100,
    this.startColor = AppColors.neonBlue,
    this.endColor = AppColors.neonGreen,
  });

  @override
  State<CircularNeonGauge> createState() => _CircularNeonGaugeState();
}

class _CircularNeonGaugeState extends State<CircularNeonGauge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: widget.size,
              height: widget.size,
              child: CustomPaint(
                painter: _CircularGaugePainter(
                  value: _animation.value,
                  startColor: widget.startColor,
                  endColor: widget.endColor,
                ),
                child: Center(
                  child: Text(
                    widget.centerText.isNotEmpty
                        ? widget.centerText
                        : '${(_animation.value * 100).toInt()}%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: widget.size * 0.22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _CircularGaugePainter extends CustomPainter {
  final double value;
  final Color startColor;
  final Color endColor;

  _CircularGaugePainter({
    required this.value,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 12) / 2;
    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * value;

    // 배경 트랙
    final bgPaint = Paint()
      ..color = AppColors.cardDarkLight
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);

    // 그라디언트 아크
    if (value > 0) {
      final rect = Rect.fromCircle(center: center, radius: radius);
      final gradient = SweepGradient(
        startAngle: startAngle,
        endAngle: startAngle + sweepAngle,
        colors: [startColor, endColor],
        transform: const GradientRotation(-math.pi / 2),
      );
      final arcPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 6
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(rect, startAngle, sweepAngle, false, arcPaint);

      // 글로우 효과
      final glowPaint = Paint()
        ..shader = gradient.createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      canvas.drawArc(rect, startAngle, sweepAngle, false, glowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _CircularGaugePainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
