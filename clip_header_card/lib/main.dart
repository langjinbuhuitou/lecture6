import 'package:flutter/material.dart';

void main() {
  runApp(const ClipHeaderApp());
}

class ClipHeaderApp extends StatelessWidget {
  const ClipHeaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clip_header_card',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2F6BFF),
        scaffoldBackgroundColor: const Color(0xFFF1F3F8),
      ),
      home: const ClipHeaderPage(),
    );
  }
}

class ClipHeaderPage extends StatelessWidget {
  const ClipHeaderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClipPath 异形头图'),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              const _IntroCard(),
              const SizedBox(height: 20),
              _ClipCard(
                title: '斜切角头图',
                subtitle: 'clipPath: _DiagonalClipper(24)',
                clipper: _DiagonalClipper(24),
                colors: const [Color(0xFF2F6BFF), Color(0xFF7C5CFF)],
                icon: Icons.auto_awesome,
                height: 190,
              ),
              const SizedBox(height: 20),
              _ClipCard(
                title: '波浪底边头图',
                subtitle: 'clipPath: _WaveClipper()',
                clipper: _WaveClipper(),
                colors: const [Color(0xFF13B58A), Color(0xFF3BD5C0)],
                icon: Icons.waves,
                height: 200,
              ),
              const SizedBox(height: 20),
              _ClipCard(
                title: '底部内凹弧形',
                subtitle: 'clipPath: _InwardArcClipper()',
                clipper: _InwardArcClipper(),
                colors: const [Color(0xFFFF8B3D), Color(0xFFFFC24B)],
                icon: Icons.local_fire_department,
                height: 190,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '独立研究任务（三）· 自定义剪裁',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1F2430),
            ),
          ),
          SizedBox(height: 8),
          Text(
            '同一个头图容器，用三个不同的 CustomClipper<Path> 剪出三种形状。'
            '每个 clipper 只重写 getClip，shouldReclip 统一返回 false。',
            style: TextStyle(fontSize: 13, height: 1.7, color: Color(0xFF5A6173)),
          ),
        ],
      ),
    );
  }
}

class _ClipCard extends StatelessWidget {
  const _ClipCard({
    required this.title,
    required this.subtitle,
    required this.clipper,
    required this.colors,
    required this.icon,
    required this.height,
  });

  final String title;
  final String subtitle;
  final CustomClipper<Path> clipper;
  final List<Color> colors;
  final IconData icon;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 头图区域：ClipPath 作用在这一层，宽度撑满卡片
          ClipPath(
            clipper: clipper,
            child: Container(
              width: double.infinity,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: Colors.white, size: 30),
                    const SizedBox(height: 10),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 6, 24, 20),
            child: Text(
              '头图本身是一个普通 Container，形状全部由 clipper 决定；'
              '换成别的 clipper，同一张卡片立刻换了个轮廓。',
              style: TextStyle(fontSize: 12.5, height: 1.7, color: Color(0xFF7A8194)),
            ),
          ),
        ],
      ),
    );
  }
}

/// 右下角斜切：底边从 70% 处斜向右下，切掉一个三角函数状的角。
class _DiagonalClipper extends CustomClipper<Path> {
  _DiagonalClipper(this.cut);

  final double cut;

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height - cut);
    path.lineTo(size.width * 0.62, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _DiagonalClipper oldClipper) => false;
}

/// 波浪底边：用两段二次贝塞尔拼出一条平滑波纹。
class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 18);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height - 46,
      size.width * 0.5,
      size.height - 18,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height + 8,
      size.width,
      size.height - 22,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/// 底部内凹弧：底边向卡片内部凹进去一段。
class _InwardArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(
      size.width * 0.5,
      size.height - 52,
      0,
      size.height,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
