import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/neon_gauge.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pad = MediaQuery.of(context).padding;
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(20, pad.top + 20, 20, pad.bottom + 100),
      child: Column(children: [
        // 프로필 아바타
        Container(
          width: 88, height: 88,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppColors.mainGradient,
            boxShadow: [
              BoxShadow(color: AppColors.neonBlue.withOpacity(0.3), blurRadius: 20),
              BoxShadow(color: AppColors.neonGreen.withOpacity(0.2), blurRadius: 20),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(3),
            child: CircleAvatar(
              backgroundColor: AppColors.deepNavy,
              child: Icon(Icons.person, size: 40, color: AppColors.textSecondary),
            ),
          ),
        ),
        const SizedBox(height: 14),
        const Text('탈출자 #2847', style: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700)),
        const SizedBox(height: 4),
        Text('알고리즘 탈출 14일째', style: TextStyle(
          color: AppColors.cyan.withOpacity(0.8), fontSize: 13, fontWeight: FontWeight.w500)),
        const SizedBox(height: 28),

        // 대시보드 위젯
        Container(
          padding: const EdgeInsets.all(20),
          decoration: NeonDecoration.glowBox(
            glowColor: AppColors.neonBlue, borderRadius: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(Icons.dashboard_outlined, color: AppColors.cyan, size: 18,
                shadows: [Shadow(color: AppColors.cyan.withOpacity(0.5), blurRadius: 6)]),
              const SizedBox(width: 8),
              const Text('편향도 대시보드', style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700)),
            ]),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: const [
              CircularNeonGauge(value: 0.62, label: '연애',
                size: 80, startColor: Color(0xFFFF4081), endColor: Color(0xFFFF80AB)),
              CircularNeonGauge(value: 0.45, label: '게임',
                size: 80, startColor: AppColors.cyan, endColor: AppColors.neonBlue),
              CircularNeonGauge(value: 0.21, label: '먹방',
                size: 80, startColor: AppColors.lime, endColor: AppColors.neonGreen),
            ]),
            const SizedBox(height: 20),
            // 요약 통계
            _StatRow(icon: Icons.trending_down, label: '편향도 변화', value: '-12%',
              color: AppColors.neonGreen),
            const SizedBox(height: 10),
            _StatRow(icon: Icons.explore, label: '새 카테고리 발견', value: '7개',
              color: AppColors.cyan),
            const SizedBox(height: 10),
            _StatRow(icon: Icons.local_fire_department, label: '탈출 연속일', value: '14일',
              color: AppColors.lime),
          ]),
        ),
        const SizedBox(height: 32),

        // 알고리즘 정체성 공유 버튼
        GestureDetector(
          onTap: () => _showShareSheet(context),
          child: Container(
            width: double.infinity, height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: AppColors.mainGradient,
              boxShadow: [
                BoxShadow(color: AppColors.neonBlue.withOpacity(0.3),
                  blurRadius: 20, offset: const Offset(-4, 4)),
                BoxShadow(color: AppColors.neonGreen.withOpacity(0.3),
                  blurRadius: 20, offset: const Offset(4, 4)),
              ],
            ),
            child: const Center(child: Row(
              mainAxisSize: MainAxisSize.min, children: [
                Icon(Icons.share, color: Colors.white, size: 20),
                SizedBox(width: 10),
                Text('알고리즘 정체성 공유', style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700,
                  letterSpacing: 0.5)),
              ],
            )),
          ),
        ),
        const SizedBox(height: 24),

        // 추가 설정 링크들
        _SettingTile(icon: Icons.tune, label: '관심사 재설정', color: AppColors.cyan),
        const SizedBox(height: 10),
        _SettingTile(icon: Icons.history, label: '탈출 히스토리', color: AppColors.lime),
        const SizedBox(height: 10),
        _SettingTile(icon: Icons.notifications_outlined, label: '알림 설정',
          color: AppColors.neonGreen),
      ]),
    );
  }

  void _showShareSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _ShareBottomSheet(),
    );
  }
}

class _StatRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _StatRow({required this.icon, required this.label,
    required this.value, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, color: color, size: 18,
        shadows: [Shadow(color: color.withOpacity(0.4), blurRadius: 6)]),
      const SizedBox(width: 10),
      Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
      const Spacer(),
      Text(value, style: TextStyle(color: color, fontSize: 14,
        fontWeight: FontWeight.w700,
        shadows: [Shadow(color: color.withOpacity(0.4), blurRadius: 4)])),
    ]);
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _SettingTile({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: AppColors.textPrimary,
          fontSize: 14, fontWeight: FontWeight.w500)),
        const Spacer(),
        Icon(Icons.chevron_right, color: AppColors.textMuted, size: 20),
      ]),
    );
  }
}

class _ShareBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 40),
          decoration: BoxDecoration(
            color: AppColors.cardDark.withOpacity(0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border(top: BorderSide(
              color: AppColors.neonBlue.withOpacity(0.2), width: 1)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            // 핸들
            Container(width: 40, height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (b) => AppColors.mainGradient.createShader(b),
              child: const Text('정체성 공유하기', style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800)),
            ),
            const SizedBox(height: 8),
            const Text('나의 알고리즘 탈출 여정을 공유하세요',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 28),
            _ShareOption(icon: Icons.qr_code_2, label: 'QR 코드 생성',
              desc: '친구가 바로 스캔할 수 있어요', color: AppColors.cyan),
            const SizedBox(height: 12),
            _ShareOption(icon: Icons.camera_alt, label: '인스타 스토리 공유',
              desc: '스토리에 카드를 공유해요', color: AppColors.lime),
            const SizedBox(height: 12),
            _ShareOption(icon: Icons.people_outline, label: '앱 커뮤니티 공유',
              desc: '탈출자 커뮤니티에 게시해요', color: AppColors.neonGreen),
          ]),
        ),
      ),
    );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label, desc;
  final Color color;
  const _ShareOption({required this.icon, required this.label,
    required this.desc, required this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.15)),
      ),
      child: Row(children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.12),
            border: Border.all(color: color.withOpacity(0.3)),
          ),
          child: Icon(icon, color: color, size: 22,
            shadows: [Shadow(color: color.withOpacity(0.4), blurRadius: 8)]),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(label, style: TextStyle(color: color, fontSize: 15,
              fontWeight: FontWeight.w700)),
            const SizedBox(height: 2),
            Text(desc, style: const TextStyle(
              color: AppColors.textMuted, fontSize: 12)),
          ])),
        Icon(Icons.arrow_forward_ios, color: color.withOpacity(0.5), size: 16),
      ]),
    );
  }
}
