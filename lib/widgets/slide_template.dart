import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';

/// Base background for all slides — dark gradient + dot grid
class SlideBackground extends StatelessWidget {
  final Widget child;

  const SlideBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, box) {
        final s = (box.maxWidth / 960).clamp(0.25, 2.5);
        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF0C1B30), Color(0xFF071320), Color(0xFF040D18)],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: CustomPaint(painter: _DotGrid(s: s)),
              ),
              child,
            ],
          ),
        );
      },
    );
  }
}

class _DotGrid extends CustomPainter {
  final double s;
  const _DotGrid({required this.s});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1E3854).withValues(alpha: 0.55)
      ..style = PaintingStyle.fill;
    final gap = 30.0 * s;
    for (double x = 0; x < size.width; x += gap) {
      for (double y = 0; y < size.height; y += gap) {
        canvas.drawCircle(Offset(x, y), 1.0, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DotGrid old) => old.s != s;
}

/// Title slide template — cover page with title, subtitle, chip
class TitleSlide extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? chip;
  final Color accentColor;

  const TitleSlide({
    super.key,
    required this.title,
    required this.subtitle,
    this.chip,
    this.accentColor = const Color(0xFF00D4AA),
  });

  @override
  State<TitleSlide> createState() => _TitleSlideState();
}

class _TitleSlideState extends State<TitleSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final chipA = _iv(0.0, 0.4);
    final titleA = _iv(0.15, 0.55);
    final lineA = _iv(0.3, 0.6);
    final subA = _iv(0.4, 0.75);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          return Center(
            child: Padding(
              padding: EdgeInsets.all(40 * s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Chip
                  if (widget.chip != null)
                    _fade(
                      chipA,
                      dy: -16,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * s,
                          vertical: 6 * s,
                        ),
                        decoration: BoxDecoration(
                          color: widget.accentColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: widget.accentColor.withValues(alpha: 0.3),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          widget.chip!,
                          style: TextStyle(
                            color: widget.accentColor,
                            fontSize: 13 * s,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 24 * s),
                  // Title
                  _fade(
                    titleA,
                    dy: 20,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 42 * s,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        height: 1.15,
                      ),
                    ),
                  ),
                  SizedBox(height: 16 * s),
                  // Divider
                  _fade(
                    lineA,
                    dy: 0,
                    child: Container(
                      width: 80 * s,
                      height: 3,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.accentColor,
                            widget.accentColor.withValues(alpha: 0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  SizedBox(height: 20 * s),
                  // Subtitle
                  _fade(
                    subA,
                    dy: 16,
                    child: Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF7B8EA2),
                        fontSize: 16 * s,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Section title slide — marks a new topic
class SectionTitleSlide extends StatefulWidget {
  final String sectionNumber;
  final String title;
  final String subtitle;
  final Color accentColor;
  final IconData? icon;

  const SectionTitleSlide({
    super.key,
    required this.sectionNumber,
    required this.title,
    required this.subtitle,
    this.accentColor = const Color(0xFF00D4AA),
    this.icon,
  });

  @override
  State<SectionTitleSlide> createState() => _SectionTitleSlideState();
}

class _SectionTitleSlideState extends State<SectionTitleSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final numA = _iv(0.0, 0.4);
    final titleA = _iv(0.15, 0.55);
    final subA = _iv(0.3, 0.7);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          return Center(
            child: Padding(
              padding: EdgeInsets.all(48 * s),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _fade(
                    numA,
                    dy: -20,
                    child: Container(
                      width: 64 * s,
                      height: 64 * s,
                      decoration: BoxDecoration(
                        color: widget.accentColor.withValues(alpha: 0.15),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: widget.accentColor.withValues(alpha: 0.4),
                          width: 1.5,
                        ),
                      ),
                      child: Center(
                        child: widget.icon != null
                            ? Icon(
                                widget.icon,
                                color: widget.accentColor,
                                size: 28 * s,
                              )
                            : Text(
                                widget.sectionNumber,
                                style: TextStyle(
                                  color: widget.accentColor,
                                  fontSize: 24 * s,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: 28 * s),
                  _fade(
                    titleA,
                    dy: 20,
                    child: Text(
                      widget.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36 * s,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  SizedBox(height: 14 * s),
                  _fade(
                    subA,
                    dy: 16,
                    child: Text(
                      widget.subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF7B8EA2),
                        fontSize: 15 * s,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Content slide — title + bullet points + optional image/widget
class ContentSlide extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<ContentItem> items;
  final Color accentColor;
  final Widget? sideWidget;

  const ContentSlide({
    super.key,
    required this.title,
    this.subtitle,
    required this.items,
    this.accentColor = const Color(0xFF00D4AA),
    this.sideWidget,
  });

  @override
  State<ContentSlide> createState() => _ContentSlideState();
}

class ContentItem {
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final bool isBold;

  const ContentItem({
    required this.text,
    this.icon,
    this.iconColor,
    this.isBold = false,
  });
}

class _ContentSlideState extends State<ContentSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final titleA = _iv(0.0, 0.35);
    final subA = _iv(0.1, 0.45);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          final hasAside = widget.sideWidget != null;

          return Padding(
            padding: EdgeInsets.fromLTRB(36 * s, 28 * s, 36 * s, 16 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fade(
                  titleA,
                  dy: -16,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32 * s,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                if (widget.subtitle != null) ...[
                  SizedBox(height: 6 * s),
                  _fade(
                    subA,
                    dy: 10,
                    child: Text(
                      widget.subtitle!,
                      style: TextStyle(
                        color: const Color(0xFF7B8EA2),
                        fontSize: 13 * s,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 20 * s),
                Expanded(
                  child: hasAside
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 55, child: _buildItems(s)),
                            SizedBox(width: 24 * s),
                            Expanded(flex: 45, child: widget.sideWidget!),
                          ],
                        )
                      : _buildItems(s),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItems(double s) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < widget.items.length; i++)
            _buildItem(widget.items[i], i, s),
        ],
      ),
    );
  }

  Widget _buildItem(ContentItem item, int index, double s) {
    final delay = 0.15 + (index * 0.06).clamp(0.0, 0.6);
    final end = (delay + 0.35).clamp(0.0, 1.0);
    final itemA = _iv(delay, end);

    return _fade(
      itemA,
      dy: 12,
      child: Padding(
        padding: EdgeInsets.only(bottom: 10 * s),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              item.icon ?? Icons.arrow_right_rounded,
              color: item.iconColor ?? widget.accentColor,
              size: 20 * s,
            ),
            SizedBox(width: 10 * s),
            Expanded(
              child: Text(
                item.text,
                style: TextStyle(
                  color: Colors.white.withValues(
                    alpha: item.isBold ? 1.0 : 0.85,
                  ),
                  fontSize: 14 * s,
                  fontWeight: item.isBold ? FontWeight.w600 : FontWeight.w400,
                  height: 1.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Code slide — title + code block with highlighting + explanation
class CodeSlide extends StatefulWidget {
  final String title;
  final String? subtitle;
  final String code;
  final String language;
  final List<String> explanationPoints;
  final Color accentColor;
  final List<int> highlightLines;

  const CodeSlide({
    super.key,
    required this.title,
    this.subtitle,
    required this.code,
    this.language = 'cpp',
    this.explanationPoints = const [],
    this.accentColor = const Color(0xFF00D4AA),
    this.highlightLines = const [],
  });

  @override
  State<CodeSlide> createState() => _CodeSlideState();
}

class _CodeSlideState extends State<CodeSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    // Import code_block locally
    final titleA = _iv(0.0, 0.3);
    final codeA = _iv(0.1, 0.55);
    final expA = _iv(0.3, 0.7);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          return Padding(
            padding: EdgeInsets.fromLTRB(36 * s, 28 * s, 36 * s, 16 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fade(
                  titleA,
                  dy: -16,
                  child: Row(
                    children: [
                      Icon(
                        Icons.code_rounded,
                        color: widget.accentColor,
                        size: 28 * s,
                      ),
                      SizedBox(width: 12 * s),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 28 * s,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                            if (widget.subtitle != null)
                              Text(
                                widget.subtitle!,
                                style: TextStyle(
                                  color: const Color(0xFF7B8EA2),
                                  fontSize: 12 * s,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 * s),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code block (60%)
                      Expanded(
                        flex: 58,
                        child: _fade(
                          codeA,
                          dy: 16,
                          child: _InlineCodeBlock(
                            code: widget.code,
                            language: widget.language,
                            highlightLines: widget.highlightLines,
                            fontSize: 12.5 * s,
                          ),
                        ),
                      ),
                      if (widget.explanationPoints.isNotEmpty) ...[
                        SizedBox(width: 20 * s),
                        // Explanation (40%)
                        Expanded(
                          flex: 42,
                          child: _fade(
                            expA,
                            dy: 20,
                            child: _buildExplanation(s),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildExplanation(double s) {
    return Container(
      padding: EdgeInsets.all(16 * s),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: widget.accentColor.withValues(alpha: 0.2),
          width: 0.5,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fluxo do código',
              style: TextStyle(
                color: widget.accentColor,
                fontSize: 14 * s,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 12 * s),
            for (int i = 0; i < widget.explanationPoints.length; i++) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 22 * s,
                    height: 22 * s,
                    margin: EdgeInsets.only(right: 10 * s),
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          color: widget.accentColor,
                          fontSize: 11 * s,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.explanationPoints[i],
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 12.5 * s,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8 * s),
            ],
          ],
        ),
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Cards slide — grid of info cards
class CardsSlide extends StatefulWidget {
  final String title;
  final String? subtitle;
  final List<InfoCardData> cards;
  final int crossAxisCount;
  final Color accentColor;

  const CardsSlide({
    super.key,
    required this.title,
    this.subtitle,
    required this.cards,
    this.crossAxisCount = 2,
    this.accentColor = const Color(0xFF00D4AA),
  });

  @override
  State<CardsSlide> createState() => _CardsSlideState();
}

class InfoCardData {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const InfoCardData({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _CardsSlideState extends State<CardsSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final titleA = _iv(0.0, 0.3);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          return Padding(
            padding: EdgeInsets.fromLTRB(36 * s, 28 * s, 36 * s, 16 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fade(
                  titleA,
                  dy: -16,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * s,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                if (widget.subtitle != null) ...[
                  SizedBox(height: 6 * s),
                  _fade(
                    _iv(0.1, 0.4),
                    dy: 10,
                    child: Text(
                      widget.subtitle!,
                      style: TextStyle(
                        color: const Color(0xFF7B8EA2),
                        fontSize: 13 * s,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
                SizedBox(height: 20 * s),
                Expanded(child: _buildGrid(s)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGrid(double s) {
    final count = widget.crossAxisCount;
    final rows = <List<InfoCardData>>[];
    for (int i = 0; i < widget.cards.length; i += count) {
      rows.add(
        widget.cards.sublist(i, (i + count).clamp(0, widget.cards.length)),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          for (int r = 0; r < rows.length; r++)
            Padding(
              padding: EdgeInsets.only(bottom: 12 * s),
              child: Row(
                children: [
                  for (int c = 0; c < rows[r].length; c++) ...[
                    if (c > 0) SizedBox(width: 12 * s),
                    Expanded(child: _buildCard(rows[r][c], r * count + c, s)),
                  ],
                  // Fill empty space
                  for (int c = rows[r].length; c < count; c++) ...[
                    SizedBox(width: 12 * s),
                    const Expanded(child: SizedBox()),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCard(InfoCardData card, int index, double s) {
    final delay = 0.15 + (index * 0.08).clamp(0.0, 0.6);
    final end = (delay + 0.35).clamp(0.0, 1.0);
    final cardA = _iv(delay, end);

    return _fade(
      cardA,
      dy: 20,
      child: Container(
        padding: EdgeInsets.all(16 * s),
        decoration: BoxDecoration(
          color: card.color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: card.color.withValues(alpha: 0.25),
            width: 0.8,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8 * s),
                  decoration: BoxDecoration(
                    color: card.color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(card.icon, color: card.color, size: 20 * s),
                ),
                SizedBox(width: 12 * s),
                Expanded(
                  child: Text(
                    card.title,
                    style: TextStyle(
                      color: card.color,
                      fontSize: 15 * s,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10 * s),
            Text(
              card.description,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 12.5 * s,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Comparison table slide
class ComparisonSlide extends StatefulWidget {
  final String title;
  final List<String> headers;
  final List<List<String>> rows;
  final Color accentColor;

  const ComparisonSlide({
    super.key,
    required this.title,
    required this.headers,
    required this.rows,
    this.accentColor = const Color(0xFF00D4AA),
  });

  @override
  State<ComparisonSlide> createState() => _ComparisonSlideState();
}

class _ComparisonSlideState extends State<ComparisonSlide>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entry;

  @override
  void initState() {
    super.initState();
    _entry = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();
  }

  @override
  void dispose() {
    _entry.dispose();
    super.dispose();
  }

  Animation<double> _iv(double a, double b) => CurvedAnimation(
    parent: _entry,
    curve: Interval(a, b, curve: Curves.easeOutCubic),
  );

  @override
  Widget build(BuildContext context) {
    final titleA = _iv(0.0, 0.3);
    final tableA = _iv(0.15, 0.6);

    return SlideBackground(
      child: LayoutBuilder(
        builder: (context, box) {
          final s = (box.maxWidth / 960).clamp(0.25, 2.5);
          return Padding(
            padding: EdgeInsets.fromLTRB(36 * s, 28 * s, 36 * s, 16 * s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _fade(
                  titleA,
                  dy: -16,
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30 * s,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                SizedBox(height: 20 * s),
                Expanded(child: _fade(tableA, dy: 16, child: _buildTable(s))),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTable(double s) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                color: widget.accentColor.withValues(alpha: 0.12),
                padding: EdgeInsets.symmetric(
                  horizontal: 16 * s,
                  vertical: 12 * s,
                ),
                child: Row(
                  children: [
                    for (int i = 0; i < widget.headers.length; i++)
                      Expanded(
                        child: Text(
                          widget.headers[i],
                          style: TextStyle(
                            color: widget.accentColor,
                            fontSize: 13 * s,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              // Rows
              for (int r = 0; r < widget.rows.length; r++)
                Container(
                  color: r.isEven
                      ? Colors.white.withValues(alpha: 0.02)
                      : Colors.transparent,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16 * s,
                    vertical: 10 * s,
                  ),
                  child: Row(
                    children: [
                      for (int c = 0; c < widget.rows[r].length; c++)
                        Expanded(
                          child: Text(
                            widget.rows[r][c],
                            style: TextStyle(
                              color: c == 0
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.75),
                              fontSize: 12 * s,
                              fontWeight: c == 0
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              height: 1.4,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fade(Animation<double> a, {double dy = 20, required Widget child}) {
    return AnimatedBuilder(
      animation: a,
      builder: (_, _) => Opacity(
        opacity: a.value.clamp(0.0, 1.0),
        child: Transform.translate(
          offset: Offset(0, dy * (1 - a.value)),
          child: child,
        ),
      ),
    );
  }
}

/// Inline code block used within slides (no import of code_block.dart needed)
class _InlineCodeBlock extends StatefulWidget {
  final String code;
  final String language;
  final List<int> highlightLines;
  final double fontSize;

  const _InlineCodeBlock({
    required this.code,
    this.language = 'cpp',
    this.highlightLines = const [],
    this.fontSize = 13,
  });

  @override
  State<_InlineCodeBlock> createState() => _InlineCodeBlockState();
}

class _InlineCodeBlockState extends State<_InlineCodeBlock> {
  bool _copied = false;

  void _copyCode() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (mounted) setState(() => _copied = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                for (final c in [0xFFFF5F56, 0xFFFFBD2E, 0xFF27C93F])
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                      color: Color(c),
                      shape: BoxShape.circle,
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    widget.language == 'cpp'
                        ? 'C++ / Arduino'
                        : widget.language.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.35),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _copyCode,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _copied ? Icons.check_rounded : Icons.copy_rounded,
                            color: _copied
                                ? const Color(0xFF30D158)
                                : Colors.white.withValues(alpha: 0.6),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _copied ? 'Copiado!' : 'Copiar',
                            style: TextStyle(
                              color: _copied
                                  ? const Color(0xFF30D158)
                                  : Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Code
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: HighlightView(
                  widget.code,
                  language: widget.language,
                  theme: _vs2015,
                  textStyle: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: widget.fontSize,
                    height: 1.5,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// VS2015 theme inline definition
const _vs2015 = {
  'root': TextStyle(
    color: Color(0xFFDCDCDC),
    backgroundColor: Color(0xFF1E1E1E),
  ),
  'keyword': TextStyle(color: Color(0xFF569CD6)),
  'built_in': TextStyle(color: Color(0xFF4EC9B0)),
  'type': TextStyle(color: Color(0xFF4EC9B0)),
  'literal': TextStyle(color: Color(0xFFB5CEA8)),
  'number': TextStyle(color: Color(0xFFB5CEA8)),
  'regexp': TextStyle(color: Color(0xFF9A5334)),
  'string': TextStyle(color: Color(0xFFD69D85)),
  'subst': TextStyle(color: Color(0xFFDCDCDC)),
  'symbol': TextStyle(color: Color(0xFFB5CEA8)),
  'class': TextStyle(color: Color(0xFF4EC9B0)),
  'function': TextStyle(color: Color(0xFFDCDCDC)),
  'title': TextStyle(color: Color(0xFF4EC9B0)),
  'params': TextStyle(color: Color(0xFFDCDCDC)),
  'comment': TextStyle(color: Color(0xFF57A64A), fontStyle: FontStyle.italic),
  'doctag': TextStyle(color: Color(0xFF608B4E)),
  'meta': TextStyle(color: Color(0xFF9B9B9B)),
  'meta-keyword': TextStyle(color: Color(0xFF569CD6)),
  'meta-string': TextStyle(color: Color(0xFFD69D85)),
  'section': TextStyle(color: Color(0xFFDCDCDC)),
  'tag': TextStyle(color: Color(0xFF569CD6)),
  'name': TextStyle(color: Color(0xFF569CD6)),
  'attr': TextStyle(color: Color(0xFF9CDCFE)),
  'attribute': TextStyle(color: Color(0xFF9CDCFE)),
  'variable': TextStyle(color: Color(0xFFBD63C5)),
  'bullet': TextStyle(color: Color(0xFFD7BA7D)),
  'code': TextStyle(color: Color(0xFFDCDCDC)),
  'emphasis': TextStyle(color: Color(0xFFDCDCDC), fontStyle: FontStyle.italic),
  'strong': TextStyle(color: Color(0xFFDCDCDC), fontWeight: FontWeight.bold),
  'formula': TextStyle(color: Color(0xFFC8C8C8), fontStyle: FontStyle.italic),
  'link': TextStyle(color: Color(0xFF569CD6)),
  'quote': TextStyle(color: Color(0xFF57A64A), fontStyle: FontStyle.italic),
  'selector-tag': TextStyle(color: Color(0xFFD7BA7D)),
  'selector-id': TextStyle(color: Color(0xFF9CDCFE)),
  'selector-class': TextStyle(color: Color(0xFFD7BA7D)),
  'selector-attr': TextStyle(color: Color(0xFF9CDCFE)),
  'selector-pseudo': TextStyle(color: Color(0xFFD7BA7D)),
  'template-tag': TextStyle(color: Color(0xFFD69D85)),
  'template-variable': TextStyle(color: Color(0xFFD69D85)),
  'addition': TextStyle(
    color: Color(0xFFDCDCDC),
    backgroundColor: Color(0xFF144212),
  ),
  'deletion': TextStyle(
    color: Color(0xFFDCDCDC),
    backgroundColor: Color(0xFF600000),
  ),
};
