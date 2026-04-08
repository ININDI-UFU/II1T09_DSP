import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

class CodeBlock extends StatefulWidget {
  final String code;
  final String language;
  final String? title;
  final List<int> highlightLines;
  final double fontSize;

  const CodeBlock({
    super.key,
    required this.code,
    this.language = 'cpp',
    this.title,
    this.highlightLines = const [],
    this.fontSize = 13,
  });

  @override
  State<CodeBlock> createState() => _CodeBlockState();
}

class _CodeBlockState extends State<CodeBlock> {
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
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            ),
            child: Row(
              children: [
                // Dots
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
                if (widget.title != null)
                  Expanded(
                    child: Text(
                      widget.title!,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: Text(
                      _langLabel(widget.language),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.35),
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                // Copy button
                _CopyButton(copied: _copied, onTap: _copyCode),
              ],
            ),
          ),
          // Code content
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(14),
                child: _buildHighlightedCode(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedCode() {
    if (widget.highlightLines.isEmpty) {
      return HighlightView(
        widget.code,
        language: widget.language,
        theme: vs2015Theme,
        textStyle: TextStyle(
          fontFamily: 'monospace',
          fontSize: widget.fontSize,
          height: 1.5,
        ),
        padding: EdgeInsets.zero,
      );
    }

    // With line highlighting
    final lines = widget.code.split('\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (int i = 0; i < lines.length; i++)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            color: widget.highlightLines.contains(i + 1)
                ? const Color(0xFF264F78)
                : Colors.transparent,
            child: HighlightView(
              lines[i],
              language: widget.language,
              theme: vs2015Theme,
              textStyle: TextStyle(
                fontFamily: 'monospace',
                fontSize: widget.fontSize,
                height: 1.5,
              ),
              padding: EdgeInsets.zero,
            ),
          ),
      ],
    );
  }

  String _langLabel(String lang) {
    switch (lang) {
      case 'cpp':
        return 'C++ / Arduino';
      case 'c':
        return 'C';
      case 'python':
        return 'Python';
      default:
        return lang.toUpperCase();
    }
  }
}

class _CopyButton extends StatefulWidget {
  final bool copied;
  final VoidCallback onTap;

  const _CopyButton({required this.copied, required this.onTap});

  @override
  State<_CopyButton> createState() => _CopyButtonState();
}

class _CopyButtonState extends State<_CopyButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: _hovering
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.copied ? Icons.check_rounded : Icons.copy_rounded,
                color: widget.copied
                    ? const Color(0xFF30D158)
                    : Colors.white.withValues(alpha: 0.6),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                widget.copied ? 'Copiado!' : 'Copiar',
                style: TextStyle(
                  color: widget.copied
                      ? const Color(0xFF30D158)
                      : Colors.white.withValues(alpha: 0.6),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
