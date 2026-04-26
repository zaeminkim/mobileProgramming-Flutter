import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'explore_detail_page.dart';

/// 홈 화면 — 2-Tab 레이아웃 (인사이트 / 탐험)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.of(context).padding.top;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: topPad + 16),
        // 타이틀
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('홈', style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          )),
        ),
        const SizedBox(height: 16),
        // 탭 바
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: TabBar(
              controller: _tabCtrl,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: AppColors.surfaceTertiary,
                borderRadius: BorderRadius.circular(7),
              ),
              dividerColor: Colors.transparent,
              labelColor: AppColors.textPrimary,
              unselectedLabelColor: AppColors.textTertiary,
              labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              tabs: const [
                Tab(text: '인사이트'),
                Tab(text: '탐험'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        // 탭 콘텐츠
        Expanded(
          child: TabBarView(
            controller: _tabCtrl,
            children: const [
              _InsightsTab(),
              _ExploreTab(),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Tab 1: 인사이트 — 연령/성별/직업별 알고리즘 분포
// ──────────────────────────────────────────────

class _InsightsTab extends StatelessWidget {
  const _InsightsTab();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
      children: [
        // 요약 카드
        _InsightCard(
          title: '나의 알고리즘 요약',
          child: Column(
            children: [
              _BarItem(label: '연애/관계', value: 0.62, accent: true),
              const SizedBox(height: 12),
              _BarItem(label: '먹방/요리', value: 0.21),
              const SizedBox(height: 12),
              _BarItem(label: '게임', value: 0.45),
              const SizedBox(height: 12),
              _BarItem(label: '뷰티', value: 0.15),
              const SizedBox(height: 12),
              _BarItem(label: 'ASMR', value: 0.33),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 연령별 분포
        _InsightCard(
          title: '연령별 알고리즘 분포',
          child: Column(
            children: const [
              _DistRow(label: '10대', value: '엔터테인먼트 72%', sub: '게임, 밈, 챌린지'),
              Divider(color: AppColors.separator, height: 24),
              _DistRow(label: '20대', value: '라이프스타일 58%', sub: '연애, 패션, 자기계발'),
              Divider(color: AppColors.separator, height: 24),
              _DistRow(label: '30대', value: '정보/뉴스 45%', sub: '재테크, 육아, IT'),
              Divider(color: AppColors.separator, height: 24),
              _DistRow(label: '40대+', value: '뉴스/건강 61%', sub: '시사, 건강관리, 여행'),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // 성별 분포
        _InsightCard(
          title: '성별 콘텐츠 편향',
          child: Column(
            children: const [
              _DistRow(label: '남성', value: '게임/스포츠 51%', sub: '리뷰, 하이라이트'),
              Divider(color: AppColors.separator, height: 24),
              _DistRow(label: '여성', value: '뷰티/라이프 48%', sub: '브이로그, 레시피'),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _InsightCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          )),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _BarItem extends StatelessWidget {
  final String label;
  final double value;
  final bool accent;
  const _BarItem({required this.label, required this.value, this.accent = false});

  @override
  Widget build(BuildContext context) {
    final pct = (value * 100).toInt();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: const TextStyle(
              color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
            const Spacer(),
            Text('$pct%', style: TextStyle(
              color: accent ? AppColors.white : AppColors.textSecondary,
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
                gradient: accent ? AppColors.brandGradient : null,
                color: accent ? null : AppColors.textTertiary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DistRow extends StatelessWidget {
  final String label, value, sub;
  const _DistRow({required this.label, required this.value, required this.sub});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(label, style: const TextStyle(
            color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(
                color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w500)),
              const SizedBox(height: 2),
              Text(sub, style: const TextStyle(
                color: AppColors.textTertiary, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}

// ──────────────────────────────────────────────
// Tab 2: 탐험 — Masonry 그리드 + Hero 전환
// ──────────────────────────────────────────────

class _ExploreItem {
  final String id;
  final String title;
  final String category;
  final String desc;
  final Color color;
  final double aspectRatio;
  final IconData icon;
  const _ExploreItem({
    required this.id, required this.title, required this.category,
    required this.desc, required this.color, required this.aspectRatio,
    required this.icon,
  });
}

const _exploreItems = [
  _ExploreItem(id: 'e1', title: '조선시대 궁궐 건축의 비밀',
    category: '역사', desc: '경복궁의 숨겨진 수학적 비율과 풍수지리 이야기',
    color: Color(0xFF2C3E50), aspectRatio: 1.2, icon: Icons.account_balance),
  _ExploreItem(id: 'e2', title: '발효 과학: 김치의 미생물학',
    category: '과학', desc: '유산균이 만들어내는 맛의 교향곡',
    color: Color(0xFF1B5E20), aspectRatio: 0.8, icon: Icons.science),
  _ExploreItem(id: 'e3', title: '심해 탐험: 마리아나 해구',
    category: '자연', desc: '빛이 닿지 않는 곳의 생명체들',
    color: Color(0xFF0D47A1), aspectRatio: 1.0, icon: Icons.water),
  _ExploreItem(id: 'e4', title: '양자 컴퓨팅 입문',
    category: '기술', desc: '큐비트부터 양자 얽힘까지',
    color: Color(0xFF4A148C), aspectRatio: 1.4, icon: Icons.memory),
  _ExploreItem(id: 'e5', title: '아프리카 부족의 음악 치료',
    category: '문화', desc: '전통 리듬 치료법의 과학적 근거',
    color: Color(0xFFBF360C), aspectRatio: 0.9, icon: Icons.music_note),
  _ExploreItem(id: 'e6', title: '우주 정거장의 일상',
    category: '우주', desc: 'ISS에서 보내는 하루의 모든 것',
    color: Color(0xFF263238), aspectRatio: 1.1, icon: Icons.rocket_launch),
];

class _ExploreTab extends StatelessWidget {
  const _ExploreTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverToBoxAdapter(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildColumn(context, 0)),
                const SizedBox(width: 12),
                Expanded(child: _buildColumn(context, 1)),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildColumn(BuildContext context, int col) {
    final items = <_ExploreItem>[];
    for (int i = col; i < _exploreItems.length; i += 2) {
      items.add(_exploreItems[i]);
    }
    return Column(
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _ExploreCard(item: item),
        );
      }).toList(),
    );
  }
}

class _ExploreCard extends StatelessWidget {
  final _ExploreItem item;
  const _ExploreCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => ExploreDetailPage(
              id: item.id, title: item.title, category: item.category,
              desc: item.desc, color: item.color, icon: item.icon,
            ),
            transitionsBuilder: (context, anim, secondaryAnimation, child) {
              return FadeTransition(opacity: anim, child: child);
            },
            transitionDuration: const Duration(milliseconds: 400),
          ),
        );
      },
      child: Hero(
        tag: 'explore_${item.id}',
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 160 * item.aspectRatio,
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                // 아이콘 배경
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(item.icon, size: 80,
                    color: AppColors.white.withValues(alpha: 0.06)),
                ),
                // 콘텐츠
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(item.category, style: const TextStyle(
                          color: AppColors.white, fontSize: 11,
                          fontWeight: FontWeight.w500)),
                      ),
                      const Spacer(),
                      Text(item.title, maxLines: 2, overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.white, fontSize: 15,
                          fontWeight: FontWeight.w600, height: 1.3)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
