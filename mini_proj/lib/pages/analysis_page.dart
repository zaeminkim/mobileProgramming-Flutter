import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 더미 오염 카테고리 데이터
class PollutionCategory {
  final String name;
  final double value;
  final Color color;
  final Offset position; // 0~1 normalized
  final double radius;
  PollutionCategory({required this.name, required this.value,
    required this.color, required this.position, required this.radius});
}

final _categories = [
  PollutionCategory(name: '연애', value: 0.62, color: const Color(0xFFFF4081),
    position: const Offset(0.25, 0.30), radius: 52),
  PollutionCategory(name: '먹방', value: 0.21, color: AppColors.lime,
    position: const Offset(0.70, 0.25), radius: 34),
  PollutionCategory(name: '게임', value: 0.45, color: AppColors.cyan,
    position: const Offset(0.55, 0.55), radius: 44),
  PollutionCategory(name: '뷰티', value: 0.15, color: const Color(0xFFE040FB),
    position: const Offset(0.20, 0.65), radius: 28),
  PollutionCategory(name: '정치', value: 0.08, color: AppColors.neonGreen,
    position: const Offset(0.78, 0.70), radius: 22),
  PollutionCategory(name: 'ASMR', value: 0.33, color: AppColors.neonBlue,
    position: const Offset(0.45, 0.38), radius: 38),
];

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});
  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with TickerProviderStateMixin {
  bool _scanned = false;
  late AnimationController _scanCtrl;
  late AnimationController _fadeCtrl;
  late Animation<double> _scanAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _scanCtrl = AnimationController(
      duration: const Duration(milliseconds: 2000), vsync: this);
    _scanAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _scanCtrl, curve: Curves.easeInOut));
    _fadeCtrl = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _scanCtrl.dispose(); _fadeCtrl.dispose(); super.dispose();
  }

  void _startScan() {
    setState(() => _scanned = false);
    _fadeCtrl.reset();
    _scanCtrl.forward(from: 0).then((_) {
      setState(() => _scanned = true);
      _fadeCtrl.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, pad.top + 20, 20, pad.bottom + 100),
      child: Column(children: [
        // 헤더
        ShaderMask(
          shaderCallback: (b) => AppColors.mainGradient.createShader(b),
          child: const Text('알고리즘 오염도 측정',
            style: TextStyle(color: Colors.white, fontSize: 24,
              fontWeight: FontWeight.w800)),
        ),
        const SizedBox(height: 6),
        const Text('소셜 미디어 스크린샷을 업로드하세요',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
        const SizedBox(height: 28),

        // 업로드 영역
        GestureDetector(
          onTap: _startScan,
          child: AnimatedBuilder(
            animation: _scanAnim,
            builder: (context, child) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _scanCtrl.isAnimating
                        ? Color.lerp(AppColors.neonBlue, AppColors.neonGreen, _scanAnim.value)!
                        : AppColors.neonBlue.withOpacity(0.2),
                    width: _scanCtrl.isAnimating ? 2 : 1),
                  boxShadow: _scanCtrl.isAnimating ? [
                    BoxShadow(
                      color: Color.lerp(AppColors.neonBlue, AppColors.neonGreen, _scanAnim.value)!.withOpacity(0.3),
                      blurRadius: 20),
                  ] : null,
                ),
                child: Stack(children: [
                  // 스캔 스위프 라인
                  if (_scanCtrl.isAnimating)
                    Positioned(
                      top: _scanAnim.value * 200,
                      left: 0, right: 0,
                      child: Container(height: 3,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent,
                              AppColors.neonGreen.withOpacity(0.8),
                              Colors.transparent]),
                          boxShadow: [BoxShadow(
                            color: AppColors.neonGreen.withOpacity(0.5),
                            blurRadius: 15, spreadRadius: 3)],
                        )),
                    ),
                  Center(child: Column(
                    mainAxisSize: MainAxisSize.min, children: [
                      Icon(_scanCtrl.isAnimating ? Icons.radar : Icons.cloud_upload_outlined,
                        color: AppColors.cyan, size: 48,
                        shadows: [Shadow(color: AppColors.cyan.withOpacity(0.4), blurRadius: 12)]),
                      const SizedBox(height: 12),
                      Text(_scanCtrl.isAnimating ? '스캔 중...' : '터치하여 스캔 시작',
                        style: TextStyle(color: AppColors.textSecondary,
                          fontSize: 14, fontWeight: FontWeight.w500)),
                    ])),
                ]),
              );
            },
          ),
        ),
        const SizedBox(height: 32),

        // 결과 시각화 (카테고리 네온 조각 맵)
        if (_scanned) ...[
          FadeTransition(opacity: _fadeAnim, child: Column(children: [
            // 오염도 점수
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: NeonDecoration.glowBox(
                glowColor: const Color(0xFFFF4081), borderRadius: 20),
              child: Column(children: [
                const Text('오염도 점수', style: TextStyle(
                  color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                ShaderMask(
                  shaderCallback: (b) => const LinearGradient(
                    colors: [Color(0xFFFF4081), AppColors.lime]).createShader(b),
                  child: const Text('62', style: TextStyle(color: Colors.white,
                    fontSize: 56, fontWeight: FontWeight.w900)),
                ),
                const SizedBox(height: 8),
                Text('"당신은 연애 콘텐츠 62% 편향 상태입니다"',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textPrimary.withOpacity(0.9),
                    fontSize: 14, fontWeight: FontWeight.w600)),
              ]),
            ),
            const SizedBox(height: 28),

            // 창의적 카테고리 맵
            SizedBox(height: 320, child: _CategoryMap()),
          ])),
        ],
      ]),
    );
  }
}

class _CategoryMap extends StatefulWidget {
  @override
  State<_CategoryMap> createState() => _CategoryMapState();
}

class _CategoryMapState extends State<_CategoryMap>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      duration: const Duration(milliseconds: 1500), vsync: this)..forward();
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        return LayoutBuilder(builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          return Stack(children: [
            // 배경 그리드 라인
            CustomPaint(size: Size(w, h), painter: _GridPainter()),
            // 카테고리 버블들
            ..._categories.map((cat) {
              final scale = Curves.elasticOut.transform(
                (_ctrl.value * 1.5).clamp(0, 1));
              final x = cat.position.dx * w - cat.radius;
              final y = cat.position.dy * h - cat.radius;
              return Positioned(left: x, top: y,
                child: Transform.scale(scale: scale,
                  child: _Bubble(cat: cat)));
            }),
          ]);
        });
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  final PollutionCategory cat;
  const _Bubble({required this.cat});
  @override
  Widget build(BuildContext context) {
    final pct = (cat.value * 100).toInt();
    return Container(
      width: cat.radius * 2, height: cat.radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: cat.color.withOpacity(0.12),
        border: Border.all(color: cat.color.withOpacity(0.4), width: 1.5),
        boxShadow: [BoxShadow(color: cat.color.withOpacity(0.2),
          blurRadius: 20, spreadRadius: 2)],
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(cat.name, style: TextStyle(color: cat.color, fontSize: 11,
          fontWeight: FontWeight.w700,
          shadows: [Shadow(color: cat.color.withOpacity(0.5), blurRadius: 4)])),
        Text('$pct%', style: TextStyle(color: cat.color.withOpacity(0.7),
          fontSize: 10, fontWeight: FontWeight.w500)),
      ]),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = AppColors.neonBlue.withOpacity(0.04)
      ..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
