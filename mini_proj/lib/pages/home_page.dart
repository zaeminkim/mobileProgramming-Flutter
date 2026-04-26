import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/neon_gauge.dart';
import '../widgets/neon_tag.dart';

class FeedItem {
  final String title;
  final String description;
  final List<String> tags;
  final double reversalScore;
  final Color accentColor;
  final IconData icon;
  const FeedItem({
    required this.title, required this.description,
    required this.tags, required this.reversalScore,
    required this.accentColor, required this.icon,
  });
}

const _feed = [
  FeedItem(title: '조선시대 궁궐 건축의 비밀', description: '당신이 몰랐던 경복궁의 숨겨진 수학적 비율과 풍수지리 이야기',
    tags: ['#역사','#건축','#한국문화'], reversalScore: 0.87, accentColor: AppColors.cyan, icon: Icons.account_balance),
  FeedItem(title: '발효 과학: 김치의 미생물학', description: '유산균이 만들어내는 맛의 교향곡',
    tags: ['#요리','#과학','#발효'], reversalScore: 0.72, accentColor: AppColors.lime, icon: Icons.science),
  FeedItem(title: '심해 탐험: 마리아나 해구', description: '빛이 닿지 않는 곳에서 발견된 생명체들의 놀라운 적응력',
    tags: ['#탐험','#자연','#해양생물'], reversalScore: 0.93, accentColor: AppColors.neonBlue, icon: Icons.water),
  FeedItem(title: '양자 컴퓨팅 입문', description: '큐비트부터 양자 얽힘까지, 미래 컴퓨터를 이해하는 가장 쉬운 방법',
    tags: ['#기술','#양자역학','#미래'], reversalScore: 0.65, accentColor: AppColors.neonGreen, icon: Icons.memory),
  FeedItem(title: '아프리카 부족의 음악 치료', description: '서양 의학이 주목하는 전통 리듬 치료법의 과학적 근거',
    tags: ['#음악','#의학','#문화'], reversalScore: 0.95, accentColor: AppColors.cyan, icon: Icons.music_note),
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pc = PageController();
  int _cur = 0;

  @override
  void dispose() { _pc.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.of(context).padding.top;
    return Stack(children: [
      PageView.builder(
        controller: _pc, scrollDirection: Axis.vertical,
        itemCount: _feed.length,
        onPageChanged: (i) => setState(() => _cur = i),
        itemBuilder: (_, i) => _Card(item: _feed[i]),
      ),
      // 상단 오버레이
      Positioned(top: top + 16, left: 20, right: 20,
        child: _TopBar(item: _feed[_cur])),
      // 하단 오버레이
      Positioned(bottom: 100, left: 20, right: 70,
        child: _BottomInfo(item: _feed[_cur])),
      // 우측 인디케이터
      Positioned(right: 12, top: 0, bottom: 0,
        child: Center(child: _Indicator(total: _feed.length, cur: _cur))),
    ]);
  }
}

class _TopBar extends StatelessWidget {
  final FeedItem item;
  const _TopBar({required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [
        ShaderMask(
          shaderCallback: (b) => AppColors.mainGradient.createShader(b),
          child: const Text('OUTFEED', style: TextStyle(color: Colors.white,
            fontSize: 22, fontWeight: FontWeight.w900, letterSpacing: 3)),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.lime.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.lime.withOpacity(0.3)),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.bolt, color: AppColors.lime, size: 14,
              shadows: [Shadow(color: AppColors.lime.withOpacity(0.5), blurRadius: 6)]),
            const SizedBox(width: 4),
            Text('탈출 모드', style: TextStyle(color: AppColors.lime, fontSize: 11,
              fontWeight: FontWeight.w600,
              shadows: [Shadow(color: AppColors.lime.withOpacity(0.4), blurRadius: 4)])),
          ]),
        ),
      ]),
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.deepNavy.withOpacity(0.75),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.neonBlue.withOpacity(0.1)),
        ),
        child: NeonGauge(value: item.reversalScore, label: '취향 반전도'),
      ),
    ]);
  }
}

class _BottomInfo extends StatelessWidget {
  final FeedItem item;
  const _BottomInfo({required this.item});
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(item.title, style: const TextStyle(color: Colors.white, fontSize: 22,
        fontWeight: FontWeight.w800, height: 1.3,
        shadows: [Shadow(color: Colors.black54, blurRadius: 10)])),
      const SizedBox(height: 8),
      Text(item.description, style: TextStyle(color: Colors.white.withOpacity(0.8),
        fontSize: 14, height: 1.5,
        shadows: const [Shadow(color: Colors.black54, blurRadius: 8)])),
      const SizedBox(height: 14),
      Wrap(spacing: 8, runSpacing: 6,
        children: item.tags.map((t) => NeonTag(text: t, color: item.accentColor)).toList()),
    ]);
  }
}

class _Card extends StatelessWidget {
  final FeedItem item;
  const _Card({required this.item});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepNavy,
      child: Stack(fit: StackFit.expand, children: [
        CustomPaint(painter: _BgPainter(c: item.accentColor)),
        Center(child: Container(
          width: 120, height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: item.accentColor.withOpacity(0.08),
            border: Border.all(color: item.accentColor.withOpacity(0.2), width: 2),
            boxShadow: [BoxShadow(color: item.accentColor.withOpacity(0.15), blurRadius: 40, spreadRadius: 10)],
          ),
          child: Icon(item.icon, size: 48, color: item.accentColor.withOpacity(0.6),
            shadows: [Shadow(color: item.accentColor.withOpacity(0.4), blurRadius: 20)]),
        )),
        Positioned(bottom: 0, left: 0, right: 0, height: 300,
          child: DecoratedBox(decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter,
              colors: [Colors.transparent, AppColors.deepNavy.withOpacity(0.8), AppColors.deepNavy],
              stops: const [0, 0.6, 1]),
          ))),
      ]),
    );
  }
}

class _BgPainter extends CustomPainter {
  final Color c;
  _BgPainter({required this.c});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..style = PaintingStyle.fill;
    p..color = AppColors.neonBlue.withOpacity(0.06)
     ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 80);
    canvas.drawCircle(Offset(size.width * 0.2, size.height * 0.2), 150, p);
    p..color = c.withOpacity(0.05)
     ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 100);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.6), 200, p);
    final lp = Paint()..color = c.withOpacity(0.03)..style = PaintingStyle.stroke
      ..strokeWidth = 1..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    for (int i = 0; i < 5; i++) {
      final y = size.height * (0.2 + i * 0.15);
      final path = Path()..moveTo(0, y)
        ..quadraticBezierTo(size.width * 0.3, y - 30 + i * 10, size.width * 0.6, y + 20)
        ..quadraticBezierTo(size.width * 0.85, y + 50, size.width, y - 10);
      canvas.drawPath(path, lp);
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _Indicator extends StatelessWidget {
  final int total, cur;
  const _Indicator({required this.total, required this.cur});
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final a = i == cur;
        return Padding(padding: const EdgeInsets.symmetric(vertical: 3),
          child: AnimatedContainer(duration: const Duration(milliseconds: 300),
            width: 4, height: a ? 24 : 8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: a ? AppColors.cyan : AppColors.textMuted.withOpacity(0.3),
              boxShadow: a ? [BoxShadow(color: AppColors.cyan.withOpacity(0.5), blurRadius: 6)] : null,
            )));
      }));
  }
}
