import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/fullscreen_util.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/fullscreen_button.dart';
import '../slides/all_slides.dart';

const int kTotalSlides = 35;

const _kAccents = [
  Color(0xFF4FC3F7), // cyan
  Color(0xFF00D4AA), // teal
  Color(0xFFFFD93D), // yellow
  Color(0xFFA78BFA), // purple
  Color(0xFFFF6B6B), // red
];

const _kGlowPositions = [
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomRight,
  Alignment.bottomLeft,
  Alignment.topCenter,
  Alignment.centerRight,
  Alignment.bottomCenter,
  Alignment.centerLeft,
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomRight,
  Alignment.bottomLeft,
  Alignment.topCenter,
  Alignment.centerRight,
  Alignment.bottomCenter,
  Alignment.centerLeft,
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomRight,
  Alignment.bottomLeft,
  Alignment.topCenter,
  Alignment.centerRight,
  Alignment.bottomCenter,
  Alignment.centerLeft,
  Alignment.topLeft,
  Alignment.topRight,
  Alignment.bottomRight,
  Alignment.bottomLeft,
  Alignment.topCenter,
  Alignment.centerRight,
];

class PresentationScreen extends StatefulWidget {
  final int initialSlide;
  const PresentationScreen({super.key, this.initialSlide = 0});
  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen>
    with TickerProviderStateMixin {
  late int _slide;
  bool _forward = true;
  bool _isFS = false;

  late final AnimationController _glowCtrl;
  late final AnimationController _badgeCtrl;
  late final AnimationController _cornerCtrl;

  late Animation<double> _glow1;
  late Animation<double> _glow2;
  late Animation<double> _badge;
  late Animation<double> _corner;

  @override
  void initState() {
    super.initState();
    _slide = widget.initialSlide;
    _glowCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );
    _badgeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
    );
    _cornerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _rebuildAnims();
    _glowCtrl.forward();
    _badgeCtrl.forward();
    _cornerCtrl.forward();
    onFullscreenChange((v) {
      if (mounted) setState(() => _isFS = v);
    });
  }

  void _rebuildAnims() {
    _glow1 = CurvedAnimation(
      parent: _glowCtrl,
      curve: const Interval(0.0, 0.65, curve: Curves.easeOutBack),
    );
    _glow2 = CurvedAnimation(
      parent: _glowCtrl,
      curve: const Interval(0.15, 0.8, curve: Curves.easeOutBack),
    );
    _badge = CurvedAnimation(parent: _badgeCtrl, curve: Curves.easeOutBack);
    _corner = CurvedAnimation(
      parent: _cornerCtrl,
      curve: const Interval(0.1, 1.0, curve: Curves.easeOutCubic),
    );
  }

  void _goToSlide(int idx, {required bool forward}) {
    if (idx < 0 || idx >= kTotalSlides) return;
    setState(() {
      _forward = forward;
      _slide = idx;
    });
    _restartSlideAnims();
    _updateUrl(idx);
  }

  void _updateUrl(int idx) {
    Navigator.of(context).pushReplacementNamed('/${idx + 1}');
  }

  void _goTo(int idx) {
    if (idx < 0 || idx >= kTotalSlides || idx == _slide) return;
    _goToSlide(idx, forward: idx > _slide);
  }

  void _restartSlideAnims() {
    _glowCtrl.reset();
    _badgeCtrl.reset();
    _cornerCtrl.reset();
    _rebuildAnims();
    _glowCtrl.forward();
    _badgeCtrl.forward();
    _cornerCtrl.forward();
  }

  Future<void> _toggleFS() async {
    await toggleFullscreen();
    if (mounted) setState(() => _isFS = isFullscreen);
  }

  KeyEventResult _onKey(FocusNode _, KeyEvent e) {
    if (e is! KeyDownEvent) return KeyEventResult.ignored;
    final k = e.logicalKey;
    if (k == LogicalKeyboardKey.arrowRight ||
        k == LogicalKeyboardKey.arrowDown ||
        k == LogicalKeyboardKey.space) {
      _goToSlide(_slide + 1, forward: true);
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.arrowLeft || k == LogicalKeyboardKey.arrowUp) {
      _goToSlide(_slide - 1, forward: false);
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.escape && _isFS) {
      _toggleFS();
      return KeyEventResult.handled;
    }
    if (k == LogicalKeyboardKey.keyF) {
      _toggleFS();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
    _badgeCtrl.dispose();
    _cornerCtrl.dispose();
    super.dispose();
  }

  Color get _accent => _kAccents[_slide % _kAccents.length];
  Color get _accent2 => _kAccents[(_slide + 2) % _kAccents.length];

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: true,
      onKeyEvent: _onKey,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBg(),
            _buildGlows(),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 80,
              child: _buildSlides(),
            ),
            _buildCornerAccents(),
            Positioned(top: 20, left: 20, child: _buildBadge()),
            Positioned(
              top: 20,
              right: 20,
              child: FullscreenButton(isFullscreen: _isFS, onTap: _toggleFS),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                currentSlide: _slide,
                totalSlides: kTotalSlides,
                onPrev: () => _goToSlide(_slide - 1, forward: false),
                onNext: () => _goToSlide(_slide + 1, forward: true),
                onJump: _goTo,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBg() {
    final centers = [
      const Alignment(-0.7, -0.5),
      const Alignment(0.6, -0.4),
      const Alignment(-0.2, 0.6),
      const Alignment(0.5, 0.5),
      const Alignment(0.0, -0.8),
    ];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: centers[_slide % centers.length],
          radius: 1.6,
          colors: [
            _accent.withValues(alpha: 0.14),
            _accent2.withValues(alpha: 0.04),
            Colors.black,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    );
  }

  Widget _buildGlows() {
    final pos1 = _kGlowPositions[_slide];
    final pos2 = _kGlowPositions[(_slide + 4) % _kGlowPositions.length];
    return AnimatedBuilder(
      animation: _glowCtrl,
      builder: (context, _) {
        final t1 = _glow1.value;
        final t2 = _glow2.value;
        return IgnorePointer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: pos1,
                child: Opacity(
                  opacity: (t1 * 0.65).clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.2 + t1 * 0.8,
                    child: _GlowBlob(color: _accent, size: 480),
                  ),
                ),
              ),
              Align(
                alignment: pos2,
                child: Opacity(
                  opacity: (t2 * 0.45).clamp(0.0, 1.0),
                  child: Transform.scale(
                    scale: 0.2 + t2 * 0.8,
                    child: _GlowBlob(color: _accent2, size: 360),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSlides() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 780),
      transitionBuilder: (child, anim) {
        final key = child.key as ValueKey<int>;
        final incoming = key.value == _slide;
        return _buildTransition(child, anim, incoming, _forward);
      },
      child: KeyedSubtree(
        key: ValueKey<int>(_slide),
        child: buildSlide(_slide),
      ),
    );
  }

  Widget _buildTransition(
    Widget child,
    Animation<double> anim,
    bool incoming,
    bool fwd,
  ) {
    if (incoming) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(parent: anim, curve: const Interval(0, 0.45)),
        ),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(fwd ? 1.15 : -1.15, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutQuart)),
          child: child,
        ),
      );
    }
    return FadeTransition(
      opacity: anim,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset(fwd ? -0.12 : 0.12, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeInQuart)),
        child: child,
      ),
    );
  }

  Widget _buildCornerAccents() {
    return AnimatedBuilder(
      animation: _cornerCtrl,
      builder: (context, _) {
        final t = _corner.value;
        final color = _accent.withValues(alpha: t * 0.7);
        return IgnorePointer(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 8 + (1 - t) * -30,
                left: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(color: color, quadrant: 0),
                ),
              ),
              Positioned(
                top: 8 + (1 - t) * -30,
                right: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(color: color, quadrant: 1),
                ),
              ),
              Positioned(
                bottom: 88 + (1 - t) * -30,
                left: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(color: color, quadrant: 2),
                ),
              ),
              Positioned(
                bottom: 88 + (1 - t) * -30,
                right: 8 + (1 - t) * -30,
                child: Opacity(
                  opacity: t.clamp(0.0, 1.0),
                  child: _Corner(color: color, quadrant: 3),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge() {
    return AnimatedBuilder(
      animation: _badgeCtrl,
      builder: (context, _) {
        final t = _badge.value;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(-20 * (1 - t), 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.14),
                      width: 0.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 350),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _accent,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: _accent.withValues(alpha: 0.8),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${_slide + 1} / $kTotalSlides',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double size;
  const _GlowBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.55),
            blurRadius: size * 0.55,
            spreadRadius: size * 0.15,
          ),
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: size * 0.9,
            spreadRadius: size * 0.3,
          ),
        ],
      ),
    );
  }
}

class _Corner extends StatelessWidget {
  final Color color;
  final int quadrant;
  const _Corner({required this.color, required this.quadrant});

  @override
  Widget build(BuildContext context) {
    final flipX = quadrant == 1 || quadrant == 3;
    final flipY = quadrant == 2 || quadrant == 3;
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.diagonal3Values(
        flipX ? -1.0 : 1.0,
        flipY ? -1.0 : 1.0,
        1.0,
      ),
      child: SizedBox(
        width: 28,
        height: 28,
        child: CustomPaint(painter: _CornerPainter(color: color)),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  const _CornerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, 0), Offset(0, size.height), paint);
    canvas.drawLine(Offset(0, 0), Offset(size.width, 0), paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => old.color != color;
}
