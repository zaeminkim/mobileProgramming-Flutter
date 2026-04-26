import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// 분석 화면 — 카드 기반, 텍스트 + 심플 인디케이터
class AnalysisPage extends StatelessWidget {
  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return ListView(
      padding: EdgeInsets.fromLTRB(20, topPad + 16, 20, 100),
      children: [
        // 타이틀
        const Text('분석', style: TextStyle(
          color: AppColors.textPrimary,
          fontSize: 34,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.4,
        )),
        const SizedBox(height: 24),

        // 오염도 점수 카드
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Text('알고리즘 오염도', style: TextStyle(
                color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 12),
              // 점수 — 유일한 그라디언트 포인트
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppColors.brandGradient.createShader(bounds),
                child: const Text('62', style: TextStyle(
                  color: AppColors.white,
                  fontSize: 64,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -2,
                )),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceSecondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  '정보 다양성 낮음',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '"당신은 연애 콘텐츠에 62% 편향된 상태입니다"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 카테고리별 비율 카드
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('카테고리별 편향도', style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
              const SizedBox(height: 20),
              _CategoryBar(label: '연애/관계', value: 0.62, rank: 1),
              const SizedBox(height: 16),
              _CategoryBar(label: '게임', value: 0.45, rank: 2),
              const SizedBox(height: 16),
              _CategoryBar(label: 'ASMR', value: 0.33, rank: 3),
              const SizedBox(height: 16),
              _CategoryBar(label: '먹방/요리', value: 0.21, rank: 4),
              const SizedBox(height: 16),
              _CategoryBar(label: '뷰티', value: 0.15, rank: 5),
              const SizedBox(height: 16),
              _CategoryBar(label: '정치/시사', value: 0.08, rank: 6),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 코멘트 카드
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('AI 코멘트', style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
              const SizedBox(height: 12),
              _CommentItem(text: '연애 콘텐츠에 과도하게 노출되어 있습니다'),
              const Divider(color: AppColors.separator, height: 20),
              _CommentItem(text: '정치/시사 카테고리의 소비가 극히 낮습니다'),
              const Divider(color: AppColors.separator, height: 20),
              _CommentItem(text: '과학/기술 분야를 탐험해보세요'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 변화 추이 카드
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('최근 변화', style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              )),
              SizedBox(height: 16),
              _ChangeRow(label: '편향도 변화', value: '-12%', isPositive: true),
              Divider(color: AppColors.separator, height: 24),
              _ChangeRow(label: '새 카테고리 발견', value: '+3개', isPositive: true),
              Divider(color: AppColors.separator, height: 24),
              _ChangeRow(label: '평균 시청 다양성', value: '+18%', isPositive: true),
            ],
          ),
        ),
      ],
    );
  }
}

class _CategoryBar extends StatelessWidget {
  final String label;
  final double value;
  final int rank;
  const _CategoryBar({required this.label, required this.value, required this.rank});

  @override
  Widget build(BuildContext context) {
    final pct = (value * 100).toInt();
    final isTop = rank == 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
            const Spacer(),
            Text('$pct%', style: TextStyle(
              color: isTop ? AppColors.white : AppColors.textSecondary,
              fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: AppColors.surfaceTertiary,
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: value,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                gradient: isTop ? AppColors.brandGradient : null,
                color: isTop ? null : AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CommentItem extends StatelessWidget {
  final String text;
  const _CommentItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.circle, size: 6, color: AppColors.textTertiary),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(
            color: AppColors.textSecondary, fontSize: 14, height: 1.4)),
        ),
      ],
    );
  }
}

class _ChangeRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isPositive;
  const _ChangeRow({required this.label, required this.value, required this.isPositive});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: const TextStyle(
          color: AppColors.textSecondary, fontSize: 14)),
        const Spacer(),
        Text(value, style: TextStyle(
          color: isPositive ? const Color(0xFF30D158) : const Color(0xFFFF453A),
          fontSize: 15, fontWeight: FontWeight.w600)),
      ],
    );
  }
}
